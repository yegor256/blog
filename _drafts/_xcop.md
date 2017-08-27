---
layout: post
title: "XCOP &mdash; XML Style Checker"
date: 2017-08-29
place: Odessa, Ukraine
tags: xml
description: |
  When XML documents are consistently formatted it's easier
  to read them and maintain; xcop is a command line static
  analizer that will ensure exactly that.
keywords:
  - xml formatting
  - xml style check
  - check style of xml
  - validate xml formatting
  - style check xml document
---

One of the biggest advantages of XML versus
[many other]({% pst 2015/nov/2015-11-16-json-vs-xml %}) data formats is that
it is human-readable. Well, to some extend, you may say. Indeed, a badly
formatted XML document may be rather difficult to digest. I'm not talking about
XML [validity](https://en.wikipedia.org/wiki/Well-formed_document)
now, but about its formatting style. Just like we format our
Java/Ruby/Python nicely and then check their "prettiness" with static analyzers,
we can check our XML documents. Six years ago I asked StackOverflow community
for such a tool, but
[my question](https://stackoverflow.com/questions/6091873/)
unfortunately was down-voted and closed
(you will need 10K+ reputation to see it).
Last week I finally decided to create such a tool and called it
[xcop](https://github.com/yegor256/xcop).

<!--more-->

It's a very simple command line
[Ruby gem](https://rubygems.org/gems/xcop).
First, you install it:

{% highlight bash %}
$ gem install xcop
{% endhighlight %}

And then you ask it to check your XML file, say `pom.xml`:

{% highlight bash %}
$ xcop pom.xml
{% endhighlight %}

If the file is not "pretty," `xcop` will complain and
show what's wrong. You can ask `xcop` to fix the file:

{% highlight bash %}
$ xcop --fix pom.xml
{% endhighlight %}

Moreover, in most cases you may need your XML files to include a license
in their headers, especially if it's open source. To enforce that, just
point `xcop` to the file with the license:

{% highlight bash %}
$ xcop --license=LICENSE.txt pom.xml
{% endhighlight %}

I believe it's a good practice to use `xcop` together with
Checkstyle (for Java files), Rubocop (for Ruby files), and other static
analyzers, to ensure that your XML files always look pretty.

[Read](https://github.com/yegor256/xcop) how you can integrate `xcop` with
[Rake](https://github.com/ruby/rake),
[Maven](https://maven.apache.org/), and other builders.
I will appreciate if you contribute your own integrations.

