# Try. Finally. If. Not. Null.

Source: https://www.yegor256.com/2016/03/22/try-finally-if-not-null.html

There is a very typical mistake in pre-Java7 "try/finally" scenario,
which I keep seeing in so many code reviews. I just have to write about it.
Java7 introduced a solution, but it doesn't cover all situations.
Sometimes we need to deal with non-`AutoCloseable` resources. Let's
open and close them correctly, please.


{% jb_picture_body %}

This is how it looks (assuming we are in Java 6):

```java
InputStream input = null;
try {
  input = url.openStream();
  // reads the stream, throws IOException
} catch (IOException ex) {
  throw new RuntimeException(ex);
} finally {
  if (input != null) {
    input.close();
  }
}
```

{% youtube o3aNJX7AP3M %}

I already wrote about [`null`]({% pst 2014/may/2014-05-13-why-null-is-bad %})
and its evil nature. Here it comes again. If you just follow the rule
of "not using NULL anywhere ever," this code would need an immediate
refactoring. Its correct version will look like this:

```java
final InputStream input = url.openStream();
try {
  // reads the stream, throws IOException
} catch (IOException ex) {
  throw new RuntimeException(ex);
} finally {
  input.close();
}
```

There is no `null` anymore and it's very clean. Isn't it?

There are situations when opening the resource itself throws `IOException`
and we can't put it outside of `try/catch`. In that case, we have to have
**two** `try/catch` blocks:

```java
final InputStream input;
try {
  input = url.openStream();
} catch (IOException ex) {
  throw new RuntimeException(ex);
}
try {
  // reads the stream, throws IOException
} catch (IOException ex) {
  throw new RuntimeException(ex);
} finally {
  input.close();
}
```

But there should be no `null`, never!

The presence of `null` in Java code is a clear indicator of code smell. Something
is not right if you have to use `null`. The only place where the presence of `null`
is justified is where we're using third-party APIs or JDK. They may return
`null` sometimes because... well, their design is bad. We have
no other option but to do `if(x==null)`. But that's it. No other places
are good for `null`.
