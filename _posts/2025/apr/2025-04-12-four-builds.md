---
layout: post
title: "Four Builds: A Balance Between Quality and Joy"
date: 2025-04-12
place: Novosibirsk, Russia
tags: devops
description: |
  Instead of trying to shorten the time that our builds take, we
  order and chain them by complexity, thus gradually reducing the risk.
keywords:
  - build duration
  - slow build
  - fast build
  - how to make build fast
  - CI slow
image: /images/2025/04/trainspotting.jpg
jb_picture:
  caption: Trainspotting (1996) by Danny Boyle
---

How long should it take to know if your code is safe?
Martin Fowler once [said][Fowler]: 10 minutes.
Ten years later, five hundred developers [agreed][Hiltor].
I disagree---with all of them.
First, ten minutes is not enough for a proper build, even for a small software system.
Second, ten minutes is too much for a build that we run from the IDE after every one-line edit.
We need a finer-grained classification of builds: from bullet-fast to thorough and dead slow.

<!--more-->

{% jb_picture_body %}

How long should a build be?

As long as it needs to be, in order to run all necessary tests.
Wrong.
Imagine a build that takes an hour.
The speed of development will be close to zero.
Programmers will complain.
A lot.

How about a build that takes a few seconds?
The speed of coding will be high---but not for long.
The quality of code will be jeopardized, because a quick build means weak testing, full of mocks.

So, how long should a build be?
The right answer is: between a few seconds and a few hours.
But the builds must be different.

## Fast Build

The first build is the one we run on our laptops.
It is **fast**.
It only includes unit tests.
Every one of them takes a few milliseconds.
Even if we have many, all together they can take less than a few seconds.
We also check test coverage thresholds.

If a local build takes longer than a few seconds, it starts being an obligation instead of a help.
We don't run such a build because we enjoy the confidence it provides.
Instead, we run it because it's "the right thing to do."
Such a build is no fun, and is only an annoying routine.
A long build breaks the rhythm of energetic coding.

What about compilation?
The ten seconds include the time to compile the sources.
What if the project has hundreds of large C++ files that need a few minutes to compile?
We break such a project into smaller components—each with its own build and its own repository.
We don't tolerate large codebases and [monolith]({% pst 2018/sep/2018-09-05-monolithic-repositories %}) repositories.

## Cheap Build

Finally, after running the fast build a few dozen times, we have enough confidence to submit a pull request.
Once submitted, GitHub picks it up and starts our workflows.

We have many of them, in different YAML files.
On top of unit tests, they run integration tests and all sorts of style checks.
We understand that the likelihood of failure is high,
because unit tests—those we ran in the fast build—are only a fraction of all tests.

We wait for a few minutes and see some workflows fail.
We investigate the failure, asking unit tests a question: "Why didn't you catch this?"
When the answer is found, we patch the tests or create additional ones.
Then, we push and, again, wait a few minutes.
We see a new failure and repeat the cycle, which normally occurs a few times per branch.
Eventually, we see all GitHub workflows green.

We pay for this exercise.
First, GitHub charges per minute.
Second, the project pays us while we sit idle waiting for the answer from GitHub Actions.
That's why we want the build to take less than ten minutes—it must be **cheap**.

## Preflight Build

When all GitHub workflows are green, we hit the button, asking Rultor—or GitHub Merge Queue—to merge it.
A **preflight** build starts and takes up to an hour, at an on-demand AWS EC2 instance.
It takes so long because, on top of unit and integration tests, it runs, for example, mutation testing.
Even in a small codebase, ten minutes may not be enough.

Preflight builds may also run load, stress, performance, in-browser, and security penetration tests.
We don't expect them to break after a green cheap build.
They do, however—but not often.
If they break, we get back to the fast build, blaming the safety net for negligence.
We reproduce the failure with a new unit test and make another merge attempt, expecting preflight to pass this time.
Eventually, it does, and the code goes to the `master` branch.

## Proper Build

Once in a while, we release a new version of the product—be it a library or a microservice.
This is when quality is the priority, while the duration of the build is irrelevant.
We hit the button and wait, for as long as necessary.
Sometimes a few hours.

Unlike all previous builds, this build is **proper**.
On top of all the tests mentioned above, it runs, for example, in-cloud multi-browser tests, automated A/B tests, and all sorts of regression tests.
In the future, most definitely, we'll run LLM-based tests to detect design inconsistencies and security flaws.

Why didn't we run these tests during the preflight build?
In order to avoid merge queue overflow.
A productive programmer may submit up to five pull requests per day.
With ten active contributors on a team, we may get a few dozen merges per day.
Since a merge queue can't be parallelized, even one hour for a preflight may be too long.
A proper build definitely won't fit.

Also, the integration with the production environment is time-consuming.
We enroll database changes, apply data migrations, update AWS configs, and switch between "green" and "blue" environments.

<hr/>

In smaller projects, cheap and preflight builds may be similar.
In tiny projects, all three builds—cheap, preflight, and proper—may be identical.
However, we always keep the fast build different from the others.
The "four builds" framework may be reduced to a "two builds" one, but never to "one build fits all."


[Fowler]: http://martinfowler.com/articles/continuousIntegration.html
[Hiltor]: https://doi.org/10.1145/3106237.3106270
