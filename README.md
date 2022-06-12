<img src="https://www.yegor256.com/images/icon.svg" width="64px" height="64px" />

[![DevOps By Rultor.com](https://www.rultor.com/b/yegor256/blog)](https://www.rultor.com/p/yegor256/blog)

[![Availability at SixNines](http://www.sixnines.io/b/3ba1652f)](http://www.sixnines.io/h/3ba1652f)
[![Hits-of-Code](https://hitsofcode.com/github/yegor256/blog)](https://hitsofcode.com/view/github/yegor256/blog)

This is my blog: [www.yegor256.com](https://www.yegor256.com)

My book [_256 Bloghacks_](https://www.yegor256.com/256-bloghacks.html)
explains how this blog is built and maintained.

The blog is built during deployment in this [Docker image](https://github.com/yegor256/blog-image).

You are welcome to submit corrections to this blog. In order to do that,
you will need [Ruby](https://www.ruby-lang.org/en/) 2.3+,
[Bundler](https://bundler.io/),
and [PlantUML](http://plantuml.com/) installed. Then, run this:

```bash
$ bundle update
$ bundle exec jekyll serve
```

In about 3-4 minutes of building you should be able to see the blog
at `http://localhost:4000`. Make your changes and refresh the page in the browser.
If everything is fine, submit a pull request.

If it doesn't work (for some reason), do it via Docker
(I assume `/code/blog` is where the sources are):

```bash
$ docker run -it --rm \
  -v "$(readlink -f /code/blog):/b" \
  -p 4000:4000 --host=0.0.0.0 \
  yegor256/blog-image \
  'cd /b && bundle update && bundle exec jekyll serve --drafts --future'
```
