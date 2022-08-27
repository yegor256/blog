---
layout: post
title: "What's Wrong With Global Variables?"
date: 2018-07-03
place: Moscow, Russia
tags: oop
description: |
  There are many reasons why global variables are
  evil and must be avoided in an object-oriented context;
  here is yet another one from me.
keywords:
  - global variables
  - oop global variables
  - global variables evil
  - global variables bad
  - global variables wrong
image: /images/2018/07/el-chapo.jpg
jb_picture:
  caption: El Chapo, Season 1 (2017) by Silvana Aguirre et al.
---

Only lazy people haven't written already about how [global variables](https://en.wikipedia.org/wiki/Global_variable)
are evil. It started in 1973 when W.&nbsp;Wulf et al. [claimed](https://dl.acm.org/citation.cfm?id=953355) that
"the non-local variable is a major contributing factor in programs
which are difficult to understand." Since then, [many other reasons](http://wiki.c2.com/?GlobalVariablesAreBad)
where suggested to convince programmers to stop using global variables.
I think [I read them all](https://softwareengineering.stackexchange.com/questions/148108/why-is-global-state-so-evil),
but didn't find the one that bothers me most of all: composability.
In a nutshell, global variables make code difficult or impossible to compose
in ways which are different from what its original author expected.

<!--more-->

{% jb_picture_body %}

I was recently writing a web front for [Zold](https://www.zold.io) in Ruby,
on top of [Sinatra](http://sinatrarb.com/).
This is how a web server starts according to [their documentation](http://sinatrarb.com/intro.html):

```ruby
App.start!
```

Here `start!` is a static method of the `App` class, which you have to declare
as a child of their default parent
[`Sinatra::Base`](https://github.com/sinatra/sinatra/blob/v2.0.3/lib/sinatra/base.rb#L893-L1896).
To tell the app which TCP port to listen to you have to preconfigure it:

```ruby
require 'sinatra/base'
class App < Sinatra::Base
  get '/' do
    'Hello, world!'
  end
end
App.set(:port, 8080)
App.start!
```

What do you do if you want to start two web servers?
For the purpose of testing this may be a pretty logical requirement.
For example, since Zold is a distributed network,
it is necessary to test how a number of servers communicate to each other.
I can't do that! There is absolutely no way.
Because Sinatra is designed with the assumption that only one server may exist in the entire application scope.

{% youtube FNWyN_Q10TI %}

Can this really be fixed? Let's take a look at [their code](https://github.com/sinatra/sinatra/).
Class `Sinatra::Base` is essentially a [Singleton]({% pst 2016/jun/2016-06-27-singletons-must-die %}),
which is not supposed to have more than one instance.
When we call `App.set(:port, 8080)`, the value `8080` is saved into an attribute of a single instance.
The number `8080` becomes available for all methods of `Sinatra::Base`, no matter what instance
they are called from.

They are not using [true](https://ruby-doc.org/docs/ruby-doc-bundle/UsersGuide/rg/globalvars.html)
Ruby global variables, I believe, because they know that they are bad.
Why exactly they are bad and what the
[alternatives]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %}) are---slipped through their fingers.

{% quote While the application is small and its test coverage is low, global variables may not hurt. %}

Technically speaking, their design is "globally scoped."
`Sinatra::Base` treats the entire application as its scope of visibility.
No matter who calls it, everything is visible, including what was created
in previous calls and in previously instantiated objects.
This "class" is a giant bag of global variables.

Every global variable is a troublemaker of that kind.
While the application is small and its test coverage is low, global variables may not hurt.
But the bigger the app and the more sophisticated its automated testing scenarios,
the more difficult it will be to compose objects which depend on global variables,
singletons, or class variables.

My recommendation? Under no circumstances even think about any global variables.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">What do you think about global variables? <a href="https://twitter.com/hashtag/elegantobjects?src=hash&amp;ref_src=twsrc%5Etfw">#elegantobjects</a> <a href="https://twitter.com/hashtag/oop?src=hash&amp;ref_src=twsrc%5Etfw">#oop</a></p>--- Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1018400337324118016?ref_src=twsrc%5Etfw">July 15, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
