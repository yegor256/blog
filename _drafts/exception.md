---
layout: post
title: "What Do You Do With InterruptedException?"
date: 2015-10-17
place: Palo Alto, CA
tags: java
description:
  Checke InterruptedException in Java is a constant
  source of pain for many of us, here is my understanding
  of how it should be handled.
keywords:
  - InterruptedException
  - InterruptedException java
  - InterruptedException example
  - InterruptedException checked or unchecked
  - InterruptedException sleep
---

[`InterruptedException`](http://docs.oracle.com/javase/7/docs/api/java/lang/InterruptedException.html)
is a permanent source of pain in Java, for
junior developers especially. But it should not be. It's a rather
simple and easy to understand idea. Let me try to describe and
simplify it.

<!--more-->

Let's start with this code:

{% highlight java %}
while (true) {
  // nothing
}
{% endhighlight %}

What does it do? Nothing, just spins the CPU endlessly. Can we terminate it?
Not in Java. It will stop only when the entire JVM stops, when you hit
`Ctrl-C`. There is no way in Java to terminate a thread, unless the
thread exits by itself. That's the principle we have to have in mind
and everything else will be just obvious.

Let's put this endless loop into a thread:

{% highlight java %}
Thread loop = new Thread(
  new Runnable() {
    @Override
    public void run() {
      while (true) {
      }
    }
  }
);
loop.start();
// how to stop it now?
{% endhighlight %}

So, how do we stop a thread, when we need it to stop?

Here is how it is designed in Java.
There is a flag in every thread, that we can set from the outside. And
the thread may check it occasionally and stop its execution. Voluntarily!
Here is how:

{% highlight java %}
Thread loop = new Thread(
  new Runnable() {
    @Override
    public void run() {
      while (true) {
        if (Thread.interrupted()) {
          break;
        }
        // continue to do nothing
      }
    }
  }
);
loop.start();
loop.interrupt();
{% endhighlight %}

This is the only way to ask a thread to stop. There are two methods, which
we're using in this example. When I'm calling `loop.interrupt()`, a flag
is set to `true` somewhere inside the thread `loop`. When I'm calling
[`interrupted()`](http://docs.oracle.com/javase/7/docs/api/java/lang/Thread.html#interrupted%28%29),
the flag is returned and immediately set to `false`. Yeah, that's the design
of the method. It checks the flag, returns it and sets it to `false`. It's ugly,
I know.

Thus, if I never call `Thread.interrupted()` inside the thread and don't
exit when the flag is `true`, nobody will be able to stop me. Literally,
I will just ignore their calls to `interrupt()`. They will ask me to stop,
but I will ignore. They won't be able to interrupt me.

Thus, to summarize what we've learned so far, a properly designed thread
will check that flag once in a while and stop gracefully. If the
code doesn't check the flag and never calls `Thread.interrupted()`, it
accepts the fact that sooner or later it will be terminated in a cold way,
by clicking `Ctrl-C`.

Sounds logical so far? Hope so.

Now, there are some methods in JDK that check the flag for us and throw
[`InterruptedException`](http://docs.oracle.com/javase/7/docs/api/java/lang/InterruptedException.html)
if it is set. For example, this is how method
[`Thread.sleep()`](http://docs.oracle.com/javase/7/docs/api/java/lang/Thread.html#sleep%28long%29)
is designed (in a very primitive approach):

{% highlight java %}
public static void sleep(long millis)
  throws InterruptedException {
  while (/* still need to wait */) {
    if (Thread.interrupted()) {
      throw new InterruptedException();
    }
    // keep waiting
  }
}
{% endhighlight %}

Why it's done this way? Why can't it just wait and never check the flag?
Well, I believe it's done for a good reason. And the reason is the following
(correct me if I'm wrong): the code should either be bullet-fast or
interruption-ready, nothing in between.

If your code is fast, you never check the interruption flag, because you
don't want to deal with any interruptions.
If your code is slow and may take seconds to execute, make it explicit
and handle interruptions somehow.

That's why `InterruptedException` is a checked exception. Its design
tell you that if you want to make a pause for a few milliseconds, make your
code interruption-ready. This is how it looks in practice:

{% highlight java %}
try {
  Thread.sleep(100);
} catch (InterruptedException ex) {
  // stop immediately and go home
}
{% endhighlight %}

Well, you can let it float up, to a higher level and they will be
responsible for catching it. The point is that someone will have to
catch it and do something with the thread. Ideally, stop it, since that's
what the flag is about. If `InterruptedException` is thrown, it means
that someone checked the flag and our thread has to finish what it's doing, ASAP.

The owner of the thread doesn't want to wait any longer. And we must
respect the decision of our owner.

Thus, when you catch `InterruptedException`, you have to do whatever
it takes to wrap up what you're doing and exit.

Now, look again at this code of `Thread.sleep()`:

{% highlight java %}
public static void sleep(long millis)
  throws InterruptedException {
  while (/* ... */) {
    if (Thread.interrupted()) {
      throw new InterruptedException();
    }
  }
}
{% endhighlight %}

Remember, `Thread.interrupted()` not only returns the flag, but also
sets it to `false`. Thus, once `InterruptedException` is thrown, the
flag is reset. The thread doesn't know anything any longer about the
interruption request sent by the owner.

The owner of the thread asked us to stop,
`Thread.sleep()` detected that request,
removed it and thrown `InterruptedException`. If you call `Thread.sleep()`,
again it will not know anything about that interruption request and will
not throw anything.

See where I'm getting at? It's very important not to lose that
`InterruptedException`. We can't just swallow it and move on. That would
be a severe violation of the entire Java multi-threading idea.
Our owner (the owner of our thread) is
asking us to stop and we ignore it. That's a very bad idea.

This is what most of us are doing with `InterruptedException`:

{% highlight java %}
try {
  Thread.sleep(100);
} catch (InterruptedException ex) {
  throw new RuntimeException(ex);
}
{% endhighlight %}

It looks logical, but it doesn't guarantee that the higher level will
actually stop everything and exit. They may just catch a runtime exception
there and the thread will stay alive. The owner of the thread will be disappointed.

We have to inform the higher level that we just caught an interruption
request. We can't just throw a runtime exception. Such a behavior will
be too irresponsible. The entire thread received an interruption request
and we're swallowing it and converting into just a `RuntimeException`.
We can't treat such a serious situation so freely.

This is what we have to do:

{% highlight java %}
try {
  Thread.sleep(100);
} catch (InterruptedException ex) {
  Thread.currentThread().interrupt(); // here!
  throw new RuntimeException(ex);
}
{% endhighlight %}

We're setting the flag back to `true`!

Now, nobody will blame us for irresponsible attitude to a valuable flag. We
found it in `true` status, cleared it, set back to `true` and threw
a runtime exception. What will happen next, we don't care.

I think that's it. A more detailed and official description
of this problem you can find here:
[Java theory and practice: Dealing with InterruptedException](http://www.ibm.com/developerworks/library/j-jtp05236/)
