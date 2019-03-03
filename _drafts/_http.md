---
layout: post
title: "How to Create a Java Web Framework from Scratch the Right Object-Oriented Way"
date: 2019-02-28
place: Moscow, Russia
tags: java oop
description: |
  ...
keywords:
  - java web framework
  - java http framework
  - oop web framework
  - java web oop
  - oop java web
image: /images/2019/02/...
jb_picture:
  caption:
---

How do you design a web application in Java? You install Spring, read
the manual, create controllers, some views, add some annotations, and it
works. What would you do if there would be no Spring (and no Ruby on Rails
in Ruby, and no Symphony in PHP, and no ... etc.)? Let's try to create
a web application from scratch, starting from a pure Java SDK and ending
with a fully functionable web app, covered by unit tests. I recorded
a [webinar no.42](https://www.youtube.com/watch?v=bVzEPOZ_mDU)
about it just a few weeks ago, but this article should explain it
all even in more details.

<!--more-->

{% jb_picture_body %}

First of all we have to create a HTTP server, which will open a
server socket, listen to incoming connections, read everything they
have to say (HTTP requests) and return back the information any
web browser will like (HTTP responses). You know how
[HTTP](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol) works, right?
If you don't, here is a quick reminder.

A web browser sends a request to the server and the request looks
like this (it's a plain text piece of data):

{% highlight text %}
GET /index.html HTTP/1.1
Host: www.example.com
{% endhighlight %}

The server has to read this text, prepare the answer (which has to be the
HTML page readable by the browser) and return it back like this:

{% highlight text %}
HTTP/1.1 200 OK
Content-Type: text/html; charset=UTF-8
Content-Length: 26

<html>Hello, world!</html>
{% endhighlight %}

That's it. It's a very simple and I would say primitive protocol. The implementation
of a web server in Java is not so complex too. Here it is, in a very
primitive form:

{% highlight java %}
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.util.Arrays;
public class Main {
  public static void main(String... argv) {
    try (ServerSocket server = new ServerSocket(8080)) {
      server.setSoTimeout(1000);
      while (true) {
        try (Socket socket = server.accept()) {
          try (InputStream input = socket.getInputStream();
            OutputStream output = socket.getOutputStream()) {
            byte[] buffer = new byte[10000];
            int total = input.read(buffer);
            String request = new String(Arrays.copyOfRange(buffer, 0, total));
            String response = "HTTP/1.1 200 OK\r\n\r\nHello, world!";
            output.write(response.getBytes());
          }
        } catch (SocketTimeoutException ex) {
          if (Thread.currentThread().isInterrupted()) {
              break;
          }
        }
      }
    }
  }
}
{% endhighlight %}

Try to run it, it should work. You should be able to open the `http://localhost:8080`
page in your browser and see `Hello, world!` text.

It's not yet a web app, but a skeleton, which does a simple dispatching
of HTTP requests into HTTP responses. There is nothing serious about OOP
in it, though. It's pretty procedural, but it works. Now we should focus
on a more important question: how to add more features to the web app
and make it possible to process different pages, render larger content,
and handle errors. The `request` variable should be somehow converted to the
`response` one.

The easiest way would be 1) to convert the request into a DTO with all
the details inside, then 2) send it to a "controller" that knows what to
do with the data from the DTO, and then 3) receive a response DTO from
the controller, take the data out and render the response. This is how
Spring and <del>most</del> all other frameworks do it. We won't follow this
path, we will try to do it DTO-free and purely object-oriented.

I have to say that there could be multiple designs, all in OOP style. I'll
show you now only one of the options. You know our Takes framework, which
was born a few years ago---it has its own design, also object-oriented. But they
one I'm going to suggest now seems to be a better one. You may come up
with something else too, don't hesitate to post your ideas in the comments
below or even create a GitHub repo and share your thoughts right there.
