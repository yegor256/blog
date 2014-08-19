---
layout: post
title: "How to Release to Rubygems, in One Click"
date: 2014-08-19
tags: rubygems rultor devops
description:
  This tutorial explains how a Ruby gem can be
  released to Rubygems.org in just one click and
  zero maintenance efforts, using Rultor.com, DevOps assistant
keywords:
  - rubygems deployment
  - release to rubygems
  - how to deploy gem
  - publishing gem
  - publish gem to rubygems
  - upload to rubygems
  - how to publish gem
---

When I release a new version of [jgd](https://github.com/yegor256/jekyll-github-deploy),
a Ruby gem, to Rubygems.org, it takes 30 seconds of my time.
Here is how I released a bug fix for version 1.5.1,
in [Github issue #6](https://github.com/yegor256/jekyll-github-deploy/issues/6):

{% figure http://img.yegor256.com/2014/08/github-ticket-6.png 600 %}

As you see, I gave a command to [Rultor](http://www.rultor.com),
and it released a new version to Rubygems. I didn't do anything else.

Now let's see how you can do the same. How you can configure your project
so that the release of its new version to Rubygems.org
takes just a few seconds of your time.

<!--more-->

By the way, I assume that you're hosting your project in Github. If not,
this entire tutorial won't work. If you are still not in Github, I would
strongly recommend moving there.

## Create Rubygems Account

Create an account in [Rubygems.org](http://www.rubygems.org).

## Create rubygems.yml

Create a `rubygems.yml` file:

{% highlight yaml %}
---
:rubygems_api_key: d355d8940bb031bfe9acf03ed3da4c0d
{% endhighlight %}

You should get this API key from Rubygems.  To find your API key,
click on your username when logged in to RubyGems.org and then click
on "Edit Profile".

## Encrypt rubygems.yml

Now, encrypt `rubygems.yml` with a Rultor public key (`9AF0FA4C`):

{% highlight xml %}
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 9AF0FA4C
gpg --trust-model always -a -e -r 9AF0FA4C rubygems.yml
{% endhighlight %}

You will get a new file `rubygems.yml.asc`.
Add this file to the root directory of your project,
commit and push. The file contains your secret information,
but only the Rultor server can decrypt it.

## Prepare Gemspec

In your `gemspec` file, make sure you use `1.0.snapshot` as a version number:

{% highlight ruby %}
# coding: utf-8
Gem::Specification.new do |s|
  # ...
  s.version = '1.0.snapshot'
  # ...
end{% endhighlight %}

This version name will be replaced by Rultor during deployment.

## Configure Rultor

Create a `.rultor.yml` file in the root directory of your project:

{% highlight yaml %}
decrypt:
  rubygems.yml: "repo/rubygems.yml.asc"
release:
  script:
    - "rm -rf *.gem"
    - "sed -i \"s/1.0.snapshot/${tag}/g\" foo.gemspec"
    - "gem build foo.gemspec"
    - "chmod 0600 /home/r/rubygems.yml"
    - "gem push *.gem --config-file /home/r/rubygems.yml"
{% endhighlight %}

In this example, replace `foo` with the name of your gem.

## Run It!

{% badge http://img.rultor.com/logo.svg 100 http://www.rultor.com %}

Now it's time to see how it all works. Create a new ticket in
the Github issue tracker, and post something like that into it
(read more about [Rultor commands](http://doc.rultor.com/basics.html)):

{% highlight text %}
@rultor release, tag is `0.1`
{% endhighlight %}

You will get a response in a few seconds. The rest will be done by Rultor.

Enjoy :)

BTW, if something doesn't work as I've explained, don't hesitate to
submit a ticket to
[Rultor issue tracker](https://github.com/yegor256/rultor/issues).
I will try to help you.
