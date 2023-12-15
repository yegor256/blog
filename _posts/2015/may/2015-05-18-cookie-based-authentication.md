---
layout: post
title: "How Cookie-Based Authentication Works in the Takes Framework"
date: 2015-05-18
tags: java pets
description: |
  Cookie-based authentication is a simple and powerful mechanism
  to enable website user login in a RESTful and lightweight way;
  the Takes framework does it with a few composable decorators.
keywords:
  - cookie based authentication
  - cookies for authentication
  - cookie authentication best practices
  - cookie authentication web api
  - cookie authentication security
---

{% badge https://www.takes.org/logo.png 96 https://www.takes.org %}

When you enter your email and password into the Facebook login page,
you get into your account. Then, wherever you go in the site,
you always see your photo at the top right corner of the page. Facebook
remembers you and doesn't ask for the password again and again. This works
thanks to [HTTP cookies](https://en.wikipedia.org/wiki/HTTP_cookie)
and is called _cookie-based authentication_. Even though this mechanism
often causes some security problems, it is very popular and simple.
Here is how [Takes](https://www.takes.org) makes it possible in a few lines of code.

<!--more-->

First, let's see how it works. Moreover, let's see how I believe it should work.

Step one: The user enters an email and password and clicks "submit." The server
receives a POST request with this information inside:

```text
POST / HTTP/1.1
Host: www.facebook.com
Content-Type: application/x-www-form-urlencoded

email=me@yegor256.com&password=itisasecret
```

The server matches the provided information with its records and decides what to do.
If the information is invalid, it returns the same login page, asking you to
enter it all again. If the information is valid, the server returns something
like this:

```text
HTTP/1.1 303 See Other
Location: www.facebook.com
Set-Cookie: user=me@yegor256.com
```

Since the response status code is 303, the browser goes to the page
specified in the `Location` header and opens the front page of the site. This
is what it sends to the server:

```text
GET / HTTP/1.1
Host: www.facebook.com
Cookie: user=me@yegor256.com
```

The server gets my email from the `Cookie`
header and understands that it's me again! No need to ask for the
password once more. The server trusts the information from the cookie.
That's it. That's what cookie-based authentication is all about.

## Wait ... What About Security?

Right, what about security? If the server trusts any browser request with
a user email in the `Cookie` header, anyone would be able to send my email
from another place and get access to my account.

The first step to prevent this is to encrypt the email with a secret
encryption key, known only to the server. Nobody except the server itself
will be able to encrypt it the same way the server needs to decrypt it.
The response would look like this, using an example of encryption
by [XOR cipher](https://en.wikipedia.org/wiki/XOR_cipher) with `bamboo` as a secret key:

```text
HTTP/1.1 303 See Other
Location: www.facebook.com
Set-Cookie: user=b1ccafd92c568515100f5c4d104671003cfa39
```

This is not the best encryption mechanism, though; for proper encryption, it's better
to use something stronger like [DES](https://en.wikipedia.org/wiki/Data_Encryption_Standard).

This all sounds good, but what if someone hijacks the traffic between the server and the
browser and gets a hold of a properly encrypted email cookie? In this case,
the thief would be able to use the same cookie for authentication even without
knowing its content. The server would trust the information and let the
person into my account. This type of attack is called
[man-in-the-middle](https://en.wikipedia.org/wiki/Man-in-the-middle_attack) (MITM).
To prevent this from happening, we should use HTTPS and inform the browser
that the cookie is sensitive and should never be returned to the server without
SSL encryption. That's done by an extra flag in the `Set-Cookie` header:

```text
HTTP/1.1 303 See Other
Location: www.facebook.com
Set-Cookie: user=me@yegor256.com; Secure
```

There is yet another type of attack associated with cookie-based authentication,
based on a browser's ability to expose all cookies associated with a web page
to JavaScript executed inside it. An attacker may inject some malicious
JavaScript code into the page (Don't ask me how ... this will happen only
if your entire HTML rendering is done wrong), and this code will gain access
to the cookie. Then, the code will send the cookie somewhere else so
the attacker can collect it. This type of attack is called
[cross-site scripting](https://en.wikipedia.org/wiki/Cross-site_scripting) (XSS).
To prevent this, there is another flag for the `Set-Cookie` header, called `HttpOnly`:

```text
HTTP/1.1 303 See Other
Location: www.facebook.com
Set-Cookie: user=me@yegor256.com; Secure; HttpOnly
```

The presence of this flag will tell the browser that this particular cookie can
be transferred back to the server only through HTTP requests. JavaScript won't
have access to it.

## How It's Done in Takes

Here is how this cookie-based authentication mechanism is designed in the
[Takes](https://www.takes.org) framework. The entire framework consists of
_takes_, which receive requests and produce responses
([this article]({% pst 2015/mar/2015-03-22-takes-java-web-framework %})
explains the framework in more detail). When the request comes in,
we should find the authentication cookie in the `Cookie` header and translate
it to the user credentials. When the response goes out, we should add the
`Set-Cookie` header to it with the encrypted user credentials. That's it. Just
these two steps.

Let's say we have an account page that is supposed to show the current user's
balance:

```java
final class TkAccount implements Take {
  private final Balances balances;
  @Override
  public Response act(final Request request) {
    final Identity user = // get it from request
    return RsHTML(
      String.format(
        "<html>Your balance is %s</html>",
        this.balances.retrieve(user)
      )
    );
  }
}
```

Right after the `request` comes in, we should retrieve the identity of
the user, encoded inside an authenticating cookie. To make this mechanism
reusable, we have the [`TkAuth`](http://static.javadoc.io/org.takes/takes/1.1/org/takes/facets/auth/TkAuth.html)
decorator, which wraps an existing _take_,
decodes an incoming cookie, and adds a new `TkAuth`
header to the request with the user's identification information:

```java
final Codec codec = new CcHex(new CcXOR(new CcPlain()));
final Pass pass = new PsCookie(codec);
new TkAuth(new TkAccount(), pass);
```

Again, when `TkAuth` receives a request with an authenticating cookie inside,
it asks `pass` to decode the cookie and return either a
valid [`Identity`](http://static.javadoc.io/org.takes/takes/1.1/org/takes/facets/auth/Identity.html)
or `Identity.ANONYMOUS`.

Then, when the response goes back to the browser, `TkAuth` asks `pass`
to encode the identity back into a string and adds `Set-Cookie` to the response.

[`PsCookie`](http://static.javadoc.io/org.takes/takes/1.1/org/takes/facets/auth/PsCookie.html)
uses an instance of
[`Codec`](http://static.javadoc.io/org.takes/takes/1.1/org/takes/facets/auth/codecs/Codec.html)
in order to do these backward and forward encoding operations.

When our `TkAccount` _take_ wants to retrieve a currently authenticated
user identity from the request, it can use
[`RqAuth`](http://static.javadoc.io/org.takes/takes/1.1/org/takes/facets/auth/RqAuth.html),
a utility decorator of [`Request`](http://static.javadoc.io/org.takes/takes/1.1/org/takes/Request.html):

```java
final class TkAccount implements Take {
  @Override
  public Response act(final Request request) {
    final Identity user = new RqAuth(request).identity();
    // other manipulations with the user
  }
}
```

The `RqAuth` decorator uses the header, added by `PsCookie`, in order
to authenticate the user and create an `Identity` object.

## How Is It Composable?

This mechanism is indeed very extensible and "composable." Let's say we
want to skip authentication during integration testing. Here is how:

```java
new TkAuth(
  take, // original application "take"
  new PsChain(
    new PsFake(/* if running integration tests */),
    new PsCookie(
      new CcHex(new CcXOR(new CcPlain()))
    )
  )
);
```

[`PsChain`](http://static.javadoc.io/org.takes/takes/1.1/org/takes/facets/auth/PsChain.html)
implements [`Pass`](http://static.javadoc.io/org.takes/takes/1.1/org/takes/facets/auth/Pass.html)
and attempts to authenticate the user by asking all encapsulated passes,
one by one. The first one in the chain is
[`PsFake`](http://static.javadoc.io/org.takes/takes/1.1/org/takes/facets/auth/PsFake.html).
Using a single boolean argument in its constructor, it makes a decision whether
to return a fake identity or return nothing. With just a single boolean
trigger, we can switch off the entire authentication mechanism in the app.

Let's say you want to authenticate users through Facebook OAuth. Here is how:

```java
new TkAuth(
  take, // original application "take"
  new PsChain(
    new PsByFlag(
      new PsByFlag.Pair(
        PsFacebook.class.getSimpleName(),
        new PsFacebook(
          "... Facebook API key ...",
          "... Facebook API secret ..."
        )
      )
    ),
    new PsCookie(
      new CcHex(new CcXOR(new CcPlain()))
    )
  )
);
```

When a user clicks on the login link on your site, the browser goes to `facebook.com`,
where his or her identity is verified. Then, Facebook returns a `302` redirection
response with a `Location` header set to the URL we provide in the login link.
The link must include something like this: `?PsByFlag=PsFacebook`. This will
tell [`PsByFlag`](http://static.javadoc.io/org.takes/takes/1.1/org/takes/facets/auth/PsByFlag.html)
that this request authenticates a user.

`PsByFlag` will iterate through all encapsulated "pairs" and try to find the
right one.
[`PsFacebook`](http://static.javadoc.io/org.takes/takes/1.1/org/takes/facets/auth/social/PsFacebook.html)
will be the first and the right one. It will connect to the Facebook API using the
provided credentials and will retrieve all possible information about the user.

Here is how we can implement a logout mechanism:

```java
new TkAuth(
  take, // original application "take"
  new PsChain(
    new PsByFlag(
      new PsByFlag.Pair(
        PsFacebook.class.getSimpleName(),
        new PsFacebook(
          "... Facebook API key ...",
          "... Facebook API secret ..."
        )
      ),
      new PsByFlag.Pair(
        PsLogout.class.getSimpleName(),
        new PsLogout()
      )
    ),
    new PsCookie(
      new CcHex(new CcXOR(new CcPlain()))
    )
  )
);
```

Now, we can add `?PsByFlag=PsLogout` to any link on the site and it will
log the current user out.

You can see how all this works in a real application by checking out the
[`TkAppAuth`](https://github.com/yegor256/rultor/blob/master/src/main/java/com/rultor/web/TkAppAuth.java)
class in [Rultor](https://www.rultor.com).
