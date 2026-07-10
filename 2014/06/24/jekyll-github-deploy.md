# Deploy Jekyll to GitHub Pages

Source: https://www.yegor256.com/2014/06/24/jekyll-github-deploy.html

This blog is written in [Jekyll](http://jekyllrb.com/) and is hosted at
[GitHub Pages](https://pages.github.com/). It uses half a dozen custom
plugins, which [are not allowed there](https://help.github.com/articles/using-jekyll-plugins-with-github-pages).

Here is how I deploy it:

```bash
$ jgd
```

That's it. [jgd](http://rubygems.org/gems/jgd) is my
Ruby gem (stands for "Jekyll GitHub Deploy"), which does
the trick. Here is
[what it does](https://github.com/yegor256/jekyll-github-deploy/blob/master/bash/deploy.sh):


1. It clones your existing repository from the current
directory to a temporary one (guessing the URL of the repo from `.git/config` file).

2. Runs `jekyll build` in that temporary directory,
which saves the output in another temporary directory.

3. Checks out `gh-pages` branch or creates one if it doesn't exist.

4. Copies the content of the site built by `jekyll build` into the branch, thus overwriting existing files, commits and pushes to GitHub.

5. Cleans up all temporary directories.

Using this gem is very easy. Just install it with
`gem install jgd` and then run in the root directory of your Jekyll blog.

What is important is that your Jekyll site files be
located in the root directory of the repository. Just
as they do on [this blog]({% pst 2014/apr/2014-04-06-introduction %});
see [its sources in GitHub](https://github.com/yegor256/blog).

You can easily integrate `jgd` with Travis.

Full documentation about the gem is located
[here](https://github.com/yegor256/jekyll-github-deploy).
