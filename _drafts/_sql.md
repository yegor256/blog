---
layout: post
title: "SQL as a Service"
date: 2019-10-22
place: Shenzhen, China
tags: pets
description: |
  ...
keywords:
  - sql as a service
  - db as a service
  - sql in cloud
  - sql as service
  - data in cloud
image: /images/2019/10/
jb_picture:
  caption: ...
---

I'm been thinking about this since 2007, somewhere around the time
[S3](https://aws.amazon.com/s3/)
was [launched](https://en.wikipedia.org/wiki/Amazon_Web_Services) by Amazon.
I even tried to implement it a few times, but failed right after the
design phase. I've even heard about a startup, which tried to do it,
but also [failed](https://en.wikipedia.org/wiki/Xeround). I'm still not sure
whether it's possible to do, but it would definitely be a best seller on
the market of cloud data management. Wait, you may say, what about
Google Cloud SQL,
AWS RDS, Microsoft Azure, Heroku PostgreSQL, and [many others](https://en.wikipedia.org/wiki/Cloud_database)?
They are not even close to what I mean.

<!--more-->

{% jb_picture_body %}

Say, you want to host a binary data objects in the cloud. I have two
solutions for you. The first one is a hosted server
with [FTP](https://en.wikipedia.org/wiki/File_Transfer_Protocol). You pay
me $5 per month, I give you FTP access to a server with a disk of 100Gb. You
can upload your files there and download back. Works just fine. However,
AWS created S3, which was a much better solution. Why? What was wrong with good
old FTP? Why S3 became such a breakthrough in online data management?

This is why S3 is better than FTP:

  *





















