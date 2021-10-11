---
layout: post
title: "Objectionary: Dictionary and Factory for EO Objects"
date: 2021-10-10
place: Moscow, Russia
tags: oop
description: |
  It is a platform-independent object repository, which
  hosts source code and validates its consistency on each
  modification.
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

{% badge /images/books/elegant-objects/cactus.svg 128 http://www.eolang.org %}

Since the time of Kernighan and Ritchie we share binary code in
libraries. You need to print a text with [`printf()`](https://en.wikipedia.org/wiki/Printf_format_string) in C++? 
You get [libc](https://en.wikipedia.org/wiki/Glibc) library with
[700+](https://stackoverflow.com/a/33188344/187141) other functions inside.
You need to copy a Java stream?
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

{% badge /images/2015/04/book-object-thinking.jpg 96 http://amzn.to/266oJr4 %}
The idea is not new and not mine. 
I got it from [Object Thinking](http://amzn.to/266oJr4) book
by David West, where he suggested creating _Objectionary_ (page 306), 
a "combination of dictionary and object factory," with the following properties:

  * The total number of objects is less than 2000;
  * Each object is an autonomous executable entity;
  * Every object has a unique ID and a unique "address";
  * Objects are nothing more than collections of objects;
  * Objects require a hardware-specific VMs for execution.

17 years later (the book was published in 2004), we implemented the idea
on top of [EO](https://www.eolang.org), our new programming language.
The language is intentionally much simpler than Java or C++.
You can read its more or less formal description 
[here](https://www.eolang.org/eolang-paper.pdf).

To turn an EO program into a executable entity and release it to 
[Objectionary](https://www.objectionary.com), 
one has to go through the following mandatory steps,
assuming JVM is used as a target platform
(the steps marked with 🌵 are implemented by
[eo-maven-plugin](https://github.com/cqfn/eo)):

  * **Parse**🌵: `.eo` ➜ `.xmir`
  * **Optimize**🌵: `.xmir` ➜ better `.xmir`
  * **Discover**🌵: find all foreign aliases
  * **Pull**🌵: download foreign `.eo` objects from Objectionary
  * **Resolve**🌵: take `.jar` artifacts from Maven Central and unpack
  * **Place**🌵: move artifact `.class` files to `target/classes/`
  * **Extend**🌵: mark `.eo` sources found in `.jar` as foreign
  * ↑ Go back to **Parse** if some `.eo` files still not parsed
  * **Transpile**🌵: `.xmir` ➜ `.java`
  * **Compile**: `.java` ➜ `.class`
  * **Unplace**🌵: remove foreign `.class` files from `target/classes/`
  * **Unspile**🌵: remove auto-generated `.java` files
  * **Copy**🌵: copy `.eo` files to `EO-SOURCES/` inside `.jar`
  * **Deploy**: package `.jar` artifact and put it into Maven Central
  * **Push: send a pull request to [yegor256/objectionary](https://github.com/yegor256/objectionary)
  * **Merge**: we test and merge your pull request

It is an iterative process, which loops over and over
again until all required `.eo` objects are parsed and their atoms are present. 
Then, all sources are transpiled and then compiled.

The process can be automated with our Maven plugin. Place `.eo` sources
to `src/main/eo/` and add this to your `pom.xml`:

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
              <goal>copy</goal>
              <goal>unplace</goal>
              <goal>unspile</goal>
            </goals>
          </execution>
        </executions>
      </plugin>
    </plugins>
    [...]
  </build>
  [...]
</project>
{% endhighlight %}

The `register` goal will scan the `src/main/eo/` directory, find all
`.eo` sources, and "register" then in a special CSV catalog at 
`target/eo-foreigns.csv`. Then, the `assemble` goal will call
the following goals: `parse`, `optimize`, `discover`, `pull`, and
`resolve`. All these goals use the CSV catalog when they parse, optimize,
pull and so on. When all of them are done, the `assemble` checks the catalog: 
whether any `.eo` files still require parsing? If they do, another
cycle starts, again with parsing. When all `.eo` files are parsed,
the goal `transpile` is executed, which turns `.xmir` files into `.java`
and place them into `target/generated-sources`. The rest is done by the
standard [`maven-compiler-plugin`](https://maven.apache.org/plugins/maven-compiler-plugin/).

Let's discuss each step in details.

## Parse 🌵

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

If you wonder what this XML means, read 
[this document](https://www.eolang.org/eolang-paper.pdf):
there is a section about XMIR.

## Optimize 🌵

At this step the XMIR produced by the parser goes through 
many XSL transformations, sometimes getting additional elements and attributes.
Our example XMIR may get a new attribute `@ref`, pointing the reference to the
object `user` to the line where the object was defined:

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

## Discover 🌵

At this step we find out which objects are "foreign" ones. In our example,
the object `user` is not foreign, since it is defined in the code we
have in front of us, while the object `stdout` is not defined here and
that's why is a foreign one.

Going through all `.xmir` files we can easily judge which object is foreign just
by looking at their names. Once we see the reference to `org.eolang.io.stdout`,
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

## Resolve 🌵

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

By the way, a program may contain a number of `+rt` meta instructions, for example:

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

## Place 🌵

Then, we place its `.class` files into the `target/classes` directory,
to help Maven Compiler Plugin find them in classpath.

## Extend 🌵

In each JAR file that arrives, we can find `.eo` sources. They are the programs
this JAR file has had in classpath while it was built. We consider them
as foreign objects too and add to our catalog.

## Transpile 🌵

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

## Unplace 🌵

Here, we remove all `.class` files unpacked from dependencies. This is
necessary in order to avoid getting them packaged into the 
final JAR.

## Unspile 🌵

Here, we delete all `.class` files from the `target/classes/` directory,
which were auto-generated from `.eo`. We don't want to ship binaries,
which can be generated from `.eo` sources. We only want to ship 
atoms, which are `.java` files originally.

## Copy 🌵

At this step we take all `.eo` sources from `src/main/eo/` and copy
them to `target/classes/EO-SOURCES/` directory. Later, they will be
packaged together with `.class` files into a `.jar`, which will be
deployed to Maven Central. While copying, we replace `0.0.0` in the
runtime version to the currently deploying version. Take a look 
at the file [`stdout.eo`](https://github.com/cqfn/eo/blob/master/eo-runtime/src/main/eo/org/eolang/io/stdout.eo), 
in its source repository:

{% highlight text %}
+package org.eolang.io
+rt jvm org.eolang:eo-runtime:0.0.0

[text] > stdout /bool
{% endhighlight %}

The version at the `+rt` line is `0.0.0`. When sources are copied to the 
JAR, this text is replaced.

The motivation to ship sources together with binaries is the following.
When atom binaries are compiled from Java to bytecode, they stay
next to transpiled sources. They are compiled together. Moreover,
unit tests also rely on both atom sources and auto-generated/transpiled
sources. We want future users of the JAR to know what sources we
had in place, when the compilation was going on, to maybe let them reproduce
it or at least know what were the surroundings around the binaries they get.

From a more practical standpoint, we need these sources in the JAR
in order to let the **Extend** step understand what objects
are worth pulling next to the atoms resolved.

## Deploy

Here, we package everything from `target/classes` into a JAR
archive and [deploy]({% pst 2014/aug/2014-08-19-how-to-release-to-maven-central %}) 
to Maven Cental.

I suggest deploying sources to GitHub Pages too, to let users see
them in Web. Also, it will be helpful later, when we make a pull 
request to Objectionary. Check this [`.rultor.yml`](https://github.com/yegor256/eo-files/blob/master/.rultor.yml#L17-L31) 
script in one of my EO libraries, it deploys sources.

## Push

When the deployment is finished and Maven Central updates its CDN servers,
it's time to submit a pull request to [yegor256/objectionary](https://github.com/yegor256/objectionary).
The `.eo` sources of objects go into `objects/` and their unit tests
go into `tests/`. Basically, we just copy `src/main/eo/` and `src/test/eo`
over there. But, stop... one important detail. In the sources, as was said earlier,
we have `+rt` versions set to `0.0.0`. Here, when we copy to Objectionary,
versions must be set to real numbers.

## Merge

...
