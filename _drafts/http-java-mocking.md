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
including
[Apache Client](http://hc.apache.org/httpclient-3.x/),
[Jersey Client](https://jersey.java.net/documentation/latest/client.html)
and plain old
[`HttpURLConnection`](http://docs.oracle.com/javase/7/docs/api/java/net/HttpURLConnection.html).

This client is shipped in [jcabi-http](http://http.jcabi.com)
Maven artifact. However, the client part is not the only benefit
you're getting when using [jcabi-http](http://http.jcabi.com). There
is also a server component that can help you in unit and integration
testing of your HTTP clients.

Let me show you an example first (I'm using
[hamcrest](http://hamcrest.org/JavaHamcrest/) for assertions):

{% highlight java linenos=table %}
MkContainer container = new MkGrizzlyContainer()
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
MkQuery query = container.take();
MatcherAssert.assertThat(
  query.headers().get("User-agent"),
  Matchers.hasItem("Myself")
);
{% endhighlight %}

Let's see what is happening here. In the first few lines I
create an instance of [`MkContainer`](http://http.jcabi.com/apidocs-1.1/com/jcabi/http/mock/MkContainer.html),
which has literally four
methods: `next(MkAnswer)`, `start()`, `stop()`, and `home()`. It works
as an HTTP server with a "first-in-first-out" queue
of HTTP answers. We add answers
and the server returns them in response to HTTP requests.

The server starts on `start()` call and stops on `stop()`. Its
method `home()` returns an URI of it's "home page". The server
binds itself to a randomly allocated TCP port. The container
finds the first available port not occupied by any other servers.

In the example above, I added just one answer. That means that
the container will reply to the first HTTP request with that
answer and all consecutive requests will cause HTTP responses with
status [500](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html)
(internal server error).

In lines 5-8 I'm making an HTTP request to already started server.
Also, I'm making an assertion that the body of the HTTP response
contains text `"hello"`. Obviously, this assertion will pass because
the server will return `"hello, world!"` to my first request:

{% highlight java %}
new JdkRequest(container.home())
  .header("User-agent", "Myself")
  .fetch()
  .assertBody(Matchers.containsString("hello"));
{% endhighlight %}

As you see, I'm using `container.home()` in order to get the URI of
the server. It is recommended to allow the container to find the
first non-occupied TCP port and bind itself to it. However, if you
need to specify your own port, you can do it with a one-argument
method [`start(int)`](http://http.jcabi.com/apidocs-1.3/com/jcabi/http/mock/MkContainer.html#start%28int%29)
of `MkContainer`.

I'm using `try/finally` in order to stop the container safely. In unit
tests this is not critical and you can simplify your code and never
stop the container. Anyway, it will be killed together with the JVM. However,
for the sake of clarity, I would recommend to stop it and in the `finally` block.

Then, in line 12, I'm asking stopped container to give me the first
request it received. This mechanism is conceptually similar to "verify"
technology of mocking frameworks, for example
[Mockito](http://docs.mockito.googlecode.com/hg/org/mockito/Mockito.html#4):

{% highlight java %}
MkQuery query = container.take();
MatcherAssert.assertThat(
  query.headers().get("User-agent"),
  Matchers.hasItem("Myself")
);
{% endhighlight %}

An instance of [`MkQuery`](http://http.jcabi.com/apidocs-1.3/com/jcabi/http/mock/MkQuery.html)
exposes information about the query made. In this example, I'm getting
all headers of the HTTP request and making an assertion that `"User-Agent"`
header was there and had at least one value equal to `"Myself"`.

This mocking technology is actively used in unit and integration
tests of [jcabi-github](http://github.com/jcabi/jcabi-github), which is
a Java client to Github API. In its development it was very important
to check which requests it is sending to the server and validate whether
they comply with our requirements. We are using
[jcabi-http](http://http.jcabi.com) mocking there.

As with the client, you need
[jcabi-http.jar](`http://repo1.maven.org/maven2/com/jcabi/jcabi-http`) dependency:

{% highlight xml %}
<dependency>
  <groupId>com.jcabi</groupId>
  <artifactId>jcabi-http</artifactId>
  <version><!-- check http://http.jcabi.com --></version>
</dependency>
{% endhighlight %}

Besides it, you should add one more dependency, which is a Grizzly HTTP server.
[`MkGrizzlyContainer`](http://http.jcabi.com/apidocs-1.3/com/jcabi/http/mock/MkGrizzlyContainer.html) is based on it.

{% highlight xml %}
<dependency>
  <groupId>com.sun.grizzly</groupId>
  <artifactId>grizzly-servlet-webserver</artifactId>
  <version>1.9.59</version>
  <scope>test</scope>
</dependency>
{% endhighlight %}

If you have any questions or suggestions, please submit them through
[Github issues](http://github.com/jcabi/jcabi-http/issues).
As always, bugs are welcome :)
