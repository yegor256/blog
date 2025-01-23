---
layout: post
title: "Dataization"
date: 2021-02-10
place: Moscow, Russia
tags: oop eolang
description: |
  Objects are purely declarative and passive entities in EO,
  which become alive when being requested to turn
  themselves into data.
keywords:
  - oop
  - object-oriented programming
  - oop research
  - oop research topics
  - oop research subjects
image: /images/2021/02/space-force.jpg
jb_picture:
  caption: Space Force (2020) by Steve Carell and Greg Daniels
---

There are three things in [EO](https://www.eolang.org)
(and the [𝜑-calculus](https://arxiv.org/abs/2111.13384) which we
based it on): data, atoms, and objects. There is a dataization
function, which puts all three together in order to make an EO
program alive. Here is how it works together with Java,
for example.

<!--more-->

{% jb_picture_body %}

Let's say we are making an online shop where items are
being shipped to different countries and we must calculate
shipment costs based on the customer's location. We create
an [abstract object]({% pst 2020/dec/2020-12-01-abstract-objects %})
that represents shipment costs:

```text
[customer] > cost-of-shipment
  if. > @
    customer.country.eq "US"
    9.99
    24.99
```

Then, let's say we have an abstract object `customer-in-mysql`,
which represents the customer's information in the MySQL database. To
make a specific customer `jeff` we make a copy of `customer-in-mysql`,
specifying the ID of the customer as `42`:

```text
customer-in-mysql 42 > jeff
```

The closed object `jeff` is the customer we are looking for.
We assume that it has the `country` child object, which is needed by
the `cost-of-shipment`.

Now, we make a copy of the `cost-of-shipment` and then
add it to the product price in order to calculate how
much a customer has to pay:

```text
cost-of-shipment jeff > x

x.add > total
  product.price
```

Here, the `x` is a new object, a copy of `cost-of-shipment`. Then,
we take the child abstract object `add` from it and make a copy,
giving `product.price` object to it as an attribute. We name the created copy
as `total`. Then, we print the total price:

```text
QQ.io.stdout > app
  QQ.txt.sprintf
    "Your total is %f" total
```

All these manipulations don't make the number print yet. They
are all object declarations. We've declared one abstract object
`cost-of-shipment` and a few closed objects: `jeff`, `x`, `total` and
`app`.

Now the most interesting part, which we call _dataization_. It's a process
of turning an object into data. The data is something that doesn't have
any child objects and is the simplest element of the computing platform,
where EO software is being compiled. You may think that in the example
above `42` and `"US"` are data. They are not. They are also objects
and we can write this, for example:

```text
42.add 5 > z

"US".length > len
```

The data behind these objects is not visible for us at the level of
EO program. The data is inside the `42` object. Only the runtime
of the specific platform can dig it out through the dataization
mechanism. If you compile the EO code to Java, you will get
a class `EOapp` (derived from the `app` object), which can be dataized
like this:

```text
import org.eolang.phi.Data;
EOapp app = new EOapp();
Boolean data = new Dataized(app).take(Boolean.class);
```

The method `take()` will take the object `app` and will try to ask it
to turn itself as data. The object `stdout` will redirect this request
to the object `sprintf`, which will ask the object `total` the same thing:
what data do you have? The object `total` is the object `x.add`.
If we look at what `x` is, we'll see that it's a copy of our own
abstract object `cost-of-shipment`, which doesn't have the child object `add`!
However, it does have a child object `@`, which is a "catch-all" object:
the request to get `add` will land there.

The object bound to the attribute `@` is the copy of `if`:

```text
if. > @
  customer.country.eq "US"
  9.99
  24.99
```

It will take the `customer.country.eq`, dataize it in order to get
boolean data, and then, depending on this data, return either `9.99` or `24.99`.
Either one of them has the attribute `add`, which will be used to
construct a new object, with an argument `product.price`. The result
will be used by the `Dataized` Java class in order to continue the process
of dataization. Finally, the sum of two numbers will be dataized to a
Java floating-point number.

{% youtube QaKIw1Bh3Oc %}

The dataization of `customer.country.eq` is happening inside
the runtime and is not visible at the level of EO. The object
`eq` is called an _atom_, since it's an atomic element of the language---it
has to be implemented in Java, not in EO. There are other atoms
in the example above: `if`, `sprintf`, `add`, `stdout`, and `length`.
They all are implemented in Java.

Thus, we construct objects first, either through _abstraction_ (declaring new
abstract objects) or through _application_ (making copies of abstract
objects). Next, we dataize one of the objects and the entire composition
of objects starts to "live," trying to turn itself into data.
