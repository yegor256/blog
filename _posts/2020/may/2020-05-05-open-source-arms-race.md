---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Open Source Arms Race"
date: 2020-05-05
place: Moscow, Russia
tags: oss
description: |
  Why are large enterprises like Google, Microsoft, and IBM
  massively donating to open source projects and opening
  their own code?
keywords:
  - google open source
  - ibm open source
  - open source
  - why open source
  - profit open source
image: /images/2020/05/filth.jpg
jb_picture:
  caption: Filth (2013) by Jon S. Baird
republished:
  -
    place: "BLOG@CACM"
    title: "The Year-Round Joys and Benefits of Open Source Software"
    date: 2020-12-11
    url: https://cacm.acm.org/blogs/blog-cacm/249265-the-year-round-joys-and-benefits-of-open-source-software/fulltext
---

Some companies massively invest in open source software projects,
while others still remain skeptical and stay away from this trend.
What's in it for those philanthropists, like Google, IBM or Microsoft?
Why spend money on something that doesn't belong to them and
is shared among all of us developers? Don't they understand that
the code they write may be used by their competitors? It seems they
do understand, but can't do anything about it.

<!--more-->

{% jb_picture_body %}

As David Mytton
[noted](https://www.infoworld.com/article/3028600/whats-the-real-reason-microsoft-and-google-are-releasing-open-source.html),
individuals release open source projects out of altruism,
while companies have real, strategic reasons hidden behind
the warm and fuzzy glow of open source. We don't mean just using
open source products, which is what every business
[does](https://thenewstack.io/survey-open-source-programs-are-a-best-practice-among-large-companies/)
nowadays, but building them so that everybody can use them, for free.

First, let's see exactly how,
among [other methods](https://opensource.com/article/19/4/ways-support-sustain-open-source),
companies invest in open source:

  * **Committers**.
    Google, for example, encourages its employees to
    open their code, and even has an
    [approval procedure](https://opensource.google/docs/releasing/approval/) for it.
    It seems that others do something similar.
    Some recently published [research](https://www.infoworld.com/article/3253948/who-really-contributes-to-open-source.html)
    demonstrates that thousands (!) of employees from
    [Microsoft](https://github.com/microsoft) (4.3k visible GitHub contributors),
    [IBM](https://github.com/IBM) (2.3k),
    [Google](https://github.com/google) (1.2k),
    and
    [others](https://www.zdnet.com/article/its-an-open-source-world-78-percent-of-companies-run-open-source-software/)
    actively contribute to their GitHub-hosted repositories.
    In other words, being paid by Google these people write
    code that doesn't belong to Google.

  * **Events**.
    Aside from
    [Google Cloud Next](https://cloud.withgoogle.com/next/sf/),
    [AWS re:Invent](https://reinvent.awsevents.com/), and
    [Microsoft Ignite](https://www.microsoft.com/en-us/ignite),
    which are pure promotional events, tech giants sponsor
    community-driven conferences, like
    [DockerCon](https://web.archive.org/web/20230225224012/https://docker.events.cube365.net/docker/dockercon),
    [KubeCon](https://events.linuxfoundation.org/kubecon-cloudnativecon-europe/),
    and
    [FOSDEM](https://fosdem.org/2020/).

  * **Foundations**.
    [Apache](https://www.apache.org/foundation/thanks),
    [Linux](https://www.linuxfoundation.org/membership/members/),
    [Eclipse](https://www.eclipse.org/membership/exploreMembership.php#allmembers),
    [GNOME](https://foundation.gnome.org/),
    [OSI](https://opensource.org/sponsors),
    and [others](https://opensource.com/resources/organizations)
    are sponsored by Google, IBM, Huawei, Microsoft, and Oracle.

  * **Acquisitions**.
    They [acquire](https://techcrunch.com/2019/01/12/how-open-source-software-took-over-the-world/)
    startups that make open source products,
    e.g.
    [RedHat](https://github.com/RedHatOfficial)
      (acquired by IBM for [$32b](https://www.technologyreview.com/the-download/612353/ibms-34-billion-purchase-of-red-hat-is-a-mega-bet-on-a-coding-revolution/?via=indexdotco)),
    [MongoDB](https://github.com/mongodb/mongo)
      ([$4b](https://www.marketwatch.com/story/mongodb-shares-rally-above-already-elevated-ipo-price-2017-10-19)),
    [Docker](https://github.com/docker)
      ([$1b](https://venturebeat.com/2015/06/13/docker-now-valued-at-1b-paid-someone-799-for-its-logo-on-99designs/)),
    [Elastic](https://github.com/elastic)
      ([$6b](https://techcrunch.com/2018/10/05/search-company-elastic-pops-90-on-nyse-after-raising-252m-at-a-2-5b-market-cap-in-its-ipo/)),
    [Ansible](https://github.com/ansible/ansible)
      ([$100m](http://venturebeat.com/2015/10/15/source-red-hat-is-buying-ansible-for-more-than-100m/)),
    [MySQL](https://github.com/mysql)
      ([$1b](https://techcrunch.com/2008/01/16/sun-picks-up-mysql-for-1-billion-open-source-is-a-legitimate-business-model/)),
    [Nginx](https://github.com/nginx/nginx)
      ([$670m](https://techcrunch.com/2019/03/11/f5-acquires-nginx-for-670m-to-move-into-open-source-multi-cloud-services/)),
    and [so on](https://web.archive.org/web/20220809073446/https://index.co/market/open-source/acquisitions).
    The market is [booming](https://a16z.com/open-source-from-community-to-commercialization/), by the way.

  * **Donations**.
    Google, for example, [donates](https://opensource.google/docs/growing/funding/) to
      [Fastlane](https://github.com/fastlane/fastlane)
      and
      [Kubernetes](https://github.com/kubernetes/kubernetes);
    IBM [donates](https://www.ibm.com/opensource/) to
      [Node.js](https://www.ibm.com/blogs/bluemix/2015/06/node-js-foundation-launched/)
      and
      [TensorFlow](https://conferences.oreilly.com/tensorflow/tf-ca-2019/public/schedule/detail/81284);
    Amazon sponsors
      [Rust](https://aws.amazon.com/blogs/opensource/aws-sponsorship-of-the-rust-project/);
    and [so on](https://github.com/ossfriendly/open-source-supporters).

Next, the question is how this helps Google and others make their
business more profitable. For example, how is Google Cloud Platform planning
to beat Amazon AWS using open source as a weapon? Here is how,
among [other reasons](https://simplabs.com/blog/2019/11/11/why-companies-invest-in-oss/):

  * **Selling**.
    The products they sponsor gather large communities of users,
    who know how to work with them. Some of those users are decision-making
    people. For example, [Google's Container Engine](https://cloud.google.com/kubernetes-engine/)
    is a hosted version of
    [Kubernetes](https://github.com/kubernetes/kubernetes), an open source product.
    Kubernetes users, when they need
    a hosted version of it, will most likely become Google customers.
    [TensorFlow](https://github.com/tensorflow/tensorflow),
    yet another example, also runs on [Google Cloud Platform](https://cloud.google.com/tensorflow-enterprise).

  * **Influencing**.
    In the modern software development world open source is the key media, where
    programmers learn new ideas, design principles, and architectural solutions.
    They listen to open source projects, because they trust them much more
    than they trust Google, IBM or Microsoft. Tech companies are smart, but their
    decisions are based on monetary reasons, while open source projects
    are much freer to do what is right, instead of what is profitable.
    And programmers usually get very skeptical when open projects are acquired
    by large enterprises, like
    [Java by Oracle](https://www.reddit.com/r/linux/comments/2e2c1o/what_do_we_hate_oracle_for/)
    or [GitHub by Microsoft](https://www.theverge.com/2018/6/18/17474284/microsoft-github-acquisition-developer-reaction)
    (not really an open source story, but very close).
    Thus, for companies it's much wiser to sponsor open source and stay behind the curtain
    rather than talking directly to developers through corporate media
    like [MSDN](https://docs.microsoft.com/en-us/) or [OPN](https://developer.oracle.com/).

  * **Branding**.
    Being part of open source is a direct contribution to the public
    image of a company. Google is no longer an
    [Ad-selling monopoly](https://www.theverge.com/2019/9/9/20857440/google-antitrust-investigation-attorneys-general-advertising-search),
    with [questionable reputation](https://www.androidauthority.com/googles-reputation-is-becoming-its-biggest-problem-1055381/),
    but one of the largest software [philanthropists](https://ssir.org/articles/entry/open_source_software_is_philanthropy).
    Microsoft is [catching up](https://web.archive.org/web/20200406095011/https://www.businessinsider.in/tech/enterprise/news/microsofts-reputation-is-soaring-as-trust-in-the-tech-industry-flounders-according-to-new-research/articleshow/72129884.cms)
    with its massive [code opening](https://www.techrepublic.com/article/whats-really-behind-microsofts-love-of-open-source/)
    and the [purchase](https://blogs.microsoft.com/blog/2018/10/26/microsoft-completes-github-acquisition/) of GitHub.

{% youtube D12gi1x6Cdw %}

  * **Retaining**.
    Being an active participant of a visible open source software product
    is a great [intrinsic motivator](https://opensource.com/article/19/11/why-contribute-open-source-software)
    for the best software engineers.
    When your company is involved in open source business, you
    are much more loyal and interested in staying longer with the company.
    I can't prove this assertion, but it's my personal observation.

  * **Training**.
    It's [no secret](https://web.archive.org/web/20140801084717/http://www.wired.com/2013/11/open-source-a-platform-for-innovation)
    that the [best technologies](https://www.techrepublic.com/article/the-best-open-source-innovations-of-the-last-decade/)
    nowadays are being created
    in open source projects by people contributing for free
    (they get their salaries somewhere else). It's also a
    [well-known fact](https://hackernoon.com/how-to-become-the-best-programmer-in-the-world-ef9f584c81fa)
    that in order to be a better engineer one has to work with the best.
    Open source projects are [exactly](https://www.techrepublic.com/article/10-tips-for-becoming-a-better-programmer/)
    the best place to meet more experienced and very often more talented programmers,
    and learn from them. Companies, by sending people there, boost
    their skills without doing any internal training programs.

Thus, it seems that open source is a very powerful instrument
in the war for tech markets and for talent. Smart companies develop their open source
muscles, earning reputation and acquiring our trust. I predict
this trend not only to continue but also to escalate. We programmers
are their driving force; they need us
as users, promoters, influencers, and makers of the products.

They were [not paying attention](https://hbswk.hbs.edu/item/microsoft-vs-open-source-who-will-win)
to the open source territory for ages
and [now](https://www.computerworld.com/article/3144063/open-source-has-won-and-microsoft-has-surrendered.html)
they are fighting for it, trying to acquire the largest pieces.

We software developers are the territory!

Thus, if you are a coder, make your own project now.
Sooner or later Google will knock on the door and offer
you a big check, just to do it earlier than Microsoft.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Why don&#39;t you have your own super popular <a href="https://twitter.com/hashtag/opensource?src=hash&amp;ref_src=twsrc%5Etfw">#opensource</a> product yet?</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1338048990907076609?ref_src=twsrc%5Etfw">December 13, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
