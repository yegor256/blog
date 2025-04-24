---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Design Patterns and Anti-Patterns, Love and Hate"
date: 2016-02-03
place: Palo Alto, CA
tags: oop
description: |
  These are the most popular design patterns in
  object-oriented programming, though some of them
  are actually anti-patterns, in my opinion.
category: jcg
keywords:
  - design pattern
  - oop design pattern
  - java design pattern
  - anti patterns
  - clean code
image: /images/2016/02/the-shining.jpg
jb_picture:
  caption: The Shining (1980) by Stanley Kubrick
---

[Design Patterns](https://en.wikipedia.org/wiki/Software_design_pattern) are ...
Come on, you know what they are. They are
something we **love** and **hate**. We love them because they let us
write code without thinking. We hate them when we see the code
of someone who is used to writing code without thinking. Am I wrong?
Now, let me try to go through all of them and show you how much
I love or hate each one. Follow me, in alphabetic order.

<!--more-->

{% jb_picture_body %}

[<span class='green'>Abstract Factory</span>](https://en.wikipedia.org/wiki/Abstract_factory_pattern).
It's OK.

[<span class='green'>Adapter</span>](https://en.wikipedia.org/wiki/Adapter_pattern).
Good one!

[<span class='green'>Bridge</span>](https://en.wikipedia.org/wiki/Bridge_pattern).
Good one!

[<span class='red'>Builder</span>](https://en.wikipedia.org/wiki/Builder_pattern).
Terrible concept, since it encourages us to create and
use big, complex objects. If you need a builder, there
is already something wrong in your code. Refactor it so
any object is easy to create through its constructors.

[<span class='green'>Chain of Responsibility</span>](https://en.wikipedia.org/wiki/Chain_of_responsibility_pattern).
Seems fine.

[<span class='green'>Command</span>](https://en.wikipedia.org/wiki/Command_pattern).
It's OK.

[<span class='green'>Composite</span>](https://en.wikipedia.org/wiki/Composite_pattern).
Good one; check out [this]({% pst 2015/oct/2015-10-01-vertical-horizontal-decorating %}) too.

[<span class='red'>Data Transfer Object</span>](https://en.wikipedia.org/wiki/Data_transfer_object).
It's just [a shame]({% pst 2016/jul/2016-07-06-data-transfer-object %}).

[<span class='green'>Decorator</span>](https://en.wikipedia.org/wiki/Decorator_pattern).
My [favorite]({% pst 2015/feb/2015-02-26-composable-decorators %}) one.
I highly recommend you use it.

{% youtube WSgP85kr6eU %}

[<span class='red'>Facade</span>](https://en.wikipedia.org/wiki/Facade_pattern).
Bad idea. In OOP, we need objects and only objects,
not facades for them. This design pattern is very procedural
in its spirit, since a facade is nothing more than a collection
of [procedures]({% pst 2015/feb/2015-02-20-utility-classes-vs-functional-programming %}).

[<span class='red'>Factory Method</span>](https://en.wikipedia.org/wiki/Factory_method_pattern).
~~This one seems OK~~. It's [bad]({% pst 2017/nov/2017-11-14-static-factory-methods %})!

[<span class='red'>Flyweight</span>](https://en.wikipedia.org/wiki/Flyweight_pattern).
It's a workaround, as I see it, so it's not a good design pattern. I would
recommend you not use it unless there is a really critical performance
issue. But calling it a design pattern ... no way. A fix for a
performance problem in Java? Yes.

[<span class='red'>Front Controller</span>](https://en.wikipedia.org/wiki/Front_controller).
Terrible idea, as well as the entire
[MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller).
It's very [procedural]({% pst 2016/dec/2016-12-13-mvc-vs-oop %}), that's why.

[<span class='orange'>Interpreter</span>](https://en.wikipedia.org/wiki/Interpreter_pattern).
It's OK, but I [don't like]({% pst 2015/mar/2015-03-09-objects-end-with-er %})
the name. "Expression" would be a much better alternative.

[<span class='red'>Iterator</span>](https://en.wikipedia.org/wiki/Iterator_pattern).
Bad idea, since it is mutable. It would be much better
to have [immutable]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %}) "cursors."

[<span class='green'>Lazy Initialization</span>](https://en.wikipedia.org/wiki/Lazy_initialization).
It's OK.

[<span class='red'>Marker</span>](https://en.wikipedia.org/wiki/Marker_interface_pattern).
It's a terrible idea, along with reflection and
[type casting]({% pst 2015/apr/2015-04-02-class-casting-is-anti-pattern %}).

[<span class='red'>MVC</span>](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller).
Bad idea, since it's very procedural. [Controllers]({% pst 2015/mar/2015-03-09-objects-end-with-er %})
are the key broken element in this
concept. We need real objects, not procedural controllers.

[<span class='red'>Mediator</span>](https://en.wikipedia.org/wiki/Mediator_pattern).
I don't like it. Even though it sounds like a technique
for decreasing complexity and coupling, it is not really object-oriented.
Who is this mediator? Just a "channel" between objects? Why shouldn't objects
communicate directly? Because they are too complex? Make
them smaller and simpler, rather than inventing these mediators.

[<span class='red'>Memento</span>](https://en.wikipedia.org/wiki/Memento_pattern).
This idea implies that objects are [mutable]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %}),
which I'm against in general.

[<span class='red'>Module</span>](https://en.wikipedia.org/wiki/Module_pattern).
If Wikipedia is right about this pattern, it's something
even more terrible than the Singleton.

[<span class='red'>Multiton</span>](https://en.wikipedia.org/wiki/Multiton_pattern).
Really bad idea. Same as Singleton.

[<span class='green'>Null Object</span>](https://en.wikipedia.org/wiki/Null_Object_pattern).
Good one. By the way, see
[Why NULL Is Bad]({% pst 2014/may/2014-05-13-why-null-is-bad %})

[<span class='green'>Object Pool</span>](https://en.wikipedia.org/wiki/Object_pool_pattern).
Good one.

[<span class='orange'>Observer</span>](https://en.wikipedia.org/wiki/Observer_pattern).
The idea is good, but the name is bad, since it
[ends with -ER]({% pst 2015/mar/2015-03-09-objects-end-with-er %}).
A much better one would be "Source" and "Target." The Source
generates events and the Target listens to them.

{% youtube DEqcn4-freM %}

[<span class='red'>ORM</span>](https://en.wikipedia.org/wiki/Object-relational_mapping).
It's terrible and "offensive"; check
[this]({% pst 2014/dec/2014-12-01-orm-offensive-anti-pattern %}) out.

[<span class='orange'>Prototype</span>](https://en.wikipedia.org/wiki/Prototype_pattern).
Good idea, but what does it have to do with OOP?

[<span class='green'>Proxy</span>](https://en.wikipedia.org/wiki/Proxy_pattern).
Good one.

[<span class='green'>RAII</span>](https://en.wikipedia.org/wiki/Resource_Acquisition_Is_Initialization).
This is a really good one, and I
[highly recommend]({% pst 2017/aug/2017-08-08-raii-in-java %}) you use it.

[<span class='red'>Servant</span>](https://en.wikipedia.org/wiki/Design_pattern_Servant).
A very bad idea, because it's highly
[procedural]({% pst 2015/feb/2015-02-20-utility-classes-vs-functional-programming %}).

[<span class='red'>Singleton</span>](https://en.wikipedia.org/wiki/Singleton_pattern).
It's the king of all anti-patterns. Stay away from it at all costs.

[<span class='green'>Specification</span>](https://en.wikipedia.org/wiki/Specification_pattern).
It's OK.

[<span class='orange'>State</span>](https://en.wikipedia.org/wiki/State_pattern).
Although it's not implied, I feel that in most cases
the use of this pattern results in mutability, a code characteristic that
I'm generally [against]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %}).

[<span class='green'>Strategy</span>](https://en.wikipedia.org/wiki/Strategy_pattern).
A good one.

[<span class='red'>Template Method</span>](https://en.wikipedia.org/wiki/Template_method_pattern).
is wrong, since implementation inheritance
[is procedural]({% pst 2016/sep/2016-09-13-inheritance-is-procedural %}).

[<span class='red'>Visitor</span>](https://en.wikipedia.org/wiki/Visitor_pattern).
A rather [procedural]({% pst 2015/feb/2015-02-20-utility-classes-vs-functional-programming %})
concept that treats objects as
data structures, which we can manipulate.

<hr/>

I have nothing against [concurrency patterns](https://en.wikipedia.org/wiki/Concurrency_pattern) either;
they are all <span class="green">good</span>, since they
have almost nothing to do with object-oriented programming.

If you know some other design (anti-)patterns, let me know
in the comments below. I'll add them here.
