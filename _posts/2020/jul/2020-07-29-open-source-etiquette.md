---
layout: post
title: "Open Source Etiquette"
date: 2020-07-29
place: Moscow, Russia
tags: oss
description: |
  Demonstrating respect to others in the world of
  software development means a few simple but rather hard
  to follow principles.
keywords:
  - etiquette
  - github etiquette
  - github etiquette rules
  - online etiquette
  - etiquette online
image: /images/2020/07/hong-kil-dong.jpg
jb_picture:
  caption: Hong Kil-dong (1986) by Kil-in Kim
---

Here is a short list of common courtesy rules for open source
software development. Actually, they apply elsewhere also, but they are most
visible when you do GitHub-based coding. I strongly believe that
sooner or later all programming will be open source and these rules
will apply to everybody. Consequently, it makes sense to start following them now,
whether you are an active Apache contributor or a happy owner
of the "Java for Dummies" book.

<!--more-->

{% jb_picture_body %}

In no particular order (while more details are in
[this blog post]({% pst 2024/dec/2024-12-15-open-source-beginner-advice %})):

**Make Small [Pull Requests](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/about-pull-requests)**.
Some recent [research](https://www.researchgate.net/publication/325730783_Modern_code_review_a_case_study_at_google)
done by Caitlin Sadowski et al. from Google and the University of Zurich
demonstrated that there is a strong correlation between change size
and review quality: larger changes (pull requests) negatively affect quality.
According to this article, Google developers
are strongly encouraged to make small, incremental changes.
Aside from [Google](https://google.github.io/eng-practices/review/developer/small-cls.html),
many others explicitly say the same:
[Microsoft](https://microsoft.github.io/MixedRealityToolkit-Unity/Documentation/Contributing/PullRequests.html#keep-pull-requests-small),
[Zalando](https://engineering.zalando.com/posts/2017/10/a-plea-for-small-pull-requests.html),
[Atlassian](https://www.atlassian.com/blog/git/written-unwritten-guide-pull-requests),
and
[OpenSource.com](https://opensource.com/article/18/6/anatomy-perfect-pull-request).

**Don't Unite Changes**.
It may be tempting to put all changes you want to make into a single
pull request, to merge them faster, having only a single review. Don't do this.
This will only make the process more complicated and you will annoy your
reviewers. The rule is simple: one change = one pull request.

**Use [Nice](https://docs.github.com/en/github/writing-on-github/basic-writing-and-formatting-syntax)
[Markdown](https://guides.github.com/features/mastering-markdown/) in Your Docs**.
I didn't manage to find any scientific research on this, maybe because it's
obvious: the text "why is `f` `nil`?" is much easier to read than "why is f nil?"
Rich text formatting not only makes the text look nicer, but also helps
readers digest the content faster and with more pleasure. After you learn Markdown,
I'd suggest reading this blog post by Aaron Stannard from PetaBridge:
[How to Use Github Professionally](https://petabridge.com/blog/use-github-professionally/).

**Address Your Comments**.
Always, without any exceptions, start your comments (either in a pull request
or in an issue) with GitHub nickname of the person you talk to. If you don't do this,
the message will not reach the person's inbox and most likely will be lost.
People who are active in GitHub receive hundreds of emails every day from from GitHub:
they don't read them. They only read what lands into their "Notifications."

**Say Please, Thanks, and Sorry**.
[According](https://nypost.com/2014/02/15/popes-advice-to-couples-say-please-thanks-and-sorry/)
to Pope Francis, the recipe for success lies in saying three simple words.
He didn't mean open source developers, but the advice perfectly applies to
us programmers. There are tons of articles written about online etiquette, all
of them are basically the same:
ask nicely, be grateful, and be ready to admit a mistake. I would recommend
[15 rules for communicating at GitHub](https://ben.balter.com/2014/11/06/rules-of-communicating-at-github/)
by Ben Balter, a Senior Product Manager at GitHub.

**Ping Them**.
When you make some changes to the branch and want your pull request to be
reviewed again: post a message explicitly asking your reviewer to take another look.
When you submit a pull request, post a message into it addressing it to the
architect of the project: ask them to review the PR.
And [so on]({% pst 2024/apr/2024-04-01-ping-me-please %}).
Don't expect them to watch your activity. They have other things to do.
It's your responsibility to [ping them]({% pst 2024/apr/2024-04-01-ping-me-please %}).

**Make Descriptive [Commits](https://git-scm.com/docs/git-commit)**.
The style of formatting Git commit messages (I'm sure you are using Git) is usually
very specific in each project. However, there are some similarities and
common rules. I would recommend these blog posts:
[How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/) by Chris Beams,
[Some tips on commit etiquette](https://hackernoon.com/git-it-together-some-tips-on-commit-etiquette-and-best-practices-for-junior-developers-1f147b8dfd56) by Jeremy Gunter,
and
[A Note About Git Commit Messages](https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html) by Tim Pope.
Also, check these out:
[conventionalcommits.org](https://www.conventionalcommits.org/)
and
[50/72 Formatting](https://stackoverflow.com/questions/2290016/git-commit-messages-50-72-formatting).

**Have an [Avatar](https://docs.github.com/en/github/setting-up-and-managing-your-github-profile/personalizing-your-profile)**.
A [study](https://academic.oup.com/jcmc/article/11/1/153/4616661) by
Kristine L. Nowak et al. from the University of Connecticut,
demonstrates that users with avatars, especially feminine and anthropomorphic ones,
are more likely to catch attention than those who have
no profile pictures (or have default ones provided by GitHub).
Of course, it's not only the avatar that matters; your GitHub profile
must also have many other things: description, email, pinned repositories, etc.
Use this profile as an example: [@m0nica](https://github.com/m0nica).

**Stay Online**.
Offline communication is much cheaper than online tickets:
just shout out a question in the office and you get an answer immediately.
No need to write those long tickets, formulating questions in English, waiting
for the assignee to post an answer, and so on. However, offline talk
hurts the project, for [so many reasons]({% pst 2016/aug/2016-08-23-communication-maturity %}).
Every time you move from a
GitHub issue to a Slack chat to discuss the problem, you are doing a disservice
to the project and all its participants. Remember that.

**Report Nicely**.
Just like with Git commits, bug reporting rules differ from project to project,
but the basic principles remain [the same]({% pst 2018/apr/2018-04-24-right-way-to-report-bugs %}).
Just google "[how to write a bug report](https://www.google.com/search?q=how+to+write+a+bug+report)"
and listen to what those bloggers say. Your bug reports demonstrate
[who you are]({% pst 2018/jan/2018-01-23-sociotech-skills %})
even better than your code. You may practice by submitting questions
to Stack Overflow: the community there will punish you for all your mistakes,
quickly training your reporting skills.

**Make Elegant READMEs**.
I wrote about this [before]({% pst 2019/apr/2019-04-23-elegant-readme %}):
the importance of a perfectly written and formatted
`README` file in an open source project is difficult to overemphasize.
Writing good code is important, but presenting it is part of online
etiquette: high-quality documentation means respect to the users
of your products.

This seems to be it. If you do all of these, you will demonstrate
respect to other developers and they will respect you in return.
Did I [forget]({% pst 2024/dec/2024-12-15-open-source-beginner-advice %})
anything important?

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">What does it take to be an active and successful <a href="https://twitter.com/hashtag/opensource?src=hash&amp;ref_src=twsrc%5Etfw">#opensource</a> contributor?</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1373522225471557633?ref_src=twsrc%5Etfw">March 21, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
