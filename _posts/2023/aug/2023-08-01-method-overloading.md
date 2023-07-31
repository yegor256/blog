---
layout: post
title: "The Hidden Dangers of Method Overloading"
date: 2023-09-01
place: Moscow, Russia
tags: oop
description: |
  While method overloading is purported to enhance readability, 
  but it actually tends to diminish it.
keywords:
  - method overloading
  - function overloading
  - overload methods
  - method overloading design
  - method overloading oop
image: /images/2023/08/youth.jpg
jb_picture:
  caption: Youth (2015) by Paolo Sorrentino
---

[Method overloading](https://en.wikipedia.org/wiki/Function_overloading) 
is a common feature in many programming languages that allows 
a class to have two or more methods with the same name but different parameters.
[According](https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/member-overloading) 
to Microsoft, method overloading is "one of the most important techniques 
for _improving_ usability, productivity, and readability of reusable libraries."
I disagree. In my opinion, method overloading may lead to less readable code and more bugs,
because maintaining two or more implementations under the same name gives rise to 
concealed semantics, which inevitably result in misunderstandings and functional defects.

<!--more-->

{% jb_picture_body %}

Let's start with a Java example.
Suppose you wish to enable the addition of a product to the shopping cart, 
having either the product ID or the `Product` object at your disposal. 
If only the ID is provided, you'd want the shopping cart to access 
the product catalog, locate the corresponding `Product` object, and add it. 
This is where method overloading can prove beneficial (the `add()` method is
defined twice with two different [signatures](https://stackoverflow.com/questions/8516498) 
and implementations):

```java
class Cart {
  private final List<Product> products;
  void add(int id) {
    this.add(new Catalog().findById(id));
  }
  void add(Product p) {
    this.products.add(p);
  }
}
var c = new Cart();
c.add(new Product("book"));
c.add(42);
```

This approach is indeed convenient for at least two reasons. First, the 
`add(int)` method handles the conversion from `int` to `Product`, 
which need not be repeated elsewhere---they can simply pass the product's ID 
to this method and let it do the work---thereby eliminating code duplication. 
Second, because the functionality of "searching the catalog" is not exposed 
beyond the `Cart` class, it simplifies the surrounding code. It appears that, 
indeed, the usability and readability of the code are enhanced.

However, the issues addressed (code duplication and complexity) are lesser 
than the problems introduced. While the semantics of the `add(Product)` method are 
obvious, the workings of the `add(int)` method are not clear to its users. 
Perhaps it searches the catalog? Maybe it selects the n-th product from 
the existing cart and re-adds it to the end of the cart? Or perhaps it searches 
the orders previously placed by the user and extracts the n-th product from there? 
We simply don't know when we examine the method's signature.

{% quote When something is obscured, it prompts assumptions, which in turn lead to misunderstandings, and eventually to bugs. %}

In order to comprehend what the `add(int)` method does, we must refer to 
its Javadoc block, which may not be sufficiently accurate. Furthermore, 
[as is often the case](https://stackoverflow.com/a/913342/187141), 
the documentation in the Javadoc block might not be 
in sync with the code inside the method. To put it plainly, the client 
using the `add(int)` method invariably makes an assumption about its inner workings. 
If the client is fortunate, 
1)&nbsp;the assumption will be accurate, and 
2)&nbsp;any changes subsequently made to the method won't invalidate that assumption.

It appears that method overloading is the root of the issue: maintaining 
multiple implementations under a single name inevitably introduces some 
concealed semantics in most of them. Then, when something is obscured, it prompts 
assumptions, which in turn lead to misunderstandings, and eventually to bugs.

I believe, a better alternative looks like this:

```java
class ProductInCatalog implements Product {
  private final Product p;
  ProductInCatalog(int id) {
    this.p = new Catalog().findById(id);
  }
  // all "Product" interface's methods
}
class Cart {
  private final List<Product> products;
  void add(Product p) {
    this.products.add(p);
  }
}
var c = new Cart();
c.add(new Product("book"));
c.add(new ProductInCatalog(42));
```

The constructor of `ProductInCatalog` is not code-free, 
as [it should be]({% pst 2015/may/2015-05-07-ctors-must-be-code-free %}), 
however for this discussion it's not so important. The `ProductInCatalog`
class is an abstraction of a `Product` found in the catalog. The class
is used by the user of the `Cart` class. The user explicitly and in his
full awareness turns 42 (the ID of the product) into an instance of
`ProductInCatalog`. There is nothing hidden in this design any more.
No assumptions and no promises that the code must keep.

The constructor of `ProductInCatalog` is not code-free,
as [it ideally should be]({% pst 2015/may/2015-05-07-ctors-must-be-code-free %}),
however, this point is not so significant for our current discussion. The `ProductInCatalog`
class serves as an abstraction of a `Product` found in the catalog. This class
is used by the client of the `Cart` class. The client, in full 
awareness and with explicit intent, converts 42 (the product's ID) into an instance 
of `ProductInCatalog`. This design no longer conceals any elements. There are 
no assumptions to be made and no conditions that the code must fulfill.

Do we still preserve the advantages provided by method overloading? Indeed, we do. 
There is no code duplication, and the complexity of the code is reduced. 
Furthermore, the readability of the code using the `Cart` is significantly improved. 
To summarize, I recommend avoiding method overloading, even though it will undoubtedly 
result in a larger number of classes in the codebase. However, that is 
[a different discussion altogether]({% pst 2017/feb/2017-02-28-too-many-classes %}).
