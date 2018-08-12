---
layout: post
title: "Private Methods Are Code Smell"
date: 2018-09-29
place: Moscow, Russia
tags: mood
description: |
  ...
keywords:
  - ...
  - ...
  - ...
  - ...
  - ...
image: /images/2018/09/
jb_picture:
  caption:
---

I recently found out, in Ruby projects, that many programmers tend to
create private class methods with 1-2 statements inside. I find that wierd,
since I'm always trying to do the opposite. For me, a new private method
is always an indicator of a problem in class design---it's better to replace
them with supplementary objects. However, we do need private
methods sometimes, but . Where do we draw a line?

<!--more-->

{% jb_picture_body %}

Here is a Ruby example, which is very close to a real life case I've seen recently:

{% highlight java %}
class Release
  def publish
    if ready?
      puts 'Ready to be published!'
      # publish it!
    end
  end

  private

  def ready?
    @date < Time.now - 24 * 60 * 60 && @status == 'pass'
  end
end
{% endhighlight %}

Can't we just inline the condition, get rid of the private method `ready?`
and make the code shorter:

{% highlight java %}
class Release
  def publish
    if @date < Time.now - 24 * 60 * 60 && @status == 'pass'
      puts 'Ready to be published!'
      # publish it!
    end
  end
end
{% endhighlight %}

If we can, why I do see those one-line private methods so often in the
pull requests I review? It seems that many of us believe that private
methods are useful sub-routines, which help us break down a complex
code into pieces


