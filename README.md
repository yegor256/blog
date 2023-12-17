<img src="https://www.yegor256.com/images/icon.svg" width="64px" height="64px" />

[![DevOps By Rultor.com](https://www.rultor.com/b/yegor256/blog)](https://www.rultor.com/p/yegor256/blog)

[![jekyll](https://github.com/yegor256/blog/actions/workflows/jekyll.yml/badge.svg)](https://github.com/yegor256/blog/actions/workflows/jekyll.yml)
[![Availability at SixNines](https://www.sixnines.io/b/3ba1652f)](https://www.sixnines.io/h/3ba1652f)
[![Hits-of-Code](https://hitsofcode.com/github/yegor256/blog)](https://hitsofcode.com/view/github/yegor256/blog)
[![My YouTube](https://img.shields.io/badge/YouTube-subscribe-active?logo=youtube)](https://www.youtube.com/c/yegor256?sub_confirmation=1)
[![My Twitter](https://img.shields.io/badge/Twitter-follow-active?logo=twitter)](https://twitter.com/intent/follow?screen_name=yegor256)
[![My Telegram](https://img.shields.io/badge/Telegram-subscribe-active?logo=telegram)](https://t.me/yegor256news)

This repository contains the sources of my blog: [www.yegor256.com](https://www.yegor256.com)
(the backup URL is [this one](https://yegor256.github.io/blog)).

My book [_256 Bloghacks_](https://www.yegor256.com/256-bloghacks.html)
explains how this blog is built and maintained.

The blog is deployed in this [Docker image](https://github.com/yegor256/blog-image).

You are welcome to submit corrections to this blog. In order to do that,
you will need [Ruby](https://www.ruby-lang.org/en/) 2.7,
[Bundler](https://bundler.io/),
Woff2,
and [PlantUML](http://plantuml.com/) installed. 
Then, run this:

```bash
$ bundle update
$ bundle exec jekyll serve
```

In a few minutes of building you should be able to see the blog
at `http://localhost:4000`. Make your changes and refresh the page in the browser.
If everything is fine, submit a pull request.

If it doesn't work (for some reason), do it via Docker
(I assume `/code/blog` is where the sources are):

```bash
$ docker run -it --rm \
  -v "$(readlink -f /code/blog):/b" \
  -p 4000:4000 \
  yegor256/blog-image \
  'cd /b && bundle update && bundle exec jekyll serve --drafts --future --host=0.0.0.0'
```
