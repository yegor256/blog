---
layout: post
title: "Custom Pygments Lexer in Jekyll"
date: 2014-06-22
tags: jekyll lexer pygments
description:
  Sometimes you want to have your own syntax highlighting
  lexer in Jekyll, this article explains how
keywords:
  - jekyll pygments
  - jekyll lexer pygments
  - custom lexer pygments jekyll
---

I needed to create a custom syntax highlighting for
www.requs.org and I'm using Jekyll for site rendering.
This is how my code blocks look in markdown pages:

{% highlight liquid %}
{% highlight requs %}
User is a "human being".
{% endhighlight %}
{% endhighlight %}

I created a custom Pygments lexer:

{% highlight python %}
from pygments.lexer import RegexLexer
from pygments.token import Punctuation, Text, Keyword, Name, String
from pygments.util import shebang_matches
class RequsLexer(RegexLexer):
  name = 'requs'
  aliases = ['requs']
  tokens = {
    'root': [
      (r'"[^"]+"', String),
      (r'""".+"""', Text),
      (r'\b(needs|includes|requires|when|fail|since|must|is|a|the)\s*\b', Keyword),
      (r'([A-Z][a-z]+)+', Name),
      (r'[,;:]', Punctuation),
    ],
  }
  def analyse_text(text):
    return shebang_matches(text, r'requs')
{% endhighlight %}

Then I packaged it for `easy_install` and installed locally:

{% highlight bash %}
$ easy_install src/requs_pygment
Processing requs_pygment
Running setup.py -q bdist_egg --dist-dir /Volumes/ssd2/code/requs/src/requs_pygment/egg-dist-tmp-ISj8Nx
zip_safe flag not set; analyzing archive contents...
Adding requs-pygment 0.1 to easy-install.pth file
Installed /Library/Python/2.7/site-packages/requs_pygment-0.1-py2.7.egg
Processing dependencies for requs-pygment==0.1
Finished processing dependencies for requs-pygment==0.1
{% endhighlight %}

It's done. Now I run `jekyll build` and my syntax is
highlighted according to my custom rules, specified
in the lexer.

