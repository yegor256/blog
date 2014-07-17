---
layout: post
title: "Fluent Java Http Client"
date: 2014-04-11
tags: jcabi http java
description: I created a simple fluent Java HTTP client to make things easier with HTTP interactions
keywords:
  - alternative to apache http client
  - alternative to HttpURLConnection
  - best java http client library
  - google http java client 1.17.0 rc
  - google java http client
  - google-http-java-client 1.11.0-beta
  - google-http-java-client maven
  - google-http-java-client tutorial
  - google-http-java-client/1.17.0-rc (gzip)
  - http client for java
  - http client in java
  - http client in java example
  - http client in java tutorial
  - http client with java
  - http java client api
  - http java client basic authentication
  - http java client example
  - http java client post
  - http java client sample
  - http post in java http client
  - java
  - java 1.4 http client
  - java 1.6 http client
  - java 6 httpclient
  - java 7 http client
  - java 8 http client
  - java 8 new httpclient
  - java fluent http client
  - java http 1.0 client
  - java http 1.1 client
  - java http 1.1 client example
  - java http client
  - java http client 2013
  - java http client example code
  - java http client example urlconnection
  - java http client get
  - java http client get cookie
  - java http client gui
  - java http client gzip
  - java http client https
  - java http client implementation
  - java http client javascript
  - java http client json
  - java http client keep alive
  - java http client kerberos
  - java http client library
  - java http client load balancing
  - java http client login
  - java http client login form
  - java http client maintain session
  - java http client maven
  - java http client multipart
  - java http client non blocking
  - java http client ntlm
  - java http client oauth
  - java http client on javascript
  - java http client post file upload
  - java http client post xml example
  - java http client sample
  - java http client send xml
  - java http client server example
  - java http client session
  - java http client set header
  - java http client simple
  - java http client socket
  - java http client socket example
  - java http client ssl
  - java http client streaming
  - java http client timeout
  - java http client tutorial
  - java http client upload file
  - java http client user agent
  - java http client username password
  - java http client using proxy
  - java http client with authentication
  - java http client with cookie
  - java http client with javascript
  - java http client with proxy
  - java http client with ssl
  - java http request client ip
  - java http request get client ip
  - java http web service client
  - java http_client_ip
  - java httpclient http/1.1 403 forbidden
  - java httpclient ntlm authentication
  - java httpclient post xml
  - java lightweight http client
  - java multithreaded http client
  - java native http client
  - java net httpclient
  - java netty http client
  - java nio http client example
  - java org apache http client methods httppost
  - java org apache http impl client defaulthttpclient
  - java org.apache.http.client
  - java org.apache.http.client.methods.httppost example
  - java.net http client example
  - sample http client in java
  - simple http client in java
  - write java http client
  - writing http client in java
discussions:
  reddit: http://www.reddit.com/r/java/comments/22rfdc/fluent_java_http_client/
---

{% badge http://img.jcabi.com/logo-square.png 64 %}

In the world of Java, there are plenty of HTTP clients from which to choose.
Nevertheless, I decided to create a new one because none of the other clients
satisfied fully all of my requirements. Maybe, I'm too demanding. Still, this is
how my [jcabi-http](http://http.jcabi.com/) client interacts when you make an
HTTP request and expect a successful HTML page in return:

{% highlight java linenos=table %}
String html = new JdkRequest("https://www.google.com")
  .uri().path("/users").queryParam("id", 333).back()
  .method(Request.GET)
  .header("Accept", "text/html")
  .fetch()
  .as(RestResponse.class)
  .assertStatus(HttpURLConnection.HTTP_OK)
  .body();
{% endhighlight %}

I designed this new client with the following requirements in mind:

<!--more-->

## Simplicity

For me, this was the most important requirement. The client must be simple and
easy to use. In most cases, I need only to make an HTTP request and parse the
JSON response to return a value. For example, this is how I use the new client
to return a current EUR rate:

{% highlight java linenos=table %}
String rate = new JdkRequest("http://www.getexchangerates.com/api/latest.json")
  .header("Accept", "application/json")
  .fetch()
  .as(JsonResponse.class)
  .json().readArray().getJsonObject(0)
  .getString("EUR");
{% endhighlight %}

I assume that the above is easy to understand and maintain.

## Fluent Interface

The new client has to be fluent, which means that the entire server interaction
fits into one Java statement. Why is this important? I think that [fluent
interface](http://martinfowler.com/bliki/FluentInterface.html) is the most
compact and expressive way to perform multiple imperative calls. To my
knowledge, none of the existing libraries enable this type of fluency.

## Testable and Extendable

I'm a big fan of interfaces, mostly because they make your designs both cleaner
and highly extendable at the same time. In [jcabi-http](http://http.jcabi.com/),
there are five interfaces extended by 20 classes.

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
which make actual HTTP calls to the server using two completely different technologies: (JDK `HttpURLConnection` and Apache Http Client, respectively). In the future, it will be possible to introduce new implementations without breaking existing code.

Say, for instance, I want to fetch a page and then do something with it. These two calls perform the task differently, but the end results are the same:

{% highlight java %}
String uri = "http://www.google.com";
Response page;
page = new JdkRequest(uri).fetch();
page = new ApacheRequest(uri).fetch();
{% endhighlight %}

## XML and JSON Out-of-the-Box

There are two common standards that I wanted the library to support right out of
the box. In most cases, the response retrieved from a server is in either XML or
JSON format. It has always been a hassle, and extra work, for me to parse the
output to take care of formatting issues.

[jcabi-http](http://http.jcabi.com/) client supports them both out of the box,
and it's possible to add more formats in the future as needed. For example, you
can fetch XML and retrieve a string value from its element:

{% highlight java %}
String name = new JdkRequest("http://my-api.example.com")
  .header("Accept", "text/xml")
  .fetch()
  .as(XmlResponse.class)
  .xml().xpath("/root/name/text()").get(0);
{% endhighlight %}

Basically, the response produced by `fetch()` is decorated by `XmlResponse`. This then exposes the `xml()` method that returns an instance of the [`XML`](http://xml.jcabi.com/apidocs-0.7.7/com/jcabi/xml/XML.html) interface.

The same can be done with JSON through the Java JSON API
([JSR-353](https://jcp.org/en/jsr/detail?id=353)).

None of the libraries that I'm aware of or worked with offer this feature.

## Immutable

The last requirement, but certainly not the least important, is that I need all interfaces of the
library to be annotated with [`@Immutable`](http://http://aspects.jcabi.com/annotation-immutable.html).
This is important because I need to be able to encapsulate an instance of `Request` in other immutable classes.
