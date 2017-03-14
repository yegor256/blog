---
layout: static
title: "Talks"
description: |
  Here is a full list of my talks, at conferences,
  meetups, expos, workshops, etc. There are both
  upcoming and already happened.
permalink: talks.html
keywords:
  - talks about software development
  - software development presentations
  - workshops about software development
  - conferences about programming
  - software engineers conferences
image: https://cf.jare.io/?u=http://www.yegor256.com/images/yegor-is-presenting.png
style: |
  .talk-event {
    clear: both;
  }
  .future-talk {
    display: block;
    height: 50px;
    margin-top: 2em;
    max-width: 100%;
  }
  .past-talk {
    display: block;
    float: left;
    height: 90px;
    margin-right: 1em;
    margin-bottom: 1em;
    max-width: 160px;
    filter: grayscale(100%);
  }
  .venue-rate {
    float: right;
    font-size: 2em;
    font-family: 'Source Code Pro', monospace;
    font-weight: bold;
    margin: .5em;
    border-radius: 50%;
    border: 1px solid gray;
    text-align: center;
    vertical-align: middle;
    line-height: 1.6em;
    width: 1.6em;
    height: 1.6em;
  }
  @media all and (max-width: 700px) {
    .venue-rate {
      float: none;
      margin-left: 0;
    }
    .past-talk {
      float: none;
      margin-left: 0;
      max-width: 100%;
    }
  }
script: |
  $(function() {
    $('#future-talks-total').text($('img.future-talk').length);
    $('#past-talks-total').text($('img.past-talk').length);
  });
---

{% badge /images/yegor-is-presenting.png 300 %}

This is where I'll be talking soon.
I'm updating this list very often, but still,
follow me [on Twitter](https://www.twitter.com/yegor256) and [on Lanyrd](http://lanyrd.com/profile/yegor256/)
for the most recent news.
Below is a list of all venues I've been talking at with my short
summary of their quality. Well, not just a summary, but an evaluation.
Not every conference is as good as some others. That's why I decided to
give them some feedback, at least here (see below).

## <span id='future-talks-total'>&#20;</span> Upcoming Events

<div class="talk-event"/>
<img src="/images/2017/agiledays.svg" class="future-talk" alt="AgileDays 2017"/>
**Семь врагов нашей мотивации**<br/>
[AgileDays 2017](http://agiledays.ru/members/profile/89/)<br/>
Moscow, Russia<br/>
23-24 March 2017

<div class="talk-event"/>
<img src="/images/2017/devon-summit.png" class="future-talk" alt="DevOn Summit 2017"/>
**Why Distributed Teams Suck?** (keynote)<br/>
[DevOn Summit 2017](http://www.devonsummit.com/speakers/)<br/>
Delft, The Netherlands<br/>
30 March 2017

<div class="talk-event"/>
<img src="/images/2017/jbreak.png" class="future-talk" alt="JBreak 2017"/>
**Utility Classes Are Killing Us**<br/>
[JBreak 2017](https://2017.jbreak.ru/speakers/yegor-bugayenko/)<br/>
Novosibirsk, Russia<br/>
4 April 2017

<div class="talk-event"/>
<img src="/images/2017/jpoint.png" class="future-talk" alt="JPoint 2017"/>
**Java Annotations Are a Big Mistake**<br/>
[JPoint 2017](https://jpoint.ru/en/talks/java-annotations-are-a-big-mistake/)<br/>
Moscow, Russia<br/>
7 April 2017

<div class="talk-event"/>
<img src="/images/2017/rigadevdays.png" class="future-talk" alt="RigaDevDays 2017"/>
**How Bright is Your Future?** (keynote)<br/>
**What's Wrong with Object-Oriented Programming?**<br/>
[RigaDevDays 2017](http://rigadevdays.lv/speakers/46/)<br/>
Riga, Latvia<br/>
15 May 2017

<div class="talk-event"/>
<img src="/images/2016/geecon-2016.png" class="future-talk" alt="GeeCON 2017"/>
**What this InterruptedException is about?**<br/>
[GeeCON 2017](https://geecon.org/)<br/>
Kraków, Poland<br/>
17-19 May 2017

<div class="talk-event"/>
<img src="/images/2016/jeeconf-logo.png" class="future-talk" alt="JEEConf 2017"/>
**Object-oriented flavor for JUnit tests**<br/>
**How much do you cost?**<br/>
[JEEConf 2017](http://jeeconf.com/speaker/yegor-bugayenko-2/)<br/>
Kiev, Ukraine<br/>
26-27 May 2017

<div class="talk-event"/>
<img src="/images/2017/item-2017.png" class="future-talk" alt="ITEM 2017"/>
[ITEM 2017](http://item.com.ua/)<br/>
Dnipro, Ukraine<br/>
17-18 June 2017

<div class="talk-event"/>
<img src="/images/2017/javaday-2017.png" class="future-talk" alt="JavaDay 2017"/>
[JavaDay 2017](http://javaday.org.ua/)<br/>
Kiev, Ukraine<br/>
4-5 November 2017

<div class="talk-event"/>
<img src="/images/2017/devternity.png" class="future-talk" alt="DevTernity 2017"/>
[DevTernity 2017](https://devternity.com/)<br/>
Riga, Latvia<br/>
1 December 2017

## <span id='past-talks-total'>&#20;</span> Past Events

This is a very opinionated and subjective list of conferences,
which I attended recently, as a speaker. They rate us speakers,
why shouldn't we rate them, right? The best rate is
<span class="green">**A+**</span>, while the worst is
<span class="red">**F-**</span>.

### 2017

<div class="talk-event"/>
<img src="https://i.ytimg.com/vi/lvoQZGsY56k/mqdefault.jpg" class="past-talk" alt="Kharkiv PMDay 2017"/>
Management Without Managers;
[Kharkiv PMDay](http://kh.pmday.org/yehor-buhayenko2017s/);
Kharkiv, Ukraine;
4 March 2017;
[slides](https://www.slideshare.net/YegorBugayenko/management-without-managers),
[видео](https://www.youtube.com/watch?v=lvoQZGsY56k).

<div class="talk-event"/>
<img src="https://i.ytimg.com/vi/qqWC3_cQHAc/mqdefault.jpg" class="past-talk" alt="JUG.ua 2017"/>
OOP Java Puzzlers;
[JUG.ua](https://events.epam.com/events/kyiv-jug-feb28)<br/>
Kiev, Ukraine;
28 February 2017;
[видео](https://www.youtube.com/watch?v=qqWC3_cQHAc).

<div class="talk-event"/>
<img src="https://i.ytimg.com/vi/LPLqLaSwSsI/mqdefault.jpg" class="past-talk" alt="JUG Dnipro 2017"/>
Decorators, Decorators, Decorators;
[JUG Dnipro](http://dataart.ua/events/dp/java-user-group-dnipro-dekoratory-dekoratory-dekoratory/);
Dnipro, Ukraine;
11 February 2017;
[видео](https://www.youtube.com/watch?v=LPLqLaSwSsI).

### 2016

<div class="talk-event"/>
<img src="https://i.ytimg.com/vi/GQLFc-ttCX0/mqdefault.jpg" class="past-talk" alt="Morning@Lohika"/>
Object-Oriented Java by Example;
[Morning@Lohika 2016](https://dou.ua/calendar/13589/);
Lviv, Ukraine;
24 December 2016;
[видео](https://www.youtube.com/watch?v=GQLFc-ttCX0).

<div class="talk-event"/>
<img src="https://i.ytimg.com/vi/qAxLtSYN0nw/mqdefault.jpg" class="past-talk" alt="UADevClub"/>
Make Your Java Object-Oriented, 64 Practical Steps;
[UADevClub](http://xpinjection.com/articles/oop-meetup-with-yegor-bugaenko-december-20th/);
Kiev, Ukraine;
20 December 2016;
[видео](https://www.youtube.com/watch?v=qAxLtSYN0nw).

<div class="talk-event"/>
<aside class="venue-rate green">B</aside>
<img src="https://i.ytimg.com/vi/7EytYc7K5JA/mqdefault.jpg" class="past-talk" alt="DevTernity 2016"/>
XDSD: Meetings-Free Software Development Methodology;
[DevTernity 2016](http://devternity.com/#/11);
Riga, Latvia;
1 December 2016;
[video](https://www.youtube.com/watch?v=7EytYc7K5JA).
The size of the event was perfectly right, the audience was motivated,
organizers were actively involved, I did like it. What I didn't like
was food and lack "social glue" between presenters, attendees, and
everybody involved. I'm sure next year they will do it better.

<div class="talk-event"/>
<aside class="venue-rate orange">C+</aside>
<img src="https://i.ytimg.com/vi/R1lA7pN60xg/mqdefault.jpg" class="past-talk" alt="BuildStuff Ukraine 2016"/>
Who is a Software Architect?;
BuildStuff Ukraine 2016;
Kiev, Ukraine;
21-22 November 2016;
[slides](http://www.slideshare.net/YegorBugayenko/who-is-a-software-architect),
[video](https://www.youtube.com/watch?v=R1lA7pN60xg).
It was probably too big to be managed right. The Lithuanian part was a bit
better, while Ukrainian was not so great at all, maybe because I don't like
that Olympiski sport center. Also, in Vilnius there were maybe 15 people
at my presentation&mdash;this was just sad. What I did like was food.

<div class="talk-event"/>
<img src="https://i.ytimg.com/vi/wd-SA1HVmLg/mqdefault.jpg" class="past-talk" alt="BuildStuff 2016"/>
How Do You Know When Your Product is Ready to be Shipped?;
[BuildStuff 2016](http://www.buildstuff.lt/);
Vilnius, Lithuania;
18 November 2016;
[slides](http://www.slideshare.net/YegorBugayenko/how-do-you-know-when-your-product-is-ready-to-be-shipped),
[video](https://www.youtube.com/watch?v=wd-SA1HVmLg).

<div class="talk-event"/>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/hkXLOxZ6Fs4/mqdefault.jpg" class="past-talk" alt="TopConf Tallinn 2016"/>
Seven Sins of a Software Project;
[TopConf 2016](http://topconf.com/tallinn-2016/speaker/yegor-bugayenko/);
Tallinn, Estonia;
17 November 2016;
[slides](http://www.slideshare.net/YegorBugayenko/seven-sins-of-a-software-project),
[video](https://www.youtube.com/watch?v=hkXLOxZ6Fs4).
The event was rather small (about 300 people), but well prepared. At my presentation
the room was full.

<div class="talk-event"/>
<img src="https://i.ytimg.com/vi/mq4bsnKK0qs/mqdefault.jpg" class="past-talk" alt="TopConf Tallinn 2016"/>
Keep Your Servers In GitHub;
[TopConf 2016](http://topconf.com/tallinn-2016/speaker/yegor-bugayenko/);
Tallinn, Estonia;
16 November 2016;
[slides](http://www.slideshare.net/YegorBugayenko/keep-your-servers-in-github),
[video](https://www.youtube.com/watch?v=mq4bsnKK0qs).

<div class="talk-event"/>
<aside class="venue-rate orange">C</aside>
<img src="https://i.ytimg.com/vi/_61CuGhyv-o/mqdefault.jpg" class="past-talk" alt="DevOpsPro Moscow 2016"/>
Practical Example of a One-Click Release;
[DevOpsPro Moscow 2016](http://www.devopspro.ru/yegor-bugayenko/);
Moscow, Russia;
15 November 2016;
[video](https://www.youtube.com/watch?v=_61CuGhyv-o).
The event was rather small and chaotic. I tried my best to make my speech
interesting, but the audience wasn't really ready.

<div class="talk-event"/>
<img src="https://i.ytimg.com/vi/ADd00BotEbI/mqdefault.jpg" class="past-talk" alt="msk.jug.ru"/>
Вредная архитектура MVC;
[msk.jug.ru](https://jugmsk.timepad.ru/event/400420/);
Moscow, Russia;
14 November 2016;
[video 1](https://www.youtube.com/watch?v=ADd00BotEbI),
[video 2](https://www.youtube.com/watch?v=utGIIqRGbQc),
[video 3](https://www.youtube.com/watch?v=03l8o2uu5K4).

<div class="talk-event"/>
<aside class="venue-rate orange">B+</aside>
<img src="https://i.ytimg.com/vi/tCr9dtGdi2c/mqdefault.jpg" class="past-talk" alt="XP Days Ukraine 2016"/>
XDSD: How Extreme Is Your Team?;
[XP Days Ukraine](http://xpdays.com.ua/);
Kiev, Ukraine;
12 November 2016;
[video](https://www.youtube.com/watch?v=tCr9dtGdi2c),
[photos](https://www.facebook.com/yegor256/posts/10211115240946846).
This event was organized by same people who did JEEConf. This time it was
smaller, at a different place and with less attention to details, if you ask me.
However, overall impression was very good, organizers definitely know what
they are doing. Will try to attend it again next year.

<div class="talk-event"/>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/03PXmPc7Q3g/mqdefault.jpg" class="past-talk" alt="Øredev 2016"/>
ORM is an Offensive Anti-Pattern;
[Øredev 2016](http://www.oredev.org/2016/speakers/yegor-bugayenko);
Malmö, Sweden;
9-10 November 2016;
[slides](http://www.slideshare.net/YegorBugayenko/orm-is-an-offensive-antipattern),
[video](https://www.youtube.com/watch?v=03PXmPc7Q3g),
[photos](https://www.facebook.com/yegor256/posts/10211092077247768).
The event was <del>pretty</del> too big. I would say about 800 attendees, about 60 speakers, 6 tracks, three
full days plus workshops. For that size of a conference organizers would need
to do way more "social" work for speakers and everybody. I didn't make almost
any connections there and most people I've met had the same problem. It's a typical
issue in big conferences&mdash;you simply get lost. At this one they had all
chances to make a great event, but... Aside from that, the venue was great,
food was good, travel and accomodation was perfect. I will definitely try
to attend next year.

<div class="talk-event"/>
<img src="https://i.ytimg.com/vi/EDKbYVEInMU/mqdefault.jpg" class="past-talk" alt="Øredev 2016"/>
Built-in Fake Objects;
[Øredev 2016](http://www.oredev.org/2016/speakers/yegor-bugayenko);
Malmö, Sweden;
9-10 November 2016;
[slides](http://www.slideshare.net/YegorBugayenko/builtin-fake-objects),
[video](https://www.youtube.com/watch?v=EDKbYVEInMU).

<div class="talk-event"/>
<aside class="venue-rate green">B</aside>
<img src="https://i.ytimg.com/vi/4SRoLYxvIQ8/mqdefault.jpg" class="past-talk" alt="JavaDay Kyiv 2016"/>
Practical Example of AOP with Aspect (in Russian);
[JavaDay Kyiv 2016](http://javaday.org.ua/kyiv/);
Kyiv, Ukraine;
14 October 2016;
[slides](http://www.slideshare.net/YegorBugayenko/practical-example-of-aop-with-aspectj),
[video](https://www.youtube.com/watch?v=4SRoLYxvIQ8),
[photos](https://www.facebook.com/yegor256/posts/10210826984460614).
The venue was great, the size average (about 500 ppl), organizers were
very friendly and motivated. I liked the event. A few things definitely
need to be improved: food and the amount of tracks. There too many tracks,
I guess, for the amount of people attended. Would be better to lower the
amount of speakers and focus the audience on best of them. And spend
the available money on better food.

<div class="talk-event"/>
<img src="https://i.ytimg.com/vi/cGcCcxx4xrg/mqdefault.jpg" class="past-talk" alt="JavaDay Kyiv 2016"/>
Java vs OOP;
[JavaDay Kyiv 2016](http://javaday.org.ua/kyiv/);
Kyiv, Ukraine;
15 October 2016;
[video](https://www.youtube.com/watch?v=cGcCcxx4xrg).

<div class="talk-event"/>
<img src="https://i.ytimg.com/vi/Y-16C5yhKLo/mqdefault.jpg" class="past-talk" alt="JavaDay Kyiv 2016"/>
Trial by Combat for OOP Honor (in Russian);
[JavaDay Kyiv 2016](http://javaday.org.ua/kyiv/);
Kyiv, Ukraine;
15 October 2016;
[video](https://www.youtube.com/watch?v=Y-16C5yhKLo).

<div class="talk-event"/>
<img src="https://i.ytimg.com/vi/A-9FjaOIsw8/mqdefault.jpg" class="past-talk" alt="Object Thinking Meetup #2"/>
Why Static Methods Are Evil?;
[Object Thinking Meetup](https://www.meetup.com/Object-Thinking/events/232602670/);
Stanford, Palo Alto, CA;
9 August 2016;
[video](https://www.youtube.com/watch?v=A-9FjaOIsw8).

<div class="talk-event"/>
<img src="https://i.ytimg.com/vi/pynZF10U880/mqdefault.jpg" class="past-talk" alt="Object Thinking Meetup #1"/>
How Anemic Objects Kill OOP;
[Object Thinking](http://www.meetup.com/Object-Thinking-in-Silicon-Valley/events/228145728/) (meetup #1);
Palo Alto, CA;
12 July 2016;
[slides](http://www.slideshare.net/YegorBugayenko/how-anemic-objects-kill-oop),
[video](https://www.youtube.com/watch?v=pynZF10U880).

<div class="talk-event"/>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/3dJP_LtUGgg/mqdefault.jpg" class="past-talk" alt="SLC DevOpsDays 2016"/>
Eight Maturity Levels of Continuous Integration;
Salt Lake City DevOpsDays;
Salt Lake City, USA;
15 June 2016;
[slides](http://www.slideshare.net/YegorBugayenko/eight-maturity-levels-of-continuous-integration),
[video](https://www.youtube.com/watch?v=3dJP_LtUGgg).
There were about 250 people with just one track and a pretty good
organization, even though the budget was rather low. I liked the event and
the audience. However, the venue was not comfortable at all
(it was literally a church).

<div class="talk-event"/>
<aside class="venue-rate green">B</aside>
<img src="https://i.ytimg.com/vi/6hOBfjJ2bpw/mqdefault.jpg" class="past-talk" alt="JavaDay 2016"/>
Java vs OOP;
[JavaDay 2016](http://javaday.by/);
Minsk, Belarus;
11 June 2016;
[slides](http://www.slideshare.net/YegorBugayenko/java-vs-oop),
[photos](https://www.facebook.com/javadayby/photos/?tab=album&amp;album_id=1060019404063727),
[video](https://www.youtube.com/watch?v=6hOBfjJ2bpw).
It was a surprisingly well organized one-day event with over 300 attendees,
two tracks, and inexpensive entry ticket ($75). Even though their budget
was rather low they paid for travel and hotel and invited speakers mostly
from abroad. The audience was well prepared for my talk, I've got many questions
right after the presenation and during the rest of the day. However, the
venue was not really comfortable and the content was mostly outdated.

<div class="talk-event"/>
<aside class="venue-rate green">A+</aside>
<img src="https://i.ytimg.com/vi/7yTIWFZrXpg/mqdefault.jpg" class="past-talk" alt="GeekOUT 2016"/>
Chat Bots Architecture;
[GeekOUT 2016](http://2016.geekout.ee/speakers/yegor-bugayenko/);
Tallinn, Estonia;
9 June 2016;
[slides](http://www.slideshare.net/YegorBugayenko/chat-bot-architecture),
[photos](https://www.facebook.com/yegor256/posts/10209692585621352),
[video](https://www.youtube.com/watch?v=7yTIWFZrXpg).
Almost everything was done perfectly at this event. There were over 500 attendees
and just two tracks (when I was speaking). The venue was very comfortable,
modern and located in a walking distance from the center. All the logistics
were done perfectly, the food was of high quality, the team was personally
there and in permanent contact with speakers. It's asolutely a must to be there
again.

<div class="talk-event"/>
<aside class="venue-rate orange">D</aside>
<img src="https://i.ytimg.com/vi/vU_x6oK437I/mqdefault.jpg" class="past-talk" alt="NDC Oslo 2016"/>
Talk to Your Microservice Via a Chat Bot, Not UI;
NDC Oslo;
Oslo, Norway;
8 June 2016;
[slides](http://www.slideshare.net/YegorBugayenko/problems-with-chat-bots),
[video](https://www.youtube.com/watch?v=vU_x6oK437I).
It was a very big event with, I guess, about 1500 visitors and nine (!) tracks.
What was good is that they paid for all travel expenses and the venue was
really modern. Aside from that, everything else was not so good. There was
no focus in content, the audience wasn't prepared at all, there were many
sponsor boothes, but a total lack of attention to the content. Besides that,
I haven't even met organizers.

<div class="talk-event"/>
<aside class="venue-rate orange">C+</aside>
<img src="https://i.ytimg.com/vi/APCUGQlkO3U/mqdefault.jpg" class="past-talk" alt="ITEM 2016"/>
OOP is Dead? Not Yet!;
[ITEM 2016](http://item.com.ua/?utm_source=yegorbugayenko&amp;utm_medium=blog&amp;utm_campaign=item2016#speakers);
Dnipro, Ukraine;
3 June 2016;
[slides](http://www.slideshare.net/YegorBugayenko/oop-is-dead-not-yet),
[video](https://www.youtube.com/watch?v=APCUGQlkO3U).
There were about 400 people, 2-3 tracks and a terrible venue. Seriously,
the place was a total disaster, even though it's a newly built conference
center. The sound, the location of rooms, the after-talk areas&mdash;everything
was uncomfortable. Also, the content was not really well selected. They invited
a few star speakers just because of their names, which usually is a mistake.
The after-party was good though. It seemed that organizers tried to do this event
with love, but the venue and speakers, unfortunately, didn't play along.

<div class="talk-event"/>
<img src="https://i.ytimg.com/vi/sZoJ3gO4PSo/mqdefault.jpg" class="past-talk" alt="ITEM 2016"/>
Your CEO or your programmer is the boss?;
[ITEM 2016](http://item.com.ua/?utm_source=yegorbugayenko&amp;utm_medium=blog&amp;utm_campaign=item2016#speakers);
Dnipro, Ukraine;
2 June 2016;
[slides](http://www.slideshare.net/YegorBugayenko/who-manages-who),
[video](https://www.youtube.com/watch?v=sZoJ3gO4PSo).

<div class="talk-event"/>
<img src="https://i.ytimg.com/vi/4DCrWRuwxos/mqdefault.jpg" class="past-talk" alt="ITEM 2016"/>
Don't be over excited about Amsterdam;
[ITEM 2016](http://item.com.ua/?utm_source=yegorbugayenko&amp;utm_medium=blog&amp;utm_campaign=item2016#speakers);
Dnipro, Ukraine;
2 June 2016;
[video](https://www.youtube.com/watch?v=4DCrWRuwxos).

<div class="talk-event"/>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/ZVn7ufg-tk0/mqdefault.jpg" class="past-talk" alt="PMDay Lviv 2016"/>
Micromanagement;
[PMDay Lviv](http://pmday.com.ua/);
Lviv, Ukraine;
28 May 2016;
[photos](https://www.facebook.com/rostyslav.chayka/posts/10208232510802147),
[video](https://www.youtube.com/watch?v=ZVn7ufg-tk0).
There were over 400 people, two days, and four tracks. The venue, the food,
the transportation were rather good, taking into account ticket price. Besides
that, the audience was very motivated and engaged. The only downside was a very
short time slot for each talk (30 minutes), very short breaks (10 minutes) and
the amount of speakers. It felt too crowded. Asided from that, I would definitely
try to visit it again.

<div class="talk-event"/>
<aside class="venue-rate green">B+</aside>
<img src="https://i.ytimg.com/vi/NflR7DKwxDY/mqdefault.jpg" class="past-talk" alt="DevOpsPro 2016"/>
Deployment Scripts Are Dead, Meet Rultor;
[DevOps Pro](http://devopspro.lt/);
Vilnius, Lithuania;
26 May 2016;
[photos](https://www.facebook.com/yegor256/posts/10209578080758802),
[video](https://www.youtube.com/watch?v=NflR7DKwxDY).
The organization was very good. Not perfect, but very good. There were about
300 people and four tracks (I think it's too many). The only problem was
with the content. It looked like they paid too much attention to logistics
and forgot about content. Aside from that, definitely a place to see again.

<div class="talk-event"/>
<aside class="venue-rate green">A</aside>
<img src="https://i.ytimg.com/vi/63tS3HNmhiE/mqdefault.jpg" class="past-talk" alt="JEEConf 2016"/>
ORM is an Offensive Anti-Pattern;
[JEEConf 2016](http://jeeconf.com/speaker/yegor-bugayenko/);
Kiev, Ukraine;
21 May 2016;
[slides](http://www.slideshare.net/YegorBugayenko/orm-is-a-perfect-antipattern),
[photos](https://www.facebook.com/yegor256/posts/10209552490959073),
[video](https://www.youtube.com/watch?v=63tS3HNmhiE).
The venue, the logistics, the food, the organization, the size (over 1000 people),
and the preliminary screening of my presentation... everything was very good. What I didn't like
is the amount of tracks (too many) and the list of speakers, which, I believe,
almost copied JPoint. Would be great to see new faces. Overall impression was
very positive, definitely will try to attend it next year.

<div class="talk-event"/>
<img src="https://i.ytimg.com/vi/EnhRgXrHCC4/mqdefault.jpg" class="past-talk" alt="JEEConf 2016"/>
How Immutability Helps in OOP;
[JEEConf 2016](http://jeeconf.com/speaker/yegor-bugayenko/);
Kiev, Ukraine;
21 May 2016;
[slides](http://www.slideshare.net/YegorBugayenko/how-immutability-helps-in-oop),
[photos](https://www.facebook.com/yegor256/posts/10209552490959073),
[video](https://www.youtube.com/watch?v=EnhRgXrHCC4).

<div class="talk-event"/>
<aside class="venue-rate green">B</aside>
<img src="https://i.ytimg.com/vi/nCGBgI1MNwE/mqdefault.jpg" class="past-talk" alt="DEVit 2016"/>
Need It Robust? Make It Fragile;
[DEVit 2016](http://devitconf.org/);
Thessaloniki, Greece;
20 May 2016;
[slides](http://www.slideshare.net/YegorBugayenko/need-it-robust-make-it-fragile),
[photos](https://www.facebook.com/yegor256/posts/10209535256568224),
[video](https://www.youtube.com/watch?v=nCGBgI1MNwE).
Surprisingly, the conference was very good. Just two tracks for about 400
attendees, motivated audience, good equipment, video recording, etc. What I
obviously didn't like was the venue (not really comfortable), the mess with
the schedule (my talk was delayed for over 30 minutes), and an absense
of focus on some specific subject. Aside from that, it was a positive experience.

<div class="talk-event"/>
<aside class="venue-rate orange">C</aside>
<img src="https://i.ytimg.com/vi/vOMqDcSXnT0/mqdefault.jpg" class="past-talk" alt="I T.A.K.E. Unconference 2016"/>
Microservices as Chat Bots;
[I T.A.K.E. Unconference 2016](http://itakeunconf.com/);
Bucharest, Romania;
19 May 2016;
[slides](http://www.slideshare.net/YegorBugayenko/microservices-as-chat-bots),
[photos](https://www.facebook.com/yegor256/posts/10209525009272048),
[video](https://www.youtube.com/watch?v=vOMqDcSXnT0).
It was a rather small conference (around 150 people) without any specific
focus. The venue (Radisson) was perfect, but the amount of tracks too big. There
were less than 30 people in my room. Also, the organization was rather messy
and my talk was delayed for over 20 minutes.

<div class="talk-event"/>
<img src="https://i.ytimg.com/vi/p7m7_iiqaHI/mqdefault.jpg" class="past-talk" alt="Bucharest JUG"/>
How Much Immutability is Enough?;
[Bucharest JUG Meetup](http://www.meetup.com/Bucharest-Java-User-Group/events/228944158/);
Bucharest, Romania;
18 May 2016;
[slides](http://www.slideshare.net/YegorBugayenko/how-much-immutability-is-enough),
[photos](https://www.facebook.com/yegor256/posts/10209525009272048),
[video](https://www.youtube.com/watch?v=p7m7_iiqaHI).

<div class="talk-event"/>
<aside class="venue-rate orange">C</aside>
<img src="https://i.vimeocdn.com/video/584587968_590x332.webp" class="past-talk" alt="GeeCON 2016"/>
Fail Fast. Into User's Face;
[GeeCON](http://2016.geecon.org/speakers/info.html?id=120);
Krakow, Poland;
13 May 2016;
[video](https://vimeo.com/177215750),
[slides](http://www.slideshare.net/YegorBugayenko/fail-fast-into-users-face),
[photos](https://www.facebook.com/yegor256/posts/10209494716834756).
Even though it's a big (over 1000 people) and popular European conference about Java, my
overall impression is not really positive. The venue was not
comfortable at all (it was a cinema), there were no tables for food and we
were eating lunch in cinema chairs :) The amount of talks and tracks was
too big, the audience was very disfocused. What seriously affected my
impression is the way listeners were leaving the rooms during the talks,
check this [tweet](https://twitter.com/yegor256/status/731113702691352576).
Besides that, the organization was rather formal and messy. There is a lot
of room for improvement.

<div class="talk-event"/>
<aside class="venue-rate orange">C+</aside>
<img src="https://i.ytimg.com/vi/Ht0JI41kA4I/mqdefault.jpg" class="past-talk" alt="Baltic DevOps 2016"/>
Continuous Integration May Have Negative Effects;
[Baltic DevOps](http://topconf.com/baltic-devops-2016/speaker/yegor-bugayenko/);
Tallinn, Estonia;
10 May 2016;
[slides](http://www.slideshare.net/YegorBugayenko/preflight-build-pitfalls),
[photos](https://www.facebook.com/yegor256/posts/10209460572181161),
[video](https://www.youtube.com/watch?v=Ht0JI41kA4I).
The conference was rather small (around 150 people), but well organized. What
I didn't really like was the food and the venue (we even had some other
conference going in the next room to us). Also, the audience was not really
engaged and prepared, as it seemed to me. I believe, this event may improve
and become better, the potential is definitely there.

<div class="talk-event"/>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/pt9uHp35fwM/mqdefault.jpg" class="past-talk" alt="NTPM 2016"/>
Meetings or Discipline;
[New Trends in Project Management](http://ntpm.pl/);
Gdynia, Poland;
26 April 2016;
[slides](http://www.slideshare.net/YegorBugayenko/meetings-or-discipline),
[photos](https://www.facebook.com/yegor256/posts/10209365963416001),
[video](https://www.youtube.com/watch?v=pt9uHp35fwM).
It was an interesting event, mostly because the audience was full
of questions and really interested in project management. The location, the
food, logistics, etc. were good enough. I didn't really like the content
other speakers were delivering. I suspect that most of them were invited
there because of their names.

<div class="talk-event"/>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/-Y4XS7ZtQ2g/mqdefault.jpg" class="past-talk" alt="JET Conference 2016"/>
An Immutable Object-Oriented Web Framework;
[JET Conference](http://jetconf.by/#/yegor_bugayenko);
Minsk, Belarus;
25 April 2016;
[photos](https://www.facebook.com/yegor256/posts/10209351820262431),
[video](https://www.youtube.com/watch?v=-Y4XS7ZtQ2g).
There were about 250 people. The location was not good at all&mdash;it was a cinema. Also, the audience was so serious or so shy that it
was rather difficult to present. Not just for me. Also, I got an impression
that speakers were invited just because of their names, not the content they
deliver. Aside from that, the impression was positive.

<div class="talk-event"/>
<aside class="venue-rate green">A-</aside>
<img src="https://i.ytimg.com/vi/aER4uwyFbqQ/mqdefault.jpg" class="past-talk" alt="JPoint 2016"/>
ORM - это обидно (ORM is an Offensive Anti-Pattern);
[JPoint 2016](http://javapoint.ru/en/);
Moscow, Russia;
22-24 April 2016;
[slides](http://www.slideshare.net/YegorBugayenko/orm-is-offensive),
[photos](https://www.facebook.com/yegor256/posts/10209338227802628),
[video](https://www.youtube.com/watch?v=aER4uwyFbqQ).
It was a very big (over 1200 people) and a very well organized
Java conference. The food, the location, the logistics, everything. My
presentation was carefully screened beforehand by the organizers and I received a few
valuable corrections. The content, I would say, was not so perfect. I would
recommend to look at new names in the industry and invite those who are less
known but working on something hot and interesting. Besides that, the event
was perfect.

<div class="talk-event"/>
<aside class="venue-rate green">A</aside>
<img src="https://i.ytimg.com/vi/F4N25kZ2zQU/mqdefault.jpg" class="past-talk" alt="JPoint 2016 Students Day"/>
Объектно-Ориентированное Вранье (Object-Oriented Lies);
[Student Day](http://students.javapoint.ru/talks/bugaenko/)
Moscow, Russia;
22-24 April 2016;
[slides](http://www.slideshare.net/YegorBugayenko/object-oriented-lies),
[photos](https://www.facebook.com/yegor256/posts/10209338227802628),
[video](https://www.youtube.com/watch?v=F4N25kZ2zQU).
It was one of the best conferences I've attended so far. A very well organized,
carefully planned, in a perfect and rather expensive location. Besides that,
my speech was screened beforehand. I even had to make it over Skype and some
corrections were received. What I would suggest to invite new speakers&mdash;it seems that there are almost the same faces every year.

<div class="talk-event"/>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/gL4XwP-EBOg/mqdefault.jpg" class="past-talk" alt="WEBIT.Festival 2016"/>
Continuous Integration May Have Negative Effects;
[WEBIT.Festival 2016](http://www.webit.bg/speaker.php?id=2128);
Sophia, Bulgaria;
20 April 2016;
[photos](https://www.facebook.com/yegor256/posts/10209310350105703),
[video](https://www.youtube.com/watch?v=gL4XwP-EBOg).
It was a huge event with, I guess, over 1500 attendees. Even on my presentation
there were over 150 people in the room. The location, the food, the logistics&mdash;everything was good. The only negative part is a total disfocus of the
content. Speakers were talking just about everything. I didn't even understand
why my presentation was accepted there :)

<div class="talk-event"/>
<aside class="venue-rate green">B</aside>
<img src="https://i.ytimg.com/vi/b6r2W3P9vgY/mqdefault.jpg" class="past-talk" alt="NextBuild 2016"/>
Blame the Project;
[NextBuild 2016](http://nextbuild.nl/speakers/yegor-bugayenko/)<br/>
Eindhoven, Netherlands;
16 April 2016;
[slides](http://www.slideshare.net/YegorBugayenko/blame-the-project),
[photos](https://www.facebook.com/yegor256/posts/10209283233547806),
[video](https://www.youtube.com/watch?v=b6r2W3P9vgY).
The event was free-to-enter, but very well organized. The location was
comfortable, the audience motivated enough and the organizers really
cared about the event. The only bad thing was a total absence of speakers
screening. Nobody checked my presentation before and I can only assume
that the same happened to other speakers.

<div class="talk-event"/>
<aside class="venue-rate green">B+</aside>
<img src="https://i.ytimg.com/vi/xbovkm0tTn0/mqdefault.jpg" class="past-talk" alt="AgileEE 2016"/>
Meetings Are a Threat To Code Quality;
[AgileEE 2016](http://kiev2016.agileee.org/);
Kiev, Ukraine;
9 April 2016
[slides](http://www.slideshare.net/YegorBugayenko/meetings-are-a-threat-to-code-quality),
[photos](https://www.facebook.com/yegor256/posts/10209222357985955);
[video](https://www.youtube.com/watch?v=xbovkm0tTn0).
Organization, food, location, audience, welcoming and goodbying are very good, but
the content is rather poor. Most talks were rather boring and poorly prepared.
Aside from that, everything was good and I liked to be there.

<div class="talk-event"/>
<aside class="venue-rate orange">C+</aside>
<img src="https://i.ytimg.com/vi/9j5pq71BS5U/mqdefault.jpg" class="past-talk" alt="Outsource People 2016"/>
Software Outsourcing, 10 Years Ahead Prediction;
[Outsource People 2016](http://outsource-people.com/en);
Minsk, Belarus;
8 April 2016
[slides](http://www.slideshare.net/YegorBugayenko/software-outsourcing-10-years-ahead),
[photos](https://www.facebook.com/yegor256/posts/10209219903204587),
[video](https://www.youtube.com/watch?v=9j5pq71BS5U).
The conference was rather small, but well focused. The audience was actively
engaged and asked a lot of questions. About a hundred people at my talk.
The quality of the location was average and my expenses
were not reimbursed. Also, the content was not really well-prepared or monitored.

<div class="talk-event"/>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/dE0_j4Kk6jo/mqdefault.jpg" class="past-talk" alt="Agilia Conference 2016"/>
Meetings Help Us And Kill Our Projects;
[Agilia Conference 2016](http://agiliaconference.com/agilia-conference-2016/speakers/yegor-bugayenko/);
Olomouc, Czech Republic;
5 April 2016
[slides](http://www.slideshare.net/YegorBugayenko/meetings-help-us-and-kill-our-projects),
[photos](https://www.facebook.com/yegor256/posts/10209204748545730),
[video](https://www.youtube.com/watch?v=dE0_j4Kk6jo).
There were over 250 people and just two main tracks&mdash;good setup.
A comfortable location, careful organization, good food, expenses
paid. The only problem was the content. Most presentations
were rather boring and not well prepared. Aside from that, I liked it.

<div class="talk-event"/>
<aside class="venue-rate orange">C</aside>
<img src="https://i.ytimg.com/vi/LB_YLWhGrco/mqdefault.jpg" class="past-talk" alt="SEDC 2016"/>
Meetings And Motivation, Friends Or Enemies?;
[SEDC 2016](http://www.sedcconference.org/);
Washington DC, USA;
31 March 2016;
[slides](http://www.slideshare.net/YegorBugayenko/meetingsfree-programming),
[photos](https://www.facebook.com/yegor256/posts/10209166064338649),
[video](https://www.youtube.com/watch?v=LB_YLWhGrco).
The place was good, the food was very good, the organization was not bad, but
the audience was rather old and out-of-subject. Maybe system engineering is
not really my thing, but most of these guys live somewhere in 1990. And there
were less than a hundred people for four tracks. Just about twenty per
presentation. It's not really a conference, but more like a meetup.

<div class="talk-event"/>
<aside class="venue-rate red">F-</aside>
Microservices as Chat Bots;
[CascadiaIT](http://casitconf.org/casitconf16/talks/);
Seattle, USA;
12 March 2016;
[slides](http://www.slideshare.net/YegorBugayenko/microservices-as-chat-bots),
[photos](https://www.facebook.com/yegor256/posts/10208900274414067).
It's a very small conference, with barely ten (!) people in the room. The
talks were separated in six rooms, with no specific focus on subjects. Moreover,
I don't think they did any prepareation of speakers or even selection of them.
Clearly, the event was there only to make money. The only thing I enjoyed
was the city, one of my favorites,&mdash;Seattle. Aside from that, it was
a time wasting event for me.

<div class="talk-event"/>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/QMcDa2eyRBY/mqdefault.jpg" class="past-talk" alt="Kyiv DevOps Day"/>
Need Robust Software? Make It Fragile;
[Kyiv DevOps Day](https://www.facebook.com/events/1492540384386929/);
Kyiv, Ukraine;
27 February 2016;
[slides](http://www.slideshare.net/YegorBugayenko/need-robust-software-make-it-fragile),
[photos](https://www.facebook.com/yegor256/posts/10208769445463425),
[video](https://www.youtube.com/watch?v=QMcDa2eyRBY).
Looks like these DataRobot (the sponsor of the event) guys
care about quality and do this with passion. There were about 180 people at
my speech and the reaction of the audience was rather active. What this event can improve
is to pay attention to the preparation of speakers and limiting their number
to just four. They had too many (six) and most of the talks were rather boring, overloaded
with text-rich slides. Also, the place should definitely be changed, NSC Olimpiyskiy
is just a trash. To be honest, there previous event in Fedoriv Hub was much better
(I would give it an "A").

<div class="talk-event"/>
<aside class="venue-rate red">F</aside>
<img src="https://i.ytimg.com/vi/mHCwlZSlZeU/mqdefault.jpg" class="past-talk" alt="DeveloperWeek 2015"/>
Talk To Your Microservice Via a Chat Bot, not UI;
[DeveloperWeek 2016](http://www.developerweek.com/);
San Francisco, USA;
17 February 2016;
[slides](http://www.slideshare.net/YegorBugayenko/chat-bots-are-the-new-ui),
[photos](https://www.facebook.com/yegor256/posts/10208695807182514),
[video](https://www.youtube.com/watch?v=mHCwlZSlZeU).
This was a shame for the entire industry&mdash;money making event with
zero attention to quality. Just random speakers, random attendees, random
subjects&mdash;just anything that will help them make money on selling
tickets.

<div class="talk-event"/>
<aside class="venue-rate red">F+</aside>
<img src="https://i.ytimg.com/vi/Xj226o2xI9Y/mqdefault.jpg" class="past-talk" alt="DevNexus 2015"/>
Talk To Your Microservice Via a Chat Bot, not UI;
[DevNexus 2016](https://www.devnexus.com/s/speakers#Yegor_Bugayenko);
Atlanta, USA;
16 February 2016;
[slides](http://www.slideshare.net/YegorBugayenko/chat-bots-vs-ui),
[photos](https://www.facebook.com/yegor256/posts/10208707358871299),
[video](https://www.youtube.com/watch?v=Xj226o2xI9Y).
That was a huge event with, I would say, over 2000 participants and almost
zero efforts from organizers to make it interesting. Talks were mostly
from sponsors, promoting their own products, or from clowns making
living by talking about "why writing clean code is important".
Needless to say that they didn't
compensate travel expenses of speakers, while making a lot of money
on tickets. It was a waste of time and money.

<div class="talk-event"/>
<aside class="venue-rate green">B+</aside>
<img src="https://i.ytimg.com/vi/qRZYJGYdrwk/mqdefault.jpg" class="past-talk" alt="TECClub 2016"/>
XDSD : Meetings-Free Software Development Methodology;
[The Entrepreneurs' Club](https://www.facebook.com/events/166135913758018/);
Palo Alto, USA;
11 February 2016;
[slides](http://www.slideshare.net/YegorBugayenko/xdsd-management-without-meetings),
[photos](https://www.facebook.com/yegor256/posts/10208653076874283),
[video](https://www.youtube.com/watch?v=qRZYJGYdrwk).
There were about 50 people in the room, most of whom were rather
interested and engaged. The place was comfortable, equipment was of
good quality, the focus was right on my talk, since I was the only presenter.
I've got a number of leads from this event.

### 2015

<div class="talk-event"/>
<aside class="venue-rate orange">C+</aside>
<img src="https://i.ytimg.com/vi/6SfIc5ff-8U/mqdefault.jpg" class="past-talk" alt="DevOpsDays Warsaw 2015"/>
"Continuous Integration May Have Negative Effects";
[DevOpsDays Warsaw 2015](http://devopsdays.pl/);
Warsaw, Poland;
24-25 November 2015;
[slides](http://www.slideshare.net/YegorBugayenko/continuous-integration-is-dead),
[photos](https://www.facebook.com/yegor256/posts/10208114809057924),
[video](https://www.youtube.com/watch?v=6SfIc5ff-8U).
The event was rather big, over 300 people in the room. However, the audience
was rather passive and presentations were mostly from sponsors. The event was there
mostly to make money, which is always a downside. The location was rather
bad&mdash;an old Soviet-time hotel.

<div class="talk-event"/>
<aside class="venue-rate orange">D</aside>
<img src="https://i.ytimg.com/vi/jUil-aTImgU/mqdefault.jpg" class="past-talk" alt="BuildStuff 2015"/>
"How Do You Talk To Your Microservice?";
[BuildStuff 2015](http://buildstuff.com.ua/);
Kyiv, Ukraine;
23 November 2015;
[photos](https://www.facebook.com/yegor256/posts/10208100666144360),
[slides](http://www.slideshare.net/YegorBugayenko/how-do-you-talk-to-your-microservice),
[video](https://www.youtube.com/watch?v=jUil-aTImgU).
The place was a total trash (small rooms in NSC Olimpiyskiy) with bad light,
bad sound and lack of proper ventilation. There was no preparation of talks
or any communication with speakers. These guys are just making money
in a hype market. It's a shame.

<div class="talk-event"/>
<aside class="venue-rate orange">C</aside>
<img src="/images/2015/dat-flock-2015.jpg" class="past-talk" alt="DATFlock 2015"/>
"What keeps us motivated and why we get lazy";
[Distributed Agile Teams, Flock 2015](http://distributed-agile-teams.org/workshops/);
Berlin, Germany;
19-20 November 2015;
[photos](https://www.facebook.com/yegor256/posts/10208081948956442).
There were less than a hundred people in total, separated by, I guess, four rooms.
A rather small event, but participants were active. Agile is in general
a very boring subject, maybe that's why the event was also rather slow, despite
all the attempts of organizers to make it fun.

<div class="talk-event"/>
<img src="https://i.ytimg.com/vi/2a2nWELIk-Y/mqdefault.jpg" class="past-talk" alt="Kyiv DevOps 2015"/>
"Continuous Integration Is Dead";
[Kyiv DevOps Meetup](http://www.meetup.com/Kyiv-DevOps/events/224967053/);
Kyiv, Ukraine;
19 September 2015;
[photos](https://www.facebook.com/yegor256/posts/10207965398482753),
[video](https://www.youtube.com/watch?v=2a2nWELIk-Y).

<div class="talk-event"/>
<img src="https://i.ytimg.com/vi/3IXk5yEJMIs/mqdefault.jpg" class="past-talk" alt="San Francisco DevOps 2015"/>
"CI is DEAD. Or is it?!";
[San Francisco DevOps Meetup](http://www.meetup.com/San-Francisco-DevOps/events/221628916/);
San Francisco, USA;
23 April 2015;
[video](https://www.youtube.com/watch?v=3IXk5yEJMIs).

