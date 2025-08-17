---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Type Annotations Are a Workaround"
date: 2025-08-17
place: Moscow, Russia
tags: oop
description: |
  Type annotations are a workaround for compiler limitations, not a feature—a well-designed language should infer all types automatically, forcing programmers to write smaller, cleaner modules.
keywords:
  - types in oop
  - types in object-oriented programming
  - oop abstract types
  - type inference
  - infer types
image: /images/2025/08/swingers.jpg
jb_picture:
  caption: Swingers (1996) by Doug Liman
---

Type annotations are what make statically typed object-oriented languages like Java run **faster** and **safer**.
Without annotations, every variable would be of type `Object`.
The code would work, but slower and with more runtime errors.
Some type annotations may be inferred instead of being explicitly specified by a programmer.
Not all though.
In Java, for example, a number of hard-to-resolve challenges prevent us from inferring types of all objects.
The existence of such challenges is not a fundamental limitation of object-oriented programming.
It's a defect of Java.
In a perfect object-oriented language, all variable types would be inferrable.

<!--more-->

{% jb_picture_body %}

Imagine a simple Java method:

```
Price priceOfDelivery(Book book, City city) {
  Price price = book.price();
  Delivery delivery = new Delivery(price, city);
  return delivery.price();
}
```

Two reasons justify the usage of `Book`, `City`, `Price`, and `Delivery` type annotations.
Compilers and programmers need help.

## Type Annotations Are Helpful

First, we help the compiler eliminate some **dynamic dispatches** in favor of static calls.
If the `Book` is a class, not an interface, the `book.price()` call may be compiled into a jump to an absolute address.
Without information about the `book` class, `.price()` goes to a virtual table first, finds the address, and only then jumps.
The second scenario is more expensive.
The type annotation attached to `book` helps avoid it.

Second, we help ourselves write safe code, avoiding "Method not found" **runtime errors**.
If `book` is not annotated as `Book`, we may mistakenly pass `Integer`, meaning the book's ID in the database.
At compile time, that would lead to no errors.
Later, at runtime, we get an error when `.price()` is not found in the virtual table of the `Integer` class.

However, both compilers and programmers can improve.

## Compilers Can Do Better

Sometimes, a compiler can infer the type of a variable, without an explicit annotation.
For example, this code compiles in Java, starting from version 10:

```
Price priceOfDelivery(Book book, City city) {
  var price = book.price();
  var delivery = new Delivery(price, city);
  return delivery.price();
}
```

The type annotation used in earlier Java versions is replaced with the `var` keyword.

In a small piece of code such as this one, the compiler can **infer** types.
However, it may fall short with the `book` and `city` parameters.
In the general case, type inference is not decidable for Java programs.
Because of generics, method overloading, reflection, and ... complexity.

The complexity is the technical obstacle.
The compiler can't infer types for all variables because it doesn't see the entire program.
Instead, it compiles file by file.
It can't compile all together because it would take too much time.
It would be able though, if programs were smaller.

All other barriers, such as generics, the compiler can't overcome:

```
void print(List<?> items) {
  var x = items.get(0); // What is the type?
}
```

No matter how hard the compiler tries, in the general case, this question doesn't have an answer.

## Programmers Can Do Better

We, programmers, can help the compiler infer types.

For example, we can stop using generics.
Instead of `List<Book>` we can have a `Library` and instead of `Map<User, Phone>` we can have a `PhoneBook`.
It's easier to infer the type of the object taken from a `Library` vs the object taken from a generic `List`.

We can also stop using method overloading.
Instead of `print(String x)` and `print(Integer x)` we can create `printString(x)` and `printInteger(x)`.
Types of parameters are easier to infer in more specialized methods.

We can also stop using reflection.

Java programmers may not be ready for such a radical move.
However, if they were, they would not only help the compiler but themselves too.
Easier type inference means better readability of the code.
The easier it is to infer the type of a variable for a compiler, the faster the programmer gets the semantics of it too.

The opposite is also true.
If type inference is hard or impossible to do, the quality of the program is low.

The quality of the language that allows to write such programs is the main concern.

## Languages Can Do Better

A language that we use must help us write programs that are fast and have no bugs.
A language with type annotations is not the best possible implementation of the objective.
Type annotations, as we just discussed, are a workaround, not a solution.

We can try to design a language that doesn't have type annotations.
Such a language should not have generics, method overloading, reflection, and everything else that prevents 100% type inference.
Then, we must design a compiler for this language that compiles the entire program, not single files.
The language would be statically typed and type safe in runtime.
This is how the book price snippet would look in such a language:

```
priceOfDelivery(book, city) {
  p = book.price();
  d = new Delivery(p, city);
  return d.price();
}
```

To me, this seems to be a much more readable code than the original one in Java.

Compilation time remains a limitation though.
We turn this issue into an opportunity.
Programmers are forced, by the timing limitations of the compiler, to write smaller modules.
When they need larger programs, they break them into modules that communicate via IPC instead of staying in a monolithic binary.

We are developing such a language: [EOLANG].

[IPC]: https://en.wikipedia.org/wiki/Inter-process_communication
[EOLANG]: https://www.eolang.org
