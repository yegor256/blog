---
layout: post
title: "Objectionary: How EO Programs Are Built"
date: 2021-10-19
place: Moscow, Russia
tags: oop
description: |
  ...
keywords:
  - oop
  - object-oriented programming
  - oop repository
  - object repository
  - storage of objects
image: /images/2021/10/
jb_picture:
  caption:
---

Since the time of Kernighan and Ritchie we share binary code in
libraries. You need to print a text with [`printf()`](https://en.wikipedia.org/wiki/Printf_format_string) in C++? 
You get [libc](https://en.wikipedia.org/wiki/Glibc) library with
[700+](https://stackoverflow.com/a/33188344/187141) other functions inside.
You need to copy a steam to a stream in Java?
You get [Apache Commons IO](https://commons.apache.org/proper/commons-io/) with 
[`copy()`](https://commons.apache.org/proper/commons-io/apidocs/org/apache/commons/io/IOUtils.html#copy-java.io.InputStream-java.io.OutputStream-) and 
[140+](https://commons.apache.org/proper/commons-io/apidocs/index.html) 
other methods and classes.
The same happens in all languages I'm aware of, like Ruby, Python, JavaScript, PHP:
you need an object, or a class, or a function, or a method---you have to add
the entire library to your build. 
Wouldn't it be more elegant to deal with individual objects instead?

<!--more-->

{% jb_picture_body %}

The idea is not new and not mine. 
I got it from [Object Thinking](http://amzn.to/266oJr4) book
by David West, where he suggested to create _Objectionary_ (page 306), 
a "combination of dictionary and object factory," with the following properties:

  * The total number of objects is less than 2000 
  * Each object is an autonomous executable entity
  * Every object has a unique ID and a unique "address"
  * Objects are nothing more than collections of objects
  * Objects require a hardware-specific VMs for execution

17 years later (the book was published in 2004), we implemented the idea
on top of [EO](https://www.eolang.org), our new programming language.
The language is intentionally much simplier
than Java or C++, you can read its more or less formal description 
[here](https://www.eolang.org/eolang-paper.pdf).

To turn an EO program into a executable entity, one has to go through
the following mandatory steps (I'm using JVM as a sample target platform):

  * **Parse**: `.eo` ➜ `.xmir`
  * **Optimize**: `.xmir` ➜ better `.xmir`
  * **Discover**: find all foreign aliases
  * **Pull**: download foreign `.eo` objects from Objectionary
  * **Resolve**: download `.jar` artifacts from Maven Central and unpack
  * **Place**: move artifact `.class` files to `target/classes`
  * **Extend**: mark `.eo` sources found in `.jar` as foreign
  * ↑ Go back to **Parse** if some `.eo` files still not parsed
  * **Transpile**: `.xmir` ➜ `.java`
  * **Compile**: `.java` ➜ `.class`

It is an iterative process, which loops over and over
again until all required `.eo` objects are parsed and their atoms are present. 
Then, all sources are transpiled and then compiled.

The process can be automated with our Maven plugin. Place `.eo` sources
to `src/main/eo` and add this to your `pom.xml`:

{% highlight xml %}
<project>
  <build>
    <plugins>
      <plugin>
        <groupId>org.eolang</groupId>
        <artifactId>eo-maven-plugin</artifactId>
        <version><!-- Take it from Maven Central --></version>
        <executions>
          <execution>
            <goals>
              <goal>register</goal>
              <goal>assemble</goal>
              <goal>transpile</goal>
            </goals>
          </execution>
        </executions>
      </plugin>
    </plugins>
    [..]
  </build>
  [..]
</project>
{% endhighlight %}

The `register` goal will scan the `src/main/eo` directory, find all
`.eo` sources, and "register" then in a special CSV catalog at 
`target/eo-foreigns.csv`. Then, the `assemble` goal will call
the following goals: `parse`, `optimize`, `discover`, `pull`, and
`resolve`. All these goals use the CSV catalog when they parse, optimize,
pull and so on. When all of them are done, the `assemble` checks the catalog: 
whether any `.eo` files still require parsing? If they do, another
cycle starts, again with parsing. When all `.eo` files are parsed,
the goal `transpile` is executed, which turns `.xmir` files into `.java`
and place them into `target/generated-sources`. The rest is done by the
standard `maven-compiler-plugin`.

Let's discuss each step in details.

## Parse

Say, this is the `.eo` source code at `src/main/eo/hello.eo`:

{% highlight text %}
+alias org.eolang.io.stdout

[] > hello
  "Jeff" > name
  stdout > @
    "Hello, %s!"
    name
{% endhighlight %}

It will be parsed to this XMIR (XML Intermediate Representation):

{% highlight xml %}
<program>
  <o name="hello" line="1">
    <o name="user" data="string" line="2">Jeff</o>
    <o name="@" base="stdout" line="3">
      <o data="string" line="4">Hello, %s!</o>
      <o base="user" line="5"/>
    </o>
  </o>
</program>
{% endhighlight %}

## Optimize

At this step the XMIR produced by the parser goes through 
many XSL transformations, sometimes getting additional elements and attributes.
Our example XMIR may get a new new attribute `@ref`, pointing the reference to the
object `user` to the line where it was defined:

{% highlight xml %}
<program>
  <o name="hello" line="1">
    <o name="user" data="string" line="2">Jeff</o>
    <o name="@" base="stdout" line="3">
      <o data="string" line="4">Hello, %s!</o>
      <o base="user" line="5" ref="2"/>
    </o>
  </o>
</program>
{% endhighlight %}

Some XSL transformation may check for grammar or semantical errors and
add a new element `<errors/>` if something wrong is found. Thus, if parsing
didn't find any syntax errors, all other errors will be visible inside
the XMIR document.

## Discover

At this step we find out which objects are "foreign" ones. In our example,
the object `user` is not foreign, since it is defined in the code we
have in front of us, while the object `stdout` is not defined here and
that's why is a foreign one.

Going through all `.xmir` files we can easily say which object is foreign just
by the names of them. Once we see the reference to `org.eolang.io.stdout`,
we check the presence of the file `org/eolang/io/stdout.eo` in the directory
with all `.eo` sources. If the file is absent, we put the object name
into the CSV catalog and claim it to be foreign.

## Pull 

Here we simply try to find source code `.eo` files for all foreign
objects in Objectionary, by looking at its GitHub repository. Here is
the [`stdout.eo`](https://github.com/yegor256/objectionary/blob/master/objects/org/eolang/io/stdout.eo).
We find them there and pull to the local disc.

Pay attention, we pull the sources. Not binaries or compiled XMIR
documents, but the sources in `.eo` format.

## Resolve

This is what [`stdout.eo`](https://github.com/yegor256/objectionary/blob/master/objects/org/eolang/io/stdout.eo)
may look like, after the pull:

{% highlight xml %}
+package org.eolang.io
+rt jvm org.eolang:eo-runtime:0.10.2

[text] > stdout /bool
{% endhighlight %}

The object is an _atom_. This means that even though we have its source code,
it't not complete without a piece of platform-specific binary code.
An atom is an object implemented by the runtime
platform, where the EO program is executed (also known
as [FFI mechanism](https://en.wikipedia.org/wiki/Foreign_function_interface)).
The line that starts with `+rt` (runtime) explains where to get the
runtime code. The `jvm` part is the name of the runtime.

We go to [Maven Central](https://search.maven.org/), find there the artifact 
[`org.eolang:eo-runtime:0.10.2`](https://search.maven.org/artifact/org.eolang/eo-runtime),
and unpack it (it's a zip archive with `.class` files after all).

By the way, A program may contain a number of `+rt` meta instructions, for example:

{% highlight text %}
+package org.eolang.io
+rt jvm org.eolang:eo-runtime:0.10.2
+rt ruby eo-core:0.5.8
+rt python eo-basics:0.0.3

[text] > stdout /bool
{% endhighlight %}

Here, two runtime platforms will know where to get the missing code
for the `stdout` atom:
EO-to-Java will go to [Maven Central](https://search.maven.org/) for the JAR artifact,
EO-to-Ruby will go to [RubyGems](https://rubygems.org/) 
trying to find the gem by the name `eo-core` and version `0.5.8`,
while EO-to-Python will go to [PyPi](https://pypi.org/) 
trying to find `eo-basics` package with the version `0.0.3`.

## Place

Then, we place its `.class` files into the `target/classes` directory,
to help Maven Compiler Plugin find them in classpath.

## Extend

In each JAR file that arrives, we can find `.eo` sources. They are the programs
this JAR file has had in classpath while it was built. We consider them
as foreign objects too and add to our catalog.

## Transpile

When all foreign objects, which are registered in the catalog, are downloaded,
compiled, and optimized, we are ready to start 
[_transpiling_](https://en.wikipedia.org/wiki/Source-to-source_compiler).
Instead of compiling XMIR directly to bytecode, we transpile it to `.java`
and let Java complier do the job of generating bytecode.

We believe that there are a few benefits of transpiling vs. compilation:

  * Output code is easier to read and debug,
  * Optimization power of existing compilers is reused,
  * Complexity of a transpiler is lower than of a compiler,
  * Portability of the output code is higher.

We already have two EO➜Java transpilers: 
[canonical one](https://github.com/cqfn/eo) and 
[the one](https://github.com/polystat/hse-transpiler) made by [HSE University](https://www.hse.ru/en/). 
We also have EO➜Python experimental [transpiler](https://github.com/polystat/eo2py) 
made by students of [Innopolis University](https://innopolis.university/en/). 
Most probably, when you read this article, there are more transpilers available.

Even though we believe in transpiling, it's still possible to create 
EO➜Bytecode, EO➜LLVM, or EO➜x86 compilers. 
You are more than welcome to try!

## Compile

At this step, the standard [Maver Compiler Plugin](https://maven.apache.org/plugins/maven-compiler-plugin/) 
finds auto-generated `.java` files in `target/generated-sources`
and turns them into `.class` files.

