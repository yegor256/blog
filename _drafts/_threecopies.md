---
layout: post
title: "ThreeCopies.com&mdash;Server-Side Data Backup Service"
date: 2017-09-25
place: Odessa, Ukraine
tags: pets
description: |
  How do you backup your server data? I created this
  web service to get rid of backup servers entirely.
keywords:
  - data pipeline
  - online backup
  - server data backup
  - server-side backup service
  - threecopies
---

{% badge http://www.threecopies.com/images/logo.png 64 http://www.threecopies.com %}

I have a number of data resources, which exist in one copy only and which
I don't really want to lose. For example, I have a PHP website hosted at
some sharing hosting, and a MySQL database at the same hosting, also
a NoSQL database at Amazon DynamoDB, also a PostgreSQL database at
Heroku, also... There are many of them. How to backup them was always a
question for me.

<!--more-->

{% jb_picture_body %}

The most straight-forward way is to rent a cheap $15/mo server
(or use an existing one) and configure Cron to run a custom bash
script, which will pull the data from the MySQL database, package it,
and upload to some place where it will be safe, for example Amazon S3
bucket. Then, another script for the PostgreSQL database, and another one
for the FTP file archive, etc.

This is actually how I was doing it for years. The drawbacks
of this solution were always the same:

  * I needed to pay for the server.
  * I needed to make sure the server was always up and running (Linux is far from being very reliable).
  * I needed to backup my scripts too.
  * I needed to SSH to the server every time I wanted to change the script, remember where they are, how they start, etc.

The biggest issue is that every single owner of a data source faces
exactly the same set of problems. "Why can't I create a hosted solution for
these scripts, to help everybody to backup their data," I was asking myself
for years. "Yes, I can," was the answer just a few weeks ago, and
I created [ThreeCopies](http://www.threecopies.com).

It's a very simple hosted executor of bash scripts, which you edit
through a web interface. Then, one of our servers starts a Docker
container ([yegor256/threecopies](https://hub.docker.com/r/yegor256/threecopies/) is the image, here is the
[`Dockerfile`](https://github.com/yegor256/threecopies/blob/master/src/docker/Dockerfile))
and runs your script inside.

The script starts every hour, every day and every week.
That's why the name: "three copies." It's a good practice for data backup
to create separate copies with different regularities. Also, you may put
different data into different copies. To help your script understand which
copy is running now we pass `$period` environment variable into it, with
the value of either `hour`, `day`, or `week`.

How your script pulls the data, packages it, and archives&mdash;depends on the
data. I created a short cheat sheet for most common scenarios. This is how
I backup MySQL database of [thePMP](http://www.thepmp.com), for example:

{% highlight bash %}
# I don't want to backup every hour
if [ "${period}" == "hour" ]; then exit 0; fi

# I dump the entire database into the file
mysqldump --lock-tables=false --host=db.thepmp.com \
  --user=thepmp --password=********* \
  --databases thepmp > thepmp.sql

# I compress the file
tgz="$(date "+%Y-%m-%d-%H-%M").tgz"
tar czf "${tgz}" thepmp.sql

# I upload it to Amazon S3 bucket
echo "[default]" > ~/.s3cfg
echo "access_key=AKIAICJKH*****CVLAFA" >> ~/.s3cfg
echo "secret_key=yQv3g3ao654Ns**********H1xQSfZlTkseA0haG" >> ~/.s3cfg
s3cmd --no-progress put "${tgz}" "s3://backup.yegor256.com/${tgz}"
{% endhighlight %}

The output of the script is available through the web interface and this
is yet another benefit of this solution. It's easy to monitor what was
wrong and restart the script. All logs are available through the browser. No
SSH, no terminals.

I would say that it's a light version of
[AWS Data Pipeline](https://aws.amazon.com/datapipeline/). [ThreeCopies](http://www.threecopies.com)
does exactly the same, but it's easier to configure, and it's cheaper.
I'm charging $0.01 per each script execution hour. I actually charge
per second, while AWS always charges for a full hour. For $5.00 you get
500 hours. For example, the script you see above takes about 5 minutes
to complete (database is not huge). If you skip the hourly executions, like I did above, you
will consume 150 minutes of the server time every month, which will cost you
**$0.30 per year**! This is much cheaper than a server and
its monitoring, I believe.

One more thing, before you go. ThreeCopies is written in Java&nbsp;8 and is open source,
find it [in GitHub](https://github.com/yegor256/threecopies). Feel free to
inspect the code, find bugs, and contribute with fixes or improvements.

