---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Types vs. Proper Names"
date: 2025-08-17
place: Moscow, Russia
tags: oop
description: |
  ...
keywords:
  - types in oop
  - types in object-oriented programming
  - oop abstract types
  - type inference
  - infer types
image:
jb_picture:
  caption: ...
---

When object-oriented programming was born in 1967, it was already equiped with types.
Types are supposed to make code easier to compile and comprehend.
They surve the purpose, but other methods can help achieve the same goal, even better.
Instead of annotating variables with types we can disambiguate them with unique names.
This would make code shorter, thus more readable and maintainable.

<!--more-->

{% jb_picture_body %}

Imagine a simple Java method:

```
Price priceOfDelivery(Book b, City c) {
  Price p = b.price();
  Delivery delivery = new Delivery(p, c);
  return delivery.price();
}
```

Why do we use `Book`, `City`, `Price`, and `Delivery` types?
I can think of two reasons.
We assist compilers and programmers.

## Types Are Helpful

First, we help the compiler eliminate some dynamic dispatches in favor of static calls.
If the `Book` is a class, not an interface, the `b.price()` call may be compiled into a jump to an absolute address.
Without the information about `b` class, the `.price()` goes to a virtual table first, finds the address, and only then jumps.
The second scenario is more expensive.
Type annotation attached to the `b` helps avoid it.

Second, types help ourselves comprehend code better thus avoiding runtime ``Method not found'' mistakes.
Without types, we may call `priceOfDelivery()` with the `b` as a `Integer`, meaning book's Id in the database.
In compile time that would lead to no errors.
Later, in runtime, we get an error when `.price()` is not found in the virtual table of the `Integer` class.

Similar to us programmers, IDEs also benefit when they see type annotiations.
They rely on types to provide autocomplete and refactoring tools.
Without types, optimization and static analysis are far weaker.

## Compilers Can Do Better

Sometimes, a compiler can infer a type of a variable.
For example, this code compiles in Java, starting from the 10th version:

```
Price priceOfDelivery(Book b, City c) {
  var p = b.price();
  var d = new Delivery(p, c);
  return d.price();
}
```

The type annotation used in earlier Java versions is replaced with the `var` keyword.

In a small piece of code such as this one, the compiler can infer.
However, it can't do the same with the `book` and `city` variables.
Mostly because of Reflection: the compiler doesn't know what objects might be provided in runtime.

If Java would not have the Reflection, type inference would work for all variables, everywhere.
This is yet another argument against reflection.

## Programmers Can Do Better

Instead of naming variables with single letters we can use full nouns.
By renaming `b` to `book` and `c` to `city` we can eliminate the necessity to know their types.
The names themselves may be good enough to understand the purpose of objects and what can they do (it's pseudo-code, not Java):

```
Price priceOfDelivery(book, city) {
  var p = book.price();
  var d = new Delivery(p, city);
  return d.price();
}
```

In larger and more complex code blocks just nouns as variable names may not be enough.
A number of "books" or "prices" may be present in one method.
Just nouns may not disambiguate them.
Longer names may be required, which allegedly decrease readability.
This is yet another argument against complexity and long methods.
A short method of a few lines of code will always be readable with short nouns.

Here is a metaphor that may work:
A good method reads like a story with variables being its characters.
In a good story, characters have easily distinguishable unique names.
They also have  unique qualities.
Jeff is charming and handsome, Walter is fat and disgusting, while Maude is smart and pretty.
This sounds like an interesting story.
A story about three Jeffs would be much harder to tell so that it's not boring.

## Objects Can Do Better

To help story tellers---programmers---objects' qualities must be expressive.
In the snippet above, both `book` and `delivery` objects have `.price()` method.
Even though they are different methods, they have the same name.
This is what makes the story boring.

Just by renaming one of them to `.cost()`, we may enlighten the fact that they are different (pseudo-code again):

```
costOfDelivery(book, city) {
  p = book.price();
  d = new Delivery(p, city);
  return d.cost();
}
```

Now, compare this snippet with the one we've started from.
It does read faster and easier.

In a good program or a library, every object has its own unique set of properties, which are method names.
The `value()`, `get()`, and `save()` names only confuse their users.
Instead, unique and creative names equip every object with an easy-to-remember personality.

## Languages Can Do Better

Thoughtful naming of variables and methods is what compilers and programmers need.
Not types.

A programming language can enforce this practice by doing this:
