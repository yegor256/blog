---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "SQL as a Service"
date: 2019-10-29
place: Shenzhen, China
tags: pets
description: |
  Even though cloud computing is more than ten years old
  and there are a dozen relational data hosters, we still
  don't have a true relational data service.
keywords:
  - sql as a service
  - db as a service
  - sql in cloud
  - sql as service
  - data in cloud
image: /images/2019/10/la-dolce-vita.jpg
jb_picture:
  caption: La Dolce Vita (1960) by Federico Fellini
---

I've been thinking about this since 2007, somewhere around the time
[S3](https://aws.amazon.com/s3/)
was [launched](https://en.wikipedia.org/wiki/Amazon_Web_Services) by Amazon.
I even tried to implement it a few times, but failed right after the
design phase. I've heard about a startup, which tried to do it too,
but also [failed](https://en.wikipedia.org/wiki/Xeround). I'm still not sure
whether it's possible to do, but it could definitely become a best seller in
the market of cloud data management. Wait, you may say, what about
Google Cloud SQL, AWS RDS, Microsoft Azure, Heroku PostgreSQL,
and [many others](https://en.wikipedia.org/wiki/Cloud_database)?
They are not even close to what I mean.

<!--more-->

{% jb_picture_body %}

Let me give you an analogy. Say you want to store a piece of binary data in the cloud. I have two
solutions for you. The first one is a hosted server
with [FTP](https://en.wikipedia.org/wiki/File_Transfer_Protocol). You pay
me $5 per month, I give you FTP access to the server, which has a disk of 100Gb. You
can upload your files there and download back. Works just fine.
And I have a second option, which is [AWS S3](https://aws.amazon.com/s3/).
You can also upload and download
your data, but via their [API](https://docs.aws.amazon.com/AmazonS3/latest/API/Welcome.html).
And you [pay](https://aws.amazon.com/s3/pricing/) for each API request,
each byte hosted, and each byte transferred, instead of a monthly fee.
Which one would you choose?

Obviously, you would go with S3. Why? What is the fundamental difference
between these two? The key difference is in their [SLAs](https://en.wikipedia.org/wiki/Service-level_agreement):
The first one with an FTP is a _server_, the second one is a _service_.

An FTP server provider guarantees you the availability of computational resources (CPU, disk, bandwidth, etc.),
while S3 guarantees you the availability of the data. If the disk on the
FTP server crashes it will be replaced in a timely manner, but the
data will be lost. If the disk gets full, you will be able to order
an additional server, but it's your responsibility not to forget. If the
disk space is not used, you still pay $5 per month. And so on.

AWS S3 was such a breakthrough in the market, more than ten years ago, precisely
because of this difference. They added a new _service layer_ on top of the good
old [web hosting](https://en.wikipedia.org/wiki/Web_hosting_service)
we were all used to. The idea remained the same---it's still data
in the cloud, which we upload and download---but the SLA was different. We didn't
need to worry anymore about disk overflow, paying too much for unused space,
regular backups, SSH terminals, and many more things. They just gave us a simple API and
a promise that the data was there and was safe.

It's 2019 now and we still don't have the same for relational data. No matter
which provider you choose, all they do is give you a machine (or a cluster)
with MySQL or PostgreSQL installed (or their own version of them) and
charge you per hour of uptime. They still give you the "good old FTP" without
an additional service layer on top of it.

This is what I would expect a _true_ relational-data-in-the-cloud SLA to sound like:

  * **Auto-scale**.
    Don't make us worry about the amount of resources required to host
    the data. Just charge more for larger data sets and make sure
    our requests come back in a predictable amount of time.

  * **Pay-per-data**.
    Make us pay for each SQL request, each byte stored, and
    each byte transferred. How many servers and disks are required to host
    it all---that must not be of our concern.

  * **Restricted SQL**.
    The majority of commands in
    [MySQL](https://dev.mysql.com/doc/refman/8.0/en/sql-syntax.html) or
    [PostgreSQL](https://www.postgresql.org/docs/12/sql.html) dialects are
    not required by the majority of projects. Just give us
    `INSERT`, `SELECT`, `UPDATE`, and `DELETE` and call it a day.

  * **Indexes**.
    Create them automatically, using the statistics of the SQL queries
    we are making.

  * **Schema Versioning**.
    Make it possible to update the schema via something similar to
    [Liquibase](https://www.liquibase.org/): we create a new `ALTER TABLE` or `CREATE TABLE` script
    and it gets applied to the existing database.

  * **Snapshots and Rollbacks**.
    Make it possible to make a snapshot of the data, apply a new schema
    version, and then rollback to one of the previously made snapshots if something
    is wrong.

Is it really so hard to implement?
