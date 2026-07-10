# How to Retry Java Method Call on Exception

Source: https://www.yegor256.com/2014/08/15/retry-java-method-on-exception.html

{% badge https://www.jcabi.com/logo-square.svg 64 https://aspects.jcabi.com %}

If you have a method that fails occasionally and
you want to retry it a few times before
[throwing]({% pst 2015/dec/2015-12-01-rethrow-exceptions %})
an exception. [`@RetryOnFailure`](https://aspects.jcabi.com/annotation-retryonfailure.html) from
[jcabi-aspects](https://aspects.jcabi.com) can help.
For example, if you're downloading the following web page:

```java
@RetryOnFailure(
  attempts = 3,
  delay = 10,
  unit = TimeUnit.SECONDS
)
public String load(URL url) {
  return url.openConnection().getContent();
}
```

This method call will throw an exception only after three
failed executions with a ten seconds interval between them.


[This post]({% pst 2014/jun/2014-06-01-aop-aspectj-java-method-logging %})
explains how [jcabi-aspects](https://aspects.jcabi.com)
works with binary weaving. This mechanism integrates AspectJ with
your code.

When method `load()` from the example above is called, this is what
is happening behind the scene (pseudo-code):

```java
while (attempts++ < 3) {
  try {
    return original_load(url);
  } catch (Throwable ex) {
    log("we failed, will try again in 10 seconds");
    sleep(10);
  }
}
```

This approach may be very useful in the following situations
(based on my experience):

 * Executing [JDBC]({% pst 2014/aug/2014-08-18-fluent-jdbc-decorator %}) `SELECT` statements

 * Loading data from HTTP, [S3]({% pst 2014/may/2014-05-26-amazon-s3-java-oop-adapter %}), FTP, etc resources

 * Uploading data over the network

 * Fetching data through RESTful stateless API-s

The project is in [GitHub](https://github.com/jcabi/jcabi-aspects).
