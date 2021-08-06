---
layout: post
title: "Logging in Unit Tests, a Bad Practice"
date: 2021-08-03
place: Moscow, Russia
tags: oop java
description: |
  Logging inside unit tests is a common practice, but
  a dangerous one, since it takes important knowledge
  away from the repository.
keywords:
  - logging tests
  - logging in unit tests
  - unit testing
  - logging testing
  - testing and logging
image: /images/2021/08/
jb_picture:
  caption:
---

Logging is an inevitable part of debugging. Well, at least in modern
high-level programming languages and architectures. It wasn't thirty 
years ago, in Assembly, but it is now. Sometimes we trace variables, 
but rarely. More often we just print them to console. Moreover, we don't
just print them using `println` or whatever it is we have for console
printing; instead, we send messages to a 
[logging framework](https://en.wikipedia.org/wiki/Java_logging_framework), which deals with 
the console or any other logging destinations, like files. The beauty
of such frameworks is that we don't need to remove logging after debugging
is finished---we just configure the framework to suppress all debug-level
messages in the production environment. Some logging may happen
inside unit tests. Do we also leave them there or maybe not?

<!--more-->

{% jb_picture_body %}

Here is an example (it's a simplification of a real unit test at
[CalcTest.java](https://github.com/polystat/polystat/blob/0.0.1/src/test/java/org/polystat/far/CalcTest.java)
from [Polystat](https://www.polystat.org), a static analyzer we're working on right now):

{% highlight java %}
import com.jcabi.log.Logger;
import com.jcabi.xml.XML;
import org.hamcrest.MatcherAssert;
import org.hamcrest.Matchers;
import org.junit.jupiter.api.Test;
public final class FooTest {
  @Test
  public void buildsSimpleXml() {
    final XML xml = new Foo().build();
    Logger.debug(this, "This is the XML:\n%s", xml.toString());
    MatcherAssert.assertThat(
      xml,
      Matchers.notNullValue()
    );
  }
}
{% endhighlight %}

This is Java and I'm using [JUnit5](https://junit.org/junit5/)+[Hamcrest](http://hamcrest.org/) 
together with my own logging framework
[jcabi-log](https://log.jcabi.com), which is a decorator of 
[Slf4j](http://www.slf4j.org/), which uses [Log4j](https://logging.apache.org/log4j/2.x/) to print to 
the console.

What is going on here? There is a class `Foo` with a method `build()`, which
makes an XML document (I'm using [jcabi-xml](https://xml.jcabi.com) library, which is a decorator of
[JDK DOM](https://docs.oracle.com/javase/8/docs/api/org/w3c/dom/package-summary.html)). 
Then, the unit test prints the contents of the XML document to
the console and makes a pretty silly assertion: the document is not NULL.
It is silly because if it were NULL, the logging statement 
would already fail at the `.toString()` call.

I'm the developer of this code, so I know what was going on: I was too lazy
to write a proper assertion, which would look into the XML document
and ensure that there were proper elements inside. I just printed it to the
console, _visually_ confirmed its validity and called it a day. 
If I had more time, this is how I would write a much better unit test
(I made the [improvements](https://github.com/polystat/polystat/issues/10) in Polystat tests just now):

{% highlight java %}
import com.jcabi.matchers.XhtmlMatchers;
import org.hamcrest.MatcherAssert;
import org.junit.jupiter.api.Test;
public final class FooTest {
  @Test
  public void buildsSimpleXml() {
    MatcherAssert.assertThat(
      XhtmlMatchers.xhtml(new Foo().build()),
      XhtmlMatchers.hasXPath("//foo")
    );
  }
}
{% endhighlight %}

Now, the XML document is built and then tested for the presence of `//foo` 
[XPath](https://en.wikipedia.org/wiki/XPath) inside it. 
The content of the document will be printed to the console
only in the case where the assertion fails. If the XML has the required
XPath, there will be no console output, which means no noise for future
developers.

Moreover, now it's a _single-statement_ test, which by itself is 
[good practice]({% pst 2017/may/2017-05-17-single-statement-unit-tests %}).

Looking back on my experience of testing and logging, 
I believe that logging in unit tests is a bad idea. Sometimes
inevitable, because we are lazy or simply don't have enough time, but still bad.
Logging helps us confirm visually the correctness of the output,
but it takes this knowledge away from the project. Those who will work with
the test later on won't know what we've seen there. They will
see the output at the console, but will not understand whether it _still_ matches
my expectations at the time of writing.

I would say that every logging line in a unit test is a message from its author:
"I know something about the data I see now, but I'm too lazy to tell you about it,
you just have to believe me that it looks good." 

I suggest we don't leave such messages in our code.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Do you print log messages from your unit tests?</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1421723724638789632?ref_src=twsrc%5Etfw">August 1, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
