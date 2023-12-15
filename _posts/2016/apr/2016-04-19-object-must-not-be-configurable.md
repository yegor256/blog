---
layout: post
title: "Object Behavior Must Not Be Configurable"
date: 2016-04-19
place: New York, NY
tags: java oop
category: jcg
description: |
  Using object properties as configuration parameters
  for object behavior is a bad practice that leads to
  bigger and less cohesive objects.
keywords:
  - settings object
  - parameters object
  - decorator pattern
  - decorator pattern java
  - object configuration
book: elegant-objects-2 5.5
image: /images/2016/04/the-take.jpg
jb_picture:
  caption: The Take (2009) by David Drury
---

Using object properties as configuration parameters is a very common
mistake we keep making mostly because our objects
are mutable---we _configure_ them. We change their behavior by
injecting parameters or even entire settings/configuration objects
into them. Do I have to say that it's abusive and disrespectful
from a [philosophical]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %})
point of view? I can, but let's take a look at
it from a practical perspective.

<!--more-->

{% jb_picture_body %}

Let's say there is a class that is supposed to read a web page and
return its content:

```java
class Page {
  private final String uri;
  Page(final String address) {
    this.uri = address;
  }
  public String html() throws IOException {
    return IOUtils.toString(
      new URL(this.uri).openStream(),
      "UTF-8"
    );
  }
}
```

Looks simple and straight-forward, right? Yes, it's a rather cohesive
and solid class. Here is how we use it to read the content of Google
front page:

```java
String html = new Page("https://www.google.com").html();
```

Everything is fine until we start making this class more powerful.
Let's say we want to configure the encoding. We don't always want to use `"UTF-8"`.
We want it to be configurable. Here is what we do:

```java
class Page {
  private final String uri;
  private final String encoding;
  Page(final String address, final String enc) {
    this.uri = address;
    this.encoding = enc;
  }
  public String html() throws IOException {
    return IOUtils.toString(
      new URL(this.uri).openStream(),
      this.encoding
    );
  }
}
```

Done, the encoding is encapsulated and configurable. Now, let's say we
want to change the behavior of the class for the situation of an empty
page. If an empty page is loaded, we want to return `"<html/>"`. But not
always. We want this to be configurable. Here is what we do:

```java
class Page {
  private final String uri;
  private final String encoding;
  private final boolean alwaysHtml;
  Page(final String address, final String enc,
    final boolean always) {
    this.uri = address;
    this.encoding = enc;
    this.alwaysHtml = always;
  }
  public String html() throws IOException {
    String html = IOUtils.toString(
      new URL(this.uri).openStream(),
      this.encoding
    );
    if (html.isEmpty() && this.alwaysHtml) {
      html = "<html/>";
    }
    return html;
  }
}
```

The class is getting bigger, huh? It's great, we're good programmers and our
code must be complex, right? The more complex it is, the better programmers
we are! I'm being sarcastic. Definitely
[not]({% pst 2015/jun/2015-06-29-simple-diagrams %})! But let's move on. Now
we want our class to proceed anyway, even if the encoding is not
supported on the current platform:

```java
class Page {
  private final String uri;
  private final String encoding;
  private final boolean alwaysHtml;
  private final boolean encodeAnyway;
  Page(final String address, final String enc,
    final boolean always, final boolean encode) {
    this.uri = address;
    this.encoding = enc;
    this.alwaysHtml = always;
    this.encodeAnyway = encode;
  }
  public String html() throws IOException,
  UnsupportedEncodingException {
    final byte[] bytes = IOUtils.toByteArray(
      new URL(this.uri).openStream()
    );
    String html;
    try {
      html = new String(bytes, this.encoding);
    } catch (UnsupportedEncodingException ex) {
      if (!this.encodeAnyway) {
        throw ex;
      }
      html = new String(bytes, "UTF-8")
    }
    if (html.isEmpty() && this.alwaysHtml) {
      html = "<html/>";
    }
    return html;
  }
}
```

The class is growing and becoming more and more powerful! Now it's time
to introduce a new class, which we will call `PageSettings`:

```java
class Page {
  private final String uri;
  private final PageSettings settings;
  Page(final String address, final PageSettings stts) {
    this.uri = address;
    this.settings = stts;
  }
  public String html() throws IOException {
    final byte[] bytes = IOUtils.toByteArray(
      new URL(this.uri).openStream()
    );
    String html;
    try {
      html = new String(bytes, this.settings.getEncoding());
    } catch (UnsupportedEncodingException ex) {
      if (!this.settings.isEncodeAnyway()) {
        throw ex;
      }
      html = new String(bytes, "UTF-8")
    }
    if (html.isEmpty() && this.settings.isAlwaysHtml()) {
      html = "<html/>";
    }
    return html;
  }
}
```

Class `PageSettings` is basically a holder of parameters, without any
behavior. It has getters, which give us access to the parameters:
`isEncodeAnyway()`, `isAlwaysHtml()`, and `getEncoding()`. If we keep
going in this direction, there could be a few dozen configuration settings
in that class. This may look very convenient and
is a very typical pattern in Java world. For example,
look at
[`JobConf`](https://hadoop.apache.org/docs/r2.4.1/api/org/apache/hadoop/mapred/JobConf.html)
from Hadoop.
This is how we will call our highly configurable `Page`
(I'm assuming `PageSettings` is immutable):

```java
String html = new Page(
  "https://www.google.com",
  new PageSettings()
    .withEncoding("ISO_8859_1")
    .withAlwaysHtml(true)
    .withEncodeAnyway(false)
).html();
```

However, no matter how convenient it may look at first glance,
this approach is _very wrong_. Mostly because it encourages us
to make big and non-cohesive objects. They grow in size and become less
testable, less maintainable and less readable.

{% quote Encapsulated properties must not be used to change the behavior of an object %}

To prevent that from happening,
I would suggest a simple rule here:
object behavior should not be configurable.
Or, more technically, encapsulated properties must not be used to
change the behavior of an object.

Object properties are there only to coordinate the location
of a real-world entity, which the object is representing. The `uri` is the
coordinate, while the `alwaysHtml` boolean property is a behavior changing
trigger. See the difference?

So, what should we do instead? What is the right design? We must
use [composable decorators]({% pst 2015/feb/2015-02-26-composable-decorators %}).
Here is how:

```java
Page page = new NeverEmptyPage(
  new DefaultPage("https://www.google.com")
)
String html = new AlwaysTextPage(
  new TextPage(page, "ISO_8859_1")
  page
).html();
```

Here is how our `DefaultPage` would look (yes, I had to change
its design a bit):

```java
class DefaultPage implements Page {
  private final String uri;
  DefaultPage(final String address) {
    this.uri = address;
  }
  @Override
  public byte[] html() throws IOException {
    return IOUtils.toByteArray(
      new URL(this.uri).openStream()
    );
  }
}
```

As you see, I'm making it implement interface `Page`.
Now `TextPage` decorator, which converts an array of bytes to a text using
provided encoding:

```java
class TextPage {
  private final Page origin;
  private final String encoding;
  TextPage(final Page page, final String enc) {
    this.origin = page;
    this.encoding = enc;
  }
  public String html() throws IOException {
    return new String(
      this.origin.html(),
      this.encoding
    );
  }
}
```

Now the `NeverEmptyPage`:

```java
class NeverEmptyPage implements Page {
  private final Page origin;
  NeverEmptyPage(final Page page) {
    this.origin = page;
  }
  @Override
  public byte[] html() throws IOException {
    byte[] bytes = this.origin.html();
    if (bytes.length == 0) {
      bytes = "<html/>".getBytes();
    }
    return bytes;
  }
}
```

And finally the `AlwaysTextPage`:

```java
class AlwaysTextPage {
  private final TextPage origin;
  private final Page source;
  AlwaysTextPage(final TextPage page, final Page src) {
    this.origin = page;
    this.source = src;
  }
  public String html() throws IOException {
    String html;
    try {
      html = this.origin.html();
    } catch (UnsupportedEncodingException ex) {
      html = new TextPage(this.source, "UTF-8").html();
    }
    return html;
  }
}
```

You may say that `AlwaysTextPage` will make two calls to the encapsulated
`origin`, in case of an unsupported encoding, which will lead to a duplicated
HTTP request. That's true and this is by design. We don't want this
duplicated HTTP roundtrip to happen. Let's introduce one more class,
which will cache the page fetched (
[not thread-safe]({% pst 2017/jan/2017-01-17-synchronized-decorators %}), but it's not important now):

```java
class OncePage implements Page {
  private final Page origin;
  private final AtomicReference<byte[]> cache =
    new AtomicReference<>;
  OncePage(final Page page) {
    this.origin = page;
  }
  @Override
  public byte[] html() throws IOException {
    if (this.cache.get() == null) {
      this.cache.set(this.origin.html());
    }
    return this.cache.get();
  }
}
```

Now, our code should look like this (pay attention, I'm now using `OncePage`):

```java
Page page = new NeverEmptyPage(
  new OncePage(
    new DefaultPage("https://www.google.com")
  )
)
String html = new AlwaysTextPage(
  new TextPage(page, "ISO_8859_1")
  "UTF-8"
).html();
```

This is probably the most code-intensive post on this site so far, but I
hope it's readable and I managed to convey the idea. Now we have five
classes, each of which is rather small, easy to read and easy to reuse.

Just follow the rule: never make classes configurable!

