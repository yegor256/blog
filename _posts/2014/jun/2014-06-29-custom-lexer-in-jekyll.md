---
layout: post
title: "Custom Pygments Lexer in Jekyll"
date: 2014-06-29
tags: jekyll pygments
description: |
  Sometimes, you want to have your own syntax highlighting
  lexer in Jekyll, this article explains how to do it.
keywords:
  - jekyll pygments
  - jekyll lexer pygments
  - custom lexer pygments jekyll
  - jekyll pygments custom
  - how to use custom pygments in jekyll
---

I needed to create a custom syntax highlighting
for [requs.org](http://www.requs.org)
on which I'm using Jekyll for site rendering.

This is how my code blocks look in markdown pages:

```text
{ % highlight requs %}
User is a "human being."
{ % endhighlight %}
```

I created a custom [Pygments lexer](http://pygments.org/docs/lexerdevelopment/):

<!--more-->

```python
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
      (r'\b(needs|includes|requires|when|fail|is|a|the)\s*\b', Keyword),
      (r'([A-Z][a-z]+)+', Name),
      (r'[,;:]', Punctuation),
    ],
  }
  def analyse_text(text):
    return shebang_matches(text, r'requs')
```

Then, I packaged it for [`easy_install`](https://pypi.python.org/pypi/setuptools)
and installed locally:

```bash
$ easy_install src/requs_pygment
Processing requs_pygment
Running setup.py -q bdist_egg --dist-dir ...
zip_safe flag not set; analyzing archive contents...
Adding requs-pygment 0.1 to easy-install.pth file
Installed /Library/Python/2.7/site-packages/requs_pygment-0.1-py2.7.egg
Processing dependencies for requs-pygment==0.1
Finished processing dependencies for requs-pygment==0.1
```

It's done. Now I run `jekyll build` and my syntax
is highlighted according to the custom rules I specified in the lexer.

