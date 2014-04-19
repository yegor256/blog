---
layout: post
title: "Basic HTTP Authentication for S3 Buckets"
date: 2014-04-19
tags: cloud
description:
  Since Amazon S3 doesn't allow you to secure access
  to buckets with HTTP Basic Authentication, I've
  created a free cloud service for this purpose
keywords:
  - github api
  - github java api
  - github object oriented java api
  - best github java api
  - java api github
---

<img src="http://img.s3auth.com/logo.png"
  style="width: 200px; float: right; margin-left: 2em;"/>

[Amazon S3](http://aws.amazon.com/s3)
is a simple and very useful storage of binary
objects (aka "files"). You create a "bucket"
there with a unique name, and upload your objects.
AWS guarantees that they will be available for
download through their RESTful API.

A few years ago AWS introduced a feature for S3 called static
website hosting. You simply turn this feature on and all
your objects in a bucket become available through public HTTP.
Awesome feature for hosting of static content, like images,
JavaScript files, video, and audio content. Then you need
to change the CNAME record in your DNS and point it to
`www.example.com.aws.amazon.com` and your static website
is available at `www.example.com`.

However, it is not possible to protect your website anyhow.
Since the content is purely static, you can't have any
login page in front of it. You can either make your objects
absolutely public and everybody will be able to see them
online, or you can assign access rights to them but only
for the users connected through RESTful API.

My use case was a bit more complex. I wanted to have my static content
hosted as S3 objects and make sure that only a few people can get
access to them using their web browsers.

## HTTP Basic Authentication

HTTP protocol offers a nice feature of user authentication that doesn't
require any extra site pages. When HTTP request arrives to the
server it doesn't deliver the content but replies with
a response with status 401. This literally means "I don't know who you
are, please authenticate yourself."

The browser shows its native login screen and asks for the user name
and password. Whatever you enter is concatenated, Base64 encoded, and
added to the next request in `Authentication` HTTP header.

Now the browser is trying to make another attempt to fetch the same
web page. But at this time HTTP request contains a header
`Authorization: Basic am9lOnNlY3JldA==`. This is just an example.
Base64 encoded part of this example means `joe:secret`, where `joe` is
the user name and `secret` is the password entered by the user.

This time the server has authentication information and can make
a decision whether this user is authenticated (his password matches
server's records) and authorized (he has permissions to access the web page).

## s3auth.com

Since Amazon doesn't provide this feature I decided to create
a simple web service [s3auth.com](http://www.s3auth.com),
which will stay in front of my Amazon S3 buckets
and implement this HTTP-native authentication and authorization mechanism.

Instead of making my objects public, I make them private and point
my CNAME record to `relay.s3auth.com`. HTTP requests from web browsers
arrive to my server, it connects to Amazon S3, retrieves my objects,
and delivers them back in HTTP responses.

The server implements authentication and authorization using a
special file `.passwd` in the root of my bucket. The format of the
file is identical to the one used by Apache HTTP Server &mdash; one user per
line. Every line has a name of the user and a hash version of his password.

## Implementation

I made this software open source, mostly in order to guarantee to my
users that the server doesn't store their private data anywhere, but
only sends them through. So, it is in
[Github](https://github.com/yegor256/s3auth).

For the sake of privacy and convenience I'm using only OAuth2
for user accounts. This means that I don't know who my users are. I don't
have their names or emails, only their account numbers in Facebook, Google Plus
or Github. Well, I can find their names using these numbers, but this
information is public anyway.

The server is implemented in Java6. For its hosting I'm using
a single Amazon EC2 [m1.small](...) Ubuntu server. Recently, it appears to
be working pretty stable, according to Pingdom:


## Extra Features

Besides authentication and authorization [s3auth.com](http://www.s3auth.com)
server can render lists of pages, just like Apache HTTP Server. If you have
a collection of objects in your bucket, but `index.html` is absent,
Amazon S3 will give you a "page not found" result. My server will
show you a list of objects in the bucket and make it possible to
one folder up or down.

## Traction

I created this service mostly for myself, but apparently I'm not alone
with this problem. At the moment [s3auth.com](http://www.s3auth.com)
hosts over 300 domains and sends through over 1Mb of data per second.

BTW, it all started from this StackOverflow question :)
