---
layout: post
title: "Design Patterns and Anti-Patterns, Love and Hate Story"
date: 2016-01-20
place: Palo Alto, CA
tags: oop
description:
  These are most popular design patterns in
  object-oriented programming, while some of them
  are actually anti-patterns.
keywords:
  - design pattern
  - oop design pattern
  - java design pattern
  - anti patterns
  - clean code
---

[Design Patterns](https://en.wikipedia.org/wiki/Software_design_pattern) are ...
Come on, you know what they are. They are
something we **love** and **hate**. We love them, because they let us
write code without thinking. We hate them when we see the code
written by someone used to write code without thinking. Am I wrong?
Now, let me try to go through all of them and show you how much
I love or hate each one. Follow me, in alphabetic order.

<!--more-->
[<span class='green'>Abstract Factory</span>](https://en.wikipedia.org/wiki/Abstract_factory_pattern).
It's OK.

[<span class='green'>Adapter</span>](https://en.wikipedia.org/wiki/Adapter_pattern).
Good one!

[<span class='green'>Bridge</span>](https://en.wikipedia.org/wiki/Bridge_pattern).
Good one!

[<span class='red'>Builder</span>](https://en.wikipedia.org/wiki/Builder_pattern).
Terrible concept, since it encourages us to create and
use big and complex objects. If you need a builder, there
is something wrong already in the code. Refactor it, so that
any object would be easy to create, just through its constructors.

[<span class='green'>Chain of Responsibility</span>](https://en.wikipedia.org/wiki/Chain_of_responsibility_pattern).
Seems fine.

[<span class='green'>Command</span>](https://en.wikipedia.org/wiki/Command_pattern).
It's OK.

[<span class=''>Composite</span>](https://en.wikipedia.org/wiki/Composite_pattern).
Good one, check [this]({% pst 2015/oct/2015-10-01-vertical-horizontal-decorating %}) too.

[<span class='green'>Decorator</span>](https://en.wikipedia.org/wiki/Decorator_pattern).
My [favorite]({% pst 2015/feb/2015-02-26-composable-decorators %}) one.
Highly recommend to use.

[<span class='red'>Facade</span>](https://en.wikipedia.org/wiki/Facade_pattern).
Bad idea. In OOP we need objects and only objects.
Not facades to them. This design pattern is very procedural
in its spirit, since a facade is nothing else by a collection
of [procedures]({% pst 2015/feb/2015-02-20-utility-classes-vs-functional-programming %}).

[<span class='orange'>Factory Method</span>](https://en.wikipedia.org/wiki/Factory_method_pattern).
This one seems OK.

[<span class='red'>Flyweight</span>](https://en.wikipedia.org/wiki/Flyweight_pattern).
It's a workaround, as I see it, not a good design pattern. I would
recommend not to use it. Unless, there is a really critical performance
issue. But calling it a design pattern... No way. A fix for a
performance problem in Java? Yes. But not a pattern.

[<span class='red'>Front Controller</span>](https://en.wikipedia.org/wiki/Front_controller).
Terrible idea, as well as the entire
[MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller).
It's very [procedural]({% pst 2015/mar/2015-03-09-objects-end-with-er %}), that's why.

[<span class=''>Interpreter</span>](https://en.wikipedia.org/wiki/Interpreter_pattern).
???

[<span class='red'>Iterator</span>](https://en.wikipedia.org/wiki/Iterator_pattern).
Bad idea, since it is mutable. Would be much better
to have immutable "cursors".
???

[<span class=''>Lazy Initialization</span>](https://en.wikipedia.org/wiki/Lazy_initialization).
???

[<span class=''>Marker</span>](https://en.wikipedia.org/wiki/Marker_interface_pattern).
???

[<span class='red'>MVC</span>](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller).
Bad idea, since very procedural. [Controllers]({% pst 2015/mar/2015-03-09-objects-end-with-er %})
is the key broken element in this
idea. We need real objects, not procedural controllers.

[<span class=''>Mediator</span>](https://en.wikipedia.org/wiki/Mediator_pattern).
???

[<span class=''>Memento</span>](https://en.wikipedia.org/wiki/Memento_pattern).
???

[<span class=''>Module</span>](https://en.wikipedia.org/wiki/Module_pattern).
???

[<span class='red'>Multiton</span>](https://en.wikipedia.org/wiki/Multiton_pattern).
Really bad idea. Same as Singleton.
???

[<span class='green'>Null Object</span>](https://en.wikipedia.org/wiki/Null_Object_pattern).
Good idea. See [Why NULL is Bad?]({% pst 2014/may/2014-05-13-why-null-is-bad %})

[<span class=''>Object Library</span>](https://en.wikipedia.org/wiki/Design_pattern_object_library).
???

[<span class='red'>Object Pool</span>](https://en.wikipedia.org/wiki/Object_pool_pattern).
It's a workaround. This functionality has to be provided by
the language itself. I would not recommend to use this.
???

[<span class='orange'>Observer</span>](https://en.wikipedia.org/wiki/Observer_pattern).
The idea is good, but the name is bad, since it
[ends with -ER]({% pst 2015/mar/2015-03-09-objects-end-with-er %}).
A much better one would be "Source" and "Target". The Source
is generating events and the Target is listening to them.

[<span class='orange'>ORM</span>](https://en.wikipedia.org/wiki/Object-relational_mapping).
It's terrible and "offensive", check
[this]({% pst 2014/dec/2014-12-01-orm-offensive-anti-pattern %}) out.

[<span class='orange'>Prototype</span>](https://en.wikipedia.org/wiki/Prototype_pattern).
Good idea, but what is has to do with OOP?

[<span class=''>Proxy</span>](https://en.wikipedia.org/wiki/Proxy_pattern).
???

[<span class='green'>RAII</span>](https://en.wikipedia.org/wiki/Resource_Acquisition_Is_Initialization).
This is a really good one, highly recommend to use it.

[<span class=''>Servant</span>](https://en.wikipedia.org/wiki/Design_pattern_Servant).
???

[<span class='red'>Singleton</span>](https://en.wikipedia.org/wiki/Singleton_pattern).
It's a king of all anti-patterns. Stay away from it, at all cost.

[<span class=''>Specification</span>](https://en.wikipedia.org/wiki/Specification_pattern).
???

[<span class=''>State</span>](https://en.wikipedia.org/wiki/State_pattern).
???

[<span class=''>Strategy</span>](https://en.wikipedia.org/wiki/Strategy_pattern).
???

[<span class='green'>Template Method</span>](https://en.wikipedia.org/wiki/Template_method_pattern).
Seems fine.
???

[<span class=''>Visitor</span>](https://en.wikipedia.org/wiki/Visitor_pattern).
???

<hr/>

I have nothing against [concurrency patterns](https://en.wikipedia.org/wiki/Concurrency_pattern),
they are all <span class="green">good</span>, since
have almost nothing to do with object-oriented programming.

If you know some other design (anti-)patterns, let me know below
in comments. I'll add them here.
