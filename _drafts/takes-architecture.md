---
layout: post
title: "Webapp Architecture Done Right"
date: 2015-02-10
tags: java
description:
  ...
keywords:
  - java web framework
  - java web development framework
  - best java web framework
  - object-oriented java web framework
  - java web app framework
---

... tbd

<!--more-->

## Java Web Architecture In a Nutshell

This is how I understand a web application architecture and its
components, in simple terms.

First, we should create a new [network socket](http://en.wikipedia.org/wiki/Network_socket),
accepting connections on a certain [TCP port](http://en.wikipedia.org/wiki/Port_%28computer_networking%29).
Usually it is 80, but I'm going to use 8080, for testing purposes.
This is done in Java with [`ServerSocket`](http://docs.oracle.com/javase/7/docs/api/java/net/ServerSocket.html) class:

{% highlight java %}
public class Foo {
  public static void main(final String... args) throws Exception {
    final ServerSocket server = new ServerSocket(8080);
    TimeUnit.SECONDS.sleep(Long.MAX_VALUE);
  }
}
{% endhighlight %}

That's enough to start a web server. Now, the socket is ready and listening
on port 80. When anyone opens `http://localhost:8080` in their browser,
the connection will be established and the browser will spin its waiting
wheel forever. Compile this snippet and try. We just built a simple web
server, without the use of any frameworks. We're not doing anything with
that incoming connections yet, but we're not rejecting them either. All of them
are being lined up inside that `server` object. It does it in a background
thread, that's why we need to do that `sleep()` afterwords. Without this endless pause,
the app will finish its execution immediately and the server socket will
shut down.

The next step is to accept that incoming connections. In Java it's done through
a blocking call to `accept()` method:

{% highlight java %}
final Socket socket = server.accept();
{% endhighlight %}

The method is blocking its thread and waits until a new connection arrives. As
soon as it happens, it returns an instance of `Socket`. In order to accept
the next connection we should call `accept()` again. So, basically, our
web server should work like this:

{% highlight java %}
public class Foo {
  public static void main(final String... args) throws Exception {
    final ServerSocket server = new ServerSocket(8080);
    while (true) {
      final Socket socket = server.accept();
      // 1. Read HTTP request from the socket
      // 2. Prepare an HTTP response
      // 3. Send HTTP response to the socket
      // 4. Close the socket
    }
  }
}
{% endhighlight %}

It's an endless cycle that accepts a new connection, understands it,
creates a response, returns the response and accepts a new connection again.
HTTP protocol is stateless, which means that the servers should not
remember what happened in previous connections. All it cares about is
the incoming HTTP request in this particular connection.

HTTP request is coming from the input stream of the socket and looks like
a multi-line block of text. This is what you would see if you read
an input stream of the socket:

{% highlight java %}
final BufferedReader reader = new BufferedReader(
  new InputStreamReader(socket.getInputStream())
);
while (true) {
  final String line = reader.readLine();
  if (line.isEmpty()) {
    break;
  }
  System.out.println(line);
}
{% endhighlight %}

You will see something like this:

{% highlight text %}
GET / HTTP/1.1
Host: localhost:8080
Connection: keep-alive
Cache-Control: max-age=0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.89 Safari/537.36
Accept-Encoding: gzip, deflate, sdch
Accept-Language: en-US,en;q=0.8,ru;q=0.6,uk;q=0.4
{% endhighlight %}

The client (Google Chrome browser, for example) is sending this text into the
connection established. It connects to the port 8080 at `localhost` and as soon
as the connection is ready it immediately sends this text into it. And waits
for response.

Our job is to create an HTTP response, using the information we get in the
request. If our server is very primitive, we can basically ignore all the
information in the request and just return "hello, world!" to all requests
(I'm using
[`IOUtils`](https://commons.apache.org/proper/commons-io/apidocs/org/apache/commons/io/IOUtils.html)
for simplicity):

{% highlight java %}
import java.net.Socket;
import java.net.ServerSocket;
import org.apache.commons.io.IOUtils;
public class Foo {
  public static void main(final String... args) throws Exception {
    final ServerSocket server = new ServerSocket(8080);
    while (true) {
      try (final Socket socket = server.accept()) {
        IOUtils.copy(
          IOUtils.toInputStream("HTTP/1.1 200 OK\r\n\r\nHello, world!"),
          socket.getOutputStream()
        );
      }
    }
  }
}
{% endhighlight %}

That's it. The server is ready. Try to compile it and run. Point your browser
to http://localhost:8080 and you will see `Hello, world!`:

{% highlight bash %}
$ javac -cp commons-io.jar Foo.java
$ java -cp commons-io.jar:. Foo &
$ curl http://localhost:8080 -v
* Rebuilt URL to: http://localhost:8080/
* Connected to localhost (::1) port 8080 (#0)
> GET / HTTP/1.1
> User-Agent: curl/7.37.1
> Host: localhost:8080
> Accept: */*
>
< HTTP/1.1 200 OK
* no chunk, no close, no size. Assume close to signal end
<
* Closing connection 0
Hello, world!
{% endhighlight %}

That's all you need to build a web server. Now let's discuss how to make
it object-oriented and composable. Let's try to see how [Takes](http://www.takes.org)
framework was built.

## Routing/Dispatching

The most important step is to decide who is responsible for building
an HTTP response. Each HTTP request has 1) a query, 2) a method and 3) a number
of headers. Using these three parameters we need to instantiate an object
who will build a response for us. This process, in most web frameworks,
is called request dispatching or routing. Here is how we do it in Takes:

{% highlight java %}
final Take take = takes.route(request);
final Response response = take.act();
{% endhighlight %}

There are basically two steps. The first one is getting an instance of
[`Take`](http://www.takes.org/apidocs-0.9/org/takes/Take.html)
from `takes` and the second one is getting an instance of `Response` from `take`.
Why it's done this way? Mostly in order to separate responsibilities. An
instance of [`Takes`](http://www.takes.org/apidocs-0.9/org/takes/Takes.html)
is responsible for dispatching a request and instantiating
the right `Take`, and an instance of `Take` is responsible for creating a response.

To create a simple application in Takes, you should create two classes. First,
an implementation of `Takes`:

{% highlight java %}
import org.takes.Request;
import org.takes.Take;
import org.takes.Takes;
public final class TsFoo implements Takes {
  @Override
  public Take route(final Request request) {
    return new TkFoo();
  }
}
{% endhighlight %}

We're using these `Ts` and `Tk` prefixes for
`Takes` and `Take` respectively.
The second class you should create is an implementation of `Take`:

{% highlight java %}
import org.takes.Take;
import org.takes.Response;
import org.takes.rs.RsText;
public final class TkFoo implements Take {
  @Override
  public Response act() {
    return new RsText("Hello, world!");
  }
}
{% endhighlight %}

And now it's time to start a server:

{% highlight java %}
import org.takes.http.Exit;
import org.takes.http.FtBasic;
public class Foo {
  public static void main(final String... args) throws Exception {
    new FtBasic(new TsFoo(), 8080).start(Exit.NEVER);
  }
}
{% endhighlight %}

This [`FtBasic`](http://www.takes.org/apidocs-0.9/org/takes/http/FtBasic.html)
class is doing exactly the same sockets manipulations explained
above. It starts a server socket on port 8080 and dispatches all incoming
connections through an instance of `TsFoo` we are giving to its constructor.
It does this dispatching in an endless cycle, every second checking whether
it's time to stop with an instance of
[`Exit`](http://www.takes.org/apidocs-0.9/org/takes/http/Exit.html).
Obviously, `Exit.NEVER` always responds with "don't stop, please".

## HTTP Request

Let's see what's inside the HTTP request arriving to `TsFoo` and what
we can get out of it. This is how
[`Request`](http://www.takes.org/apidocs-0.9/org/takes/Request.html)
interface is defined in [Takes](http://www.takes.org):

{% highlight java %}
public interface Request {
  List<String> head() throws IOException;
  InputStream body() throws IOException;
}
{% endhighlight %}

The request is divided into two parts, the head and the body. The head
contains all lines that are going before the empty line that starts
a body, according to HTTP specification in RFC ???. There are many useful
decorators of `Request` in the framework. For example, `RqMethod` will
help you to get the method name from the first line of the header:

{% highlight java %}
final String method = new RqMethod(request).method();
{% endhighlight %}

`RqHref` will help to extract the query part and parse it. For example,
this is the request:

{% highlight java %}
GET /user?id=123 HTTP/1.1
Host: www.example.com
{% endhighlight %}

This code will extract that `123`:

{% highlight java %}
final int id = Integer.parseInt(
  new RqHref(request).href().param("id").get(0)
);
{% endhighlight %}

`RqPrint` can get the entire request or its body printed as a `String`:

{% highlight java %}
final String body = new RqPrint(request).printBody();
{% endhighlight %}

The idea here is to keep the `Request` interface simple and provide
this request parsing functionality is decorators. The approach helps the
framework to keep classes small and cohesive. Each decorator is very
small and solid, doing exactly one thing. All of these decorators
are in [`org.takes.rq`](http://www.takes.org/apidocs-0.9/org/takes/rq/index.html) package.
As you already probably understand, the `Rq` prefix stands for `Request`.

## First Real Web App

Let's create the first real web application which will do something
useful. I would recommend to start with an `Entry` class, that is
required by Java to start an app from command line:

{% highlight java %}
import org.takes.http.Exit;
import org.takes.http.FtCLI;
public final class Entry {
  public static void main(final String... args) throws Exception {
    new FtCLI(new TsApp(), args).start(Exit.NEVER);
  }
}
{% endhighlight %}

This class contains just a single `main()` static method that will be
called by JVM when the app starts from command line. As you see, it
instantiates [`FtCLI`](http://www.takes.org/apidocs-0.9/org/takes/http/FtCLI.html),
giving it an instance of class `TsApp` and command
line arguments. We'll create `TsApp` class in a second. `FtCLI`
(decrypts to "front-end with command line interface") makes an instance
of the same `FtBasic`, wrapping it into a few useful decorators and configures
it according to command line arguments. For example, `--port=8080` will
be converted into a `8080` port number and passed as a second argument of
`FtBasic` constructor.

The web application itself is called `TsApp` and extends `TsWrap`:

{% highlight java %}
import org.takes.Take;
import org.takes.Takes;
import org.takes.facets.fork.FkRegex;
import org.takes.facets.fork.TsFork;
import org.takes.ts.TsWrap;
import org.takes.ts.TsClasspath;
final class TsApp extends TsWrap {
  TsApp() {
    super(TsApp.make());
  }
  private static Takes make() {
    return new TsFork(
      new FkRegex("/robots.txt", ""),
      new FkRegex("/css/.*", new TsClasspath()),
      new FkRegex("/", new TkIndex())
    );
  }
}
{% endhighlight %}

We'll discuss this `TsFork` class in a minute.

If you're using Maven, this is the `pom.xml` you should start with:

{% highlight java %}
<?xml version="1.0"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>foo</groupId>
  <artifactId>foo</artifactId>
  <version>1.0-SNAPSHOT</version>
  <dependencies>
    <dependency>
      <groupId>org.takes</groupId>
      <artifactId>takes</artifactId>
      <version>0.9</version> <!-- check the latest in Maven Central -->
    </dependency>
  </dependencies>
  <build>
    <finalName>foo</finalName>
    <plugins>
      <plugin>
        <artifactId>maven-dependency-plugin</artifactId>
        <executions>
          <execution>
            <goals>
              <goal>copy-dependencies</goal>
            </goals>
            <configuration>
              <outputDirectory>${project.build.directory}/deps</outputDirectory>
            </configuration>
          </execution>
        </executions>
      </plugin>
    </plugins>
  </build>
</project>
{% endhighlight %}

Running `mvn clean package` should build a `foo.jar` file in `target` directory
and a collection of all JAR dependencies in `target/deps`. Now you
can run the app from the command line:

{% highlight bash %}
$ mvn clean package
$ java -Dfile.encoding=UTF-8 -cp ./target/foo.jar:./target/deps/* foo.Entry --port=8080
{% endhighlight %}

The application is ready and you can deploy it to, say, Heroku. Just
create `Procfile` file in the root of the repository and push the repo
to Heroku. This is how `Procfile` should look like:

{% highlight text %}
web: java -Dfile.encoding=UTF-8 -cp target/foo.jar:target/deps/* foo.Entry --port=${PORT}
{% endhighlight %}

## TsFork

This `TsFork` class seems to be one of the core elements of the framework. It
helps to route an incoming HTTP request to the right "take". Its logic is very
simple and there are just a few lines of code inside it. It encapsulates
a collection of "forks", which are instances of
[`Fork<Take>`](http://www.takes.org/apidocs-0.9/org/takes/facets/fork/Fork.html) interface:

{% highlight java %}
public interface Fork<T> {
  Iterator<T> route(Request req) throws IOException;
}
{% endhighlight %}

Its only `route()` method either returns an empty iterator or an iterator
with a single `Take`. `TsFork` goes through all forks, calling their
`route()` methods, until one of them returns a take. Once it happens,
`TsFork` returns this take to the caller, which is `FtBasic`.

Let's create a simple fork ourselves now. For example, we want to show
a status of the application when `/status` URL is requested. Here is
the code:

{% highlight java %}
final class TsApp extends TsWrap {
  private static Takes make() {
    return new TsFork(
      new Fork.AtTake() {
        @Override
        public Iterator<Take> route(Request req) {
          final Collection<Take> takes = new ArrayList<>(1);
          if (new RqHref(req).href().path().equals("/status")) {
            takes.add(new TkStatus());
          }
          return takes.iterator();
        }
      }
    );
  }
}
{% endhighlight %}

I believe, the logic is clear here. We either return an empty iterator
or an interator with an instance of `TkStatus` inside. If an empty
iterator is returned, `TsFork` will try to find another fork in the
collection to actually get an instance of `Take`, to produce a `Response`.
By the way, if nothing is found and all forks return empty iterators,
`TsFork` will throw a "page not found" exception.

This exact logic is implemented by an out-of-the-box fork called `FkRegex`,
which attempts to match a request URI path with the regular expression
provided:

{% highlight java %}
final class TsApp extends TsWrap {
  private static Takes make() {
    return new TsFork(
      new FkRegex("/status", new TkStatus())
    );
  }
}
{% endhighlight %}

We can compose a multi-level structure of `TsFork` classes, for example:

{% highlight java %}
final class TsApp extends TsWrap {
  private static Takes make() {
    return new TsFork(
      new FkRegex(
        "/status",
        new TsFork(
          new FkParams("f", "json", new TkStatusJSON()),
          new FkParams("f", "xml", new TkStatusXML())
        )
      )
    );
  }
}
{% endhighlight %}

Again, I believe, it's obvious. The instance of `FkRegex` will ask an
encapsulated instance of `TsFork` to return a "take", and it will try to
fetch it from one of that `FkParams` encapsulated. If HTTP query will
be `/status?f=xml`, an instance of `TkStatusXML` will be returned.

## What About Persistence?


