---
layout: post
title: "How to Publish to RubyGems, in One Click"
date: 2014-08-26
tags: rultor devops ruby
description: |
  This tutorial explains how a Ruby gem can be
  released to RubyGems.org in just one click and
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
a Ruby gem, to RubyGems.org, it takes 30 seconds of my time.
Here is how I released a bug fix for version 1.5.1,
in [GitHub issue #6](https://github.com/yegor256/jekyll-github-deploy/issues/6):

{% figure /images/2014/08/github-ticket-6.jpg 600 %}

As you see, I gave a command to [Rultor](https://www.rultor.com),
and it released a new version to RubyGems. I didn't do anything else.

Now let's see how you can do the same. How you can configure your project
so that the release of its new version to RubyGems.org
takes just a few seconds of your time.

<!--more-->

By the way, I assume that you're hosting your project in GitHub. If not,
this entire tutorial won't work. If you are still not in GitHub, I would
strongly recommend moving there.

## Create RubyGems Account

Create an account in [RubyGems.org](http://www.rubygems.org).

## Create `rubygems.yml`

Create a `rubygems.yml` file (you may already have it as `~/.gem/credentials`):

```text
:rubygems_api_key: d355d8940bb031bfe9acf03ed3da4c0d
```

You should get this API key from RubyGems.  To find your API key,
click on your user name when logged in to RubyGems.org and then click
on "Edit Profile."

## Encrypt `rubygems.yml`

Now, encrypt `rubygems.yml` with a [rultor remote](https://github.com/yegor256/rultor-remote):

```xml
$ gem install rultor
$ rultor encrypt -p me/test rubygems.yml
```

Instead of `me/test` use the name of your GitHub project.

You will get a new file `rubygems.yml.asc`.
Add this file to the root directory of your project,
commit and push. The file contains your secret information,
but only the Rultor server can decrypt it.

## Prepare Gemspec

In your `gemspec` file, make sure you use `1.0.snapshot` as a version number:

```ruby
# coding: utf-8
Gem::Specification.new do |s|
  # ...
  s.version = '1.0.snapshot'
  # ...
end
```

This version name will be replaced by Rultor during deployment.

## Configure Rultor

Create a `.rultor.yml` file in the root directory of your project:

```text
decrypt:
  rubygems.yml: "repo/rubygems.yml.asc"
release:
  script: |
    rm -rf *.gem
    sed -i "s/1.0.snapshot/${tag}/g" foo.gemspec
    gem build foo.gemspec
    chmod 0600 /home/r/rubygems.yml
    gem push *.gem --config-file /home/r/rubygems.yml
```

In this example, replace `foo` with the name of your gem.

## Run It!

{% badge https://doc.rultor.com/images/logo.svg 100 https://www.rultor.com %}

Now it's time to see how it all works. Create a new ticket in
the GitHub issue tracker, and post something like that into it
(read more about [Rultor commands](https://doc.rultor.com/basics.html)):

```text
@rultor release, tag is `0.1`
```

You will get a response in a few seconds. The rest will be done by Rultor.

Enjoy!

BTW, if something doesn't work as I've explained, don't hesitate to
submit a ticket to
[Rultor issue tracker](https://github.com/yegor256/rultor/issues).
I will try to help you.
