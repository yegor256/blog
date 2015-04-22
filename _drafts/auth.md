---
layout: post
title: "How Cookie Based Authentication works in Takes Framework"
date: 2015-02-10
tags: java
description:
  Cookie based authentication is a simple and powerful mechanism
  to enable web site user login in a RESTful and lightweight way;
  Takes framework does it with a few composable decorators
keywords:
  - cookie based authentication
  - cookies for authentication
  - cookie authentication best practices
  - cookie authentication web api
  - cookie authentication security
---

When you enter your email and password into Facebook login page,
you get into your account. Then, wherever you go in the site,
you always see your photo at the top right corner of the page. Facebook
remembers you and doesn't ask for the password again and again. This works
thanks to [HTTP Cookies](https://en.wikipedia.org/wiki/HTTP_cookie)
and is called **cookie based authentication**. Even through this mechanism
often causes some security concerns, it is very popular and simple.
Here is how [Takes](http://www.takes.org) makes it possible in a few lines of code.

<!--more-->

First, let's see how it works. Moreover, let's see how I believe it should work.

Step one, the user enters email and password and clicks "submit". The server
receives POST request with this information inside:

{% highlight text %}
POST / HTTP/1.1
Host: www.facebook.com
Content-Type: application/x-www-form-urlencoded

email=me@yegor256.com&password=itisasecret
{% endhighlight %}

The server matches provided information with its records and decides what to do.
If the information is invalid, it returns the same login page, asking to
enter all this again. When information is valid, the server returns something
like this:

{% highlight text %}
HTTP/1.1 303 See Other
Location: www.facebook.com
Set-Cookie: user=me@yegor256.com
{% endhighlight %}

Since the response status code is 303, the browser goes to the page,
specified in `Location` header and opens the front page of the site. This
is what it sends to the server:

{% highlight text %}
GET / HTTP/1.1
Host: www.facebook.com
Cookie: user=me@yegor256.com
{% endhighlight %}

The server gets my email from `Cookie`
header and understands that it's me again! No need to ask me for the
password again. The server trusts the informatiom from the cookie.
That's it. That's what cookie based authentication is all about.

## Wait... what about security?

Right, what about security. If the server trusts any browser request with
user email in `Cookie` header, anyone would be able to send my email
from another place and get access to my account.

The first step to prevent this is to encrypt the email, with a secret
encryption key, known only to the server. Nobody, except the server itself,
will be able to encrypt it the way the server would be able to decrypt.
The response will look like this, for example being encrypted
by [XOR cipher](https://en.wikipedia.org/wiki/XOR_cipher) with `bamboo` as a secret key:

{% highlight text %}
HTTP/1.1 303 See Other
Location: www.facebook.com
Set-Cookie: user=b1ccafd92c568515100f5c4d104671003cfa39
{% endhighlight %}

This is not best encryption mechanism, for a proper encryption it's better
to use something stronger, like [DES](https://en.wikipedia.org/wiki/Data_Encryption_Standard).

Sounds good, but what if someone hijacks the traffic between the server and the
browser and gets ahold of a properly encrypted email cookie? In this case,
this person will able to use the same cookie for authentication, even without
knowing its content. The server will trust this information and will let the
person to enter my account. This type of attack is called
[man-in-the-middle](http://en.wikipedia.org/wiki/Man-in-the-middle_attack) (MITM).
To prevent this from happening we should use HTTPS and inform the browser
that the cookie is sensitive and should never be returned to the server without
SSL encryption. It's done by an extra flag at `Set-Cookie` header:

{% highlight text %}
HTTP/1.1 303 See Other
Location: www.facebook.com
Set-Cookie: user=me@yegor256.com; Secure
{% endhighlight %}

There is yet another type of attack associated with cookie based authentication,
based on browser ability to expose all cookies associated with a web page
to JavaScript executed inside it. An attacker may inject some malicious
JavaScript code into the page (don't ask me how... this will happen only
if your entire HTML rendering is done wrong), and this code will get access
to the cookie. Then, this code will send the cookie somewhere else, where
the attacker can collect it. This type of attack is called
[cross-site scripting](http://en.wikipedia.org/wiki/Cross-site_scripting) (XSS).
To prevent this, there is another flag for `Set-Cookie` header, called `HttpOnly`:

{% highlight text %}
HTTP/1.1 303 See Other
Location: www.facebook.com
Set-Cookie: user=me@yegor256.com; Secure; HttpOnly
{% endhighlight %}

Presence of this flag will tell the browser that this particular cookie can
be transferred back to the server only through HTTP requests. JavaScript won't
have access to it.

## How it's done in Takes

Here is how this cookie based authentication mechanism is designed in
[Takes](http://www.takes.org) framework. The entire framework consists of
_takes_, which receive requests and produce responses
([this article]({% pst 2015/mar/2015-03-22-takes-java-web-framework %})
explains the framework in more details). When the request comes in,
we should find the authentication cookie in `Cookie` header and translate
it to the user identity. When the response goes out, we should add
`Set-Cookie` header to it with the encrypted user identity. That's it. Just
these two steps.

Let's say we have an account page that is supposed to show current user
balance:

{% highlight java %}
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
{% endhighlight %}

Right after the `request` comes in, we should retrieve the identity of
the user, encoded inside an authenticating cookie. To make this mechanism
reusable, we have `TkAuth` decorator, which wraps an existing _take_,
decodes an incoming cookie and adds a new header to the request, with
user identity information:

{% highlight java %}
final Codec codec = new CcHex(new CcXOR(new CcPlain()));
final Pass pass = new PsCookie(codec);
new TkAuth(new TkAccount(), pass);
{% endhighlight %}

Again, when `TkAuth` receives a request with an authenticating cookie inside,
it asks `pass` to decode the cookie and return either a
valid `Identity` or `Identity.ANONYMOUS`.

Then, when the response goes back to the browser, `TkAuth` asks `pass`
to encode the indentity back into a string and adds `Set-Cookie` to the response.

`PsCookie` is using an instance of `Codec` in order to do these backward
and forward encoding operations.

When our `TkAccount` _take_ wants to retrieve currently authenticated
user identity from the request, it can use `RqAuth`,
a utility decorator of `Request`:

{% highlight java %}
final class TkAccount implements Take {
  @Override
  public Response act(final Request request) {
    final Identity user = new RqAuth(request).identity();
    // other manipulations with the user
  }
}
{% endhighlight %}

`RqAuth` decorator is using the header, added by `PsCookie`, in order
to authenticate the user and create `Identity` object.
