---
layout: post
title: "Mocking of HTTP Server in Java"
date: 2014-04-17
tags: cloud
description: ...
keywords:
  - java http server
  - java http client
  - http server mock
  - java http server mock
  - mock java http server
---

Recently I explained a
[fluent Java HTTP client]({% post_url 2014/april/2014-04-11-jcabi-http-intro %})
created mostly in order to make HTTP interactions
more object-oriented than any other available clients,
including Apache Client, Jersey Client and plain old
`HttpURLConnection`.

This client is shipped in [jcabi-http](http://http.jcabi.com)
Maven artifact. However, the client part is not the only benefit
you're getting when using [jcabi-http](http://http.jcabi.com). There
is also a server component that can help you in unit and integration
testing of your HTTP clients.

Let me show you an example first (I'm using
[hamcrest](http://www.hamcrest.org) for assertions):

{% highlight java linenos=table %}
final MkContainer container = new MkGrizzlyContainer()
  .next(new MkAnswer.Simple("hello, world!"))
  .start();
try {
  new JdkRequest(container.home())
    .header("User-agent", "Myself")
    .fetch()
    .assertBody(Matchers.containsString("hello"));
} finally {
  container.stop();
}
final MkQuery query = container.take();
MatcherAssert.assertThat(
  query.headers().get("User-agent"),
  Matchers.hasItem("Myself")
);
{% endhighlight %}

Let's see what is happening here. In the first few lines I
create an instance of [`MkContainer`](...), which has literally four
methods: `next(MkAnswer)`, `start()`, `stop()`, and `home()`. It works
as an HTTP server with a "first-in-first-out" queue
of HTTP answers. We add answers
and the server returns them in response to HTTP requests.

The server starts on `start()` call and stops on `stop()`. Its
method `home()` returns an URI of it's "home page". The server
binds itself to a randomly allocated TCP port. The container
finds the first available port not occupied by any other servers.

In the example above, I added just one answer. That means that
the container wi

As with the client, the only dependency you need is
[jcabi-http.jar](`http://repo1.maven.org/maven2/com/jcabi/jcabi-http`):

{% highlight xml %}
<dependency>
  <groupId>com.jcabi</groupId>
  <artifactId>jcabi-http</artifactId>
  <version><!-- check http://http.jcabi.com --></version>
</dependency>
{% endhighlight %}
