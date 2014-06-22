---
layout: post
title: "Deploy Jekyll to Github Pages"
date: 2014-06-22
tags: jekyll github ruby
description:
  Jekyll site can easily be deployed to Github Pages
  even with custom plugins; just use my jgd Ruby gem
keywords:
  - jekyll
  - jekyll github
  - jekyll github pages
  - deploy jekyll to github
  - deploy jekyll to github pages
  - how to deploy jekyll to github
  - custom plugins with jekyll github
  - jekyll github safe mode
---

This blog is written in [Jekyll](http://jekyllrb.com/),
it is hosted at [Github Pages](https://pages.github.com/),
and it has half a dozen of custom plugins, which
[are not allowed there](https://help.github.com/articles/using-jekyll-plugins-with-github-pages).
Here is how I deploy it:

{% highlight bash %}
$ jgd
{% endhighlight %}

That's it. [jgd](http://rubygems.org/gems/jgd)
is my Ruby gem (stands for "Jekyll Github Deploy"),
that does the trick. Here is
[what it does](https://github.com/yegor256/jekyll-github-deploy/blob/master/bash/deploy.sh):

1. It clones your existing repository, from the current directory,
to a temporary directory (guessing the URL of the repo from `.git/config` file).

2. Runs `jekyll build` in that temporary directory, saving the output
into another temporary directory.

3. Checks out `gh-pages` branch or creates one if it doesn't exist.

4. Copies the content of the site built by `jekyll build` into
the branch, overwritting existing files, commits and pushes to Github.

5. Cleans up all temporary directories.

Using this gem is very easy. Just install it with `gem install jgd` and
run in the root directory of your Jekyll blog.

What is important is that your Jekyll site files should be located
in the root directory of the repository. Just like this blog is doing,
see [its sources in Github](https://github.com/yegor256/blog).
