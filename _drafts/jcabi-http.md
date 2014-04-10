---
layout: post
title: "Fluent Java Http Client"
date: 2014-04-10
tags: jcabi http java
---

There are plenty of HTTP clients in Java world, nevertheless I decided
to create a new one, because none of them satisfy my requirements. Maybe
I'm too demanding, but this is how
my [jcabi-http](http://http.jcabi.com/) interacts with you
when you're making an HTTP request and expecting a successful
HTML page in return:

{% highlight java linenos=table %}
String html = new JdkRequest("https://www.google.com")
  .uri().path("/users").queryParam("id", 333).back()
  .method(Request.GET)
  .header("Accept", "text/html")
  .fetch()
  .as(HttpResponse.class)
  .assertStatus(HttpURLConnection.HTTP_OK)
  .body();
{% endhighlight %}

I designed this new client with the following requirements in mind.

## Simple

This was the most important requirement. It had to be simple and easy
to use. In most cases, I need just to make an HTTP request and parse
JSON response to get a value back.

For example, this is how you get a current EUR rate:

{% highlight java linenos=table %}
String rate = new JdkRequest("http://www.getexchangerates.com/api/latest.json")
  .header("Accept", "application/json")
  .fetch()
  .as(JsonResponse.class)
  .json().readArray().getJsonObject(0)
  .getString("EUR");
{% endhighlight %}

I assume, it's easy to understand and maintain.

## Fluent Interface

It has to be purely fluent, which means that the entire interaction
with the server should fit into one Java statement. Why it's important?
I think that [fluent interface](http://martinfowler.com/bliki/FluentInterface.html)
is the most compact and expressive way to do multiple imperative calls.

To my knowledge, none of the existing libraries enable this.

## Testable and Extendable

I'm a big fan of interfaces. Mostly because they make your design
highly extendable and clean at the same time.
In [jcabi-http](http://http.jcabi.com/)
there are five interfaces that are extended by 20 classes.

[`Request`](http://http.jcabi.com/apidocs-1.3/com/jcabi/http/Request.html)
is an interface, as well as
[`Response`](http://http.jcabi.com/apidocs-1.3/com/jcabi/http/Response.html),
[`RequestURI`](http://http.jcabi.com/apidocs-1.3/com/jcabi/http/RequestURI.html),
and
[`RequestBody`](http://http.jcabi.com/apidocs-1.3/com/jcabi/http/RequestBody.html)
exposed by it.

Use of interfaces makes the library highly extendable. For example, we have
[`JdkRequest`](http://http.jcabi.com/apidocs-1.3/com/jcabi/http/request/JdkRequest.html)
and
[`ApacheRequest`](http://http.jcabi.com/apidocs-1.3/com/jcabi/http/request/ApacheRequest.html),
which are making an actual HTTP
call to the server using two completely different technologies
(JDK `HttpURLConnection` and Apache Http Client, accordingly). In the future,
it will be possible to introduce new implementation, without breaking
anything in the existing code.

Say, I want to fetch a page and then do something with it. These two
calls will do it differently, but the result will be the same:

{% highlight java linenos=table %}
String uri = "http://www.google.com";
Response page;
page = new JdkRequest(uri).fetch();
page = new ApacheRequest(uri).fetch();
{% endhighlight %}

## XML and JSON out-of-the-box

There are two common standards that I wanted the library to support
out of the box. In most cases, the response we get from a server is
in either XML or JSON format. It has always been an extra hassle for me
to parse the output, taking care of all the formatting issues.

[jcabi-http](http://http.jcabi.com/)
client supports them both out of the box, and it's possible
to add more formats in the future. For example, you can fetch an
XML and get a string value out of its element:

{% highlight java linenos=table %}
String name = new JdkRequest("http://my-api.example.com")
  .header("Accept", "text/xml")
  .fetch()
  .as(XmlResponse.class)
  .xml().xpath("/root/name/text()").get(0);
{% endhighlight %}

Basically, the response produced by `fetch()` is decorated by
`XmlResponse`, which exposes `xml()` method that returns
an instance of
[`XML`](http://xml.jcabi.com/apidocs-0.7.7/com/jcabi/xml/XML.html) interface.

The same can be done with JSON through Java JSON API
([JSR-353](https://jcp.org/en/jsr/detail?id=353)).

None of the libraries that I'm aware of offer this feature.

## Immutable

The last but not the least. I need all interfaces of the
library to be annotated with
[`@Immutable`](http://http://aspects.jcabi.com/annotation-immutable.html).
Why this is important? Because I need to be able to encapsulate
an instance of `Request` in other immutable classes.
