---
layout: static
title: "Talks"
description: |
  Here is a full list of my talks at conferences,
  meetups, expos, workshops, etc. This includes both
  upcoming and past talks.
permalink: talks.html
keywords:
  - talks about software development
  - software development presentations
  - workshops about software development
  - conferences about programming
  - software engineers conferences
nospell: true
image: /images/andreea/yegor-is-presenting.png
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
  $(function() {
    var cities = $.map(
      $('span.city'),
      function (v, i) { return $(v).text().toLowerCase(); }
    );
    cities.sort();
    cities = $.unique(cities);
    $('#total-cities')
      .text(cities.length)
      .attr('title', cities.join('; '));
    var countries = $.map(
      $('span.country'),
      function (v, i) { return $(v).text().toLowerCase(); }
    );
    countries.sort();
    countries = $.unique(countries);
    $('#total-countries')
      .text(countries.length)
      .attr('title', countries.join('; '));
  });
---

{% badge /images/andreea/yegor-is-presenting.svg 300 %}

Here is where I'll be speaking soon.
I update this list very often, but
follow me [on Twitter](https://www.twitter.com/yegor256)
for the latest news. I'm also seen [somewhere else](/seen.html) sometimes.

Here is [my calendar](https://calendar.google.com/calendar/ical/mt9l1l9jdo05rnj54daq5tdsb0%40group.calendar.google.com/public/basic.ics),
feel free to import it (to Google Calendar or iCal) and stay
informed about everything I do publicly.

<!--
## <span id='future-talks-total'>&nbsp;</span> Upcoming Events

Nothing yet...
-->

<hr/>

If you are interested in placing me at _your event_,
please [email](mailto:event@yegor256.com). It's free.
You will just have to pay for business-class airfare,
a premium suite in a 5-star hotel, and a limo.
OK, I'm kidding about the limo.
## <span id='past-talks-total'>&nbsp;</span> Past Events

This is a very opinionated and subjective list of conferences
that I attended recently as a speaker. They rate us as speakers,
so why shouldn't we rate them, right? The best grade is
<span class="green">**A+**</span>, while the worst is
<span class="red">**F-**</span>.

Statistically speaking, I've been speaking in
<span id="total-cities">?</span> cities
and
<span id="total-countries">?</span> countries.

I was also seen at [these events](/seen.html).

### 2022

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/KCLECWhB1-w/mqdefault.jpg" class="past-talk" alt="CIPR 2022"/>
Готовы ли мы к роботам, а они к нам?;
[CIPR 2022](https://cipr.ru);
<span class="city">Moscow</span>, <span class="country">Russia</span>;
1 June 2022;
[видео](https://www.youtube.com/watch?v=KCLECWhB1-w).

### 2021

<div class="talk-event">&nbsp;</div>
<img src="https://d3373sevsv1jc.cloudfront.net/uploads/communities_production/community/logo/33/4e737ad5-424b-468b-ac30-d62efefaa073.png" class="past-talk" alt="EngX Z-Day 2021"/>
Code Line No. 0;
[ENGX Z-DAY 2021](https://community-z.com/events/engx-z-day-2021);
<span class="city">Kiev</span>, <span class="country">Ukraine</span>;
3 December;
[video](https://community-z.com/events/engx-z-day-2021/talks/16491).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/PJAzfQtxby4/mqdefault.jpg" class="past-talk" alt="code/R 2021"/>
Анализ качества кода и почему он не работает?;
[&lt;code/R&gt;](https://code-r.ru/);
<span class="city">Omsk</span>, <span class="country">Russia</span>;
18 September;
[видео](https://www.youtube.com/watch?v=PJAzfQtxby4).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/RyTR9vYZj0o/mqdefault.jpg" class="past-talk" alt="Ruby Russia 2021"/>
Твой первый Ruby Gem;
[Ruby Russia](https://rubyrussia.club/);
<span class="city">Moscow</span>, <span class="country">Russia</span>;
24 September;
[видео](https://youtu.be/RyTR9vYZj0o).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/9dydfF_B4DE/mqdefault.jpg" class="past-talk" alt="HighLoad++ 2020"/>
Decentralized Architectures: Blockchain and Beyond;
[HighLoad++](https://www.highload.ru/spring/2021/abstracts/6620);
<span class="city">Moscow</span>, <span class="country">Russia</span>;
17 May;
[видео](https://www.youtube.com/watch?v=9dydfF_B4DE).

### 2020

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/aYXuK2do6FA/mqdefault.jpg" class="past-talk" alt="TestCon 2020"/>
Testing and Testers;
[TestCon](https://testconf.ru/schedule/);
<span class="city">Moscow</span>, <span class="country">Russia</span>;
16 September;
[видео](https://www.youtube.com/watch?v=aYXuK2do6FA).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/jiJxA37hmsQ/mqdefault.jpg" class="past-talk" alt="TeamLeadConf 2020"/>
My experience of 1000 interviews;
[TeamLeadConf](http://teamleadconf.ru/moscow/2020);
<span class="city">Moscow</span>, <span class="country">Russia</span>;
10 February;
[видео](https://www.youtube.com/watch?v=jiJxA37hmsQ),
[slides](https://www.slideshare.net/YegorBugayenko/my-experience-of-1000-interviews).

### 2019

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/w3yJUtgr-yA/mqdefault.jpg" class="past-talk" alt="ProductFest 2019"/>
On Requirements Management;
[ProductFest](https://productfest.ru/moscow/2019);
<span class="city">Moscow</span>, <span class="country">Russia</span>;
9 December;
[видео](https://www.youtube.com/watch?v=w3yJUtgr-yA),
[slides](https://www.slideshare.net/YegorBugayenko/on-requirements-management-demotivate-them-right).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/0N-CevixhsA/mqdefault.jpg" class="past-talk" alt="DevOpsConf 2019"/>
Reversive Decentralized Deployment: Zold Cryptocurrency Example;
[DevOpsConf](http://devopsconf.io/moscow/2019/abstracts/5589);
<span class="city">Moscow</span>, <span class="country">Russia</span>;
30 September;
[видео](https://www.youtube.com/watch?v=0N-CevixhsA).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/6DrD_FucDK4/mqdefault.jpg" class="past-talk" alt="Saint Teamlead Conf 2019"/>
Are You Sure You Are Not a Micromanager?
[Saint Teamlead Conf](https://teamleadconf.ru/spb/2019);
<span class="city">St. Petersburg</span>, <span class="country">Russia</span>;
23 September;
[видео](https://www.youtube.com/watch?v=6DrD_FucDK4),
[slides](https://www.slideshare.net/YegorBugayenko/are-you-sure-you-are-not-a-micromanager-228232854).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/wmvLQFquHGc/mqdefault.jpg" class="past-talk" alt="EPAM Meetup 2019"/>
What's wrong with Java and IT career in USA/Russia;
[Meetup](https://events.epam.com/events/egor-bugaenko);
<span class="city">St. Petersburg</span>, <span class="country">Russia</span>;
24 September;
[видео-1](https://www.youtube.com/watch?v=wmvLQFquHGc),
[видео-2](https://www.youtube.com/watch?v=VslX710UpzQ).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/jZitXMQaXvE/mqdefault.jpg" class="past-talk" alt="QAFest 2019"/>
Quality Assurance vs. Testing;
[QA Fest](http://qafest.com/en/);
<span class="city">Kyiv</span>, <span class="country">Ukraine</span>;
20 September;
[video](https://www.youtube.com/watch?v=jZitXMQaXvE),
[slides](https://www.slideshare.net/YegorBugayenko/quality-assurance-vs-testing).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/YXqHaZJD9R8/mqdefault.jpg" class="past-talk" alt="RockStart Night"/>
Building Object-Oriented Java Web Framework From Scratch;
[RockStart Night Meetup](https://www.meetup.com/Rockstar-Night-Dev-Club/events/264684775/);
<span class="city">Kyiv</span>, <span class="country">Ukraine</span>;
20 September;
[видео](https://www.youtube.com/watch?v=YXqHaZJD9R8).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/s7QCH17lQlY/mqdefault.jpg" class="past-talk" alt="QualityConf 2019"/>
Can Distributed Teams Deliver Quality?
[QualityConf'2019](http://qualityconf.ru/2019);
<span class="city">Moscow</span>, <span class="country">Russia</span>;
27 May;
[видео](https://youtu.be/s7QCH17lQlY),
[slides](https://www.slideshare.net/YegorBugayenko/can-distributed-teams-deliver-quality).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/i84uvEWDeMc/mqdefault.jpg" class="past-talk" alt="AppsConf 2019"/>
Another Five Trends We Are Afraid Of;
[AppsConf'2019](http://appsconf.ru/moscow/2019);
<span class="city">Moscow</span>, <span class="country">Russia</span>;
22 April;
[видео](https://youtu.be/i84uvEWDeMc).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/H0calDDfHL8/mqdefault.jpg" class="past-talk" alt="SECON 2019"/>
Правильно ли мы тестируем;
[SECON'2019](https://2019.secon.ru/reports/pravilno-li-my-testiruem);
<span class="city">Penza</span>, <span class="country">Russia</span>;
19 April;
[видео](https://www.youtube.com/watch?v=H0calDDfHL8);
[slides](https://www.slideshare.net/YegorBugayenko/typical-pitfalls-in-testing).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/vZtI1M2Uwco/mqdefault.jpg" class="past-talk" alt="SECON 2019"/>
Is Java Getting Better?
[SECON'2019](https://2019.secon.ru/reports/pravilno-li-my-testiruem);
<span class="city">Penza</span>, <span class="country">Russia</span>;
19 April,
[видео](https://www.youtube.com/watch?v=vZtI1M2Uwco),
[slides](https://www.slideshare.net/YegorBugayenko/is-java-getting-better).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/VLaGrUsCbYo/mqdefault.jpg" class="past-talk" alt="Samara 2019"/>
Микротаскинг или как обмануть начальника;
[StartupSamara](https://startupsamara.timepad.ru/event/926814/);
<span class="city">Samara</span>, <span class="country">Russia</span>;
13 April;
[видео](https://youtu.be/VLaGrUsCbYo).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/9ynzUGZjKFk/mqdefault.jpg" class="past-talk" alt="JPoint 2019"/>
Software testing pitfalls;
[JPoint](https://jpoint.ru/en/talks/6wxij7hz0buprldhj02uwg/);
<span class="city">Moscow</span>, <span class="country">Russia</span>;
5 April;
[slides](https://www.slideshare.net/YegorBugayenko/software-testing-pitfalls),
[видео](https://www.youtube.com/watch?v=9ynzUGZjKFk).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/smThHyduuY0/mqdefault.jpg" class="past-talk" alt="CodeFest 2019"/>
Five Trends We Are Afraid Of;
[CodeFest](https://2019.codefest.ru/lecture/1515);
<span class="city">Novosibirsk</span>, <span class="country">Russia</span>;
30 March;
[видео](https://www.youtube.com/watch?v=smThHyduuY0),
[slides](https://www.slideshare.net/YegorBugayenko/five-trends-we-are-afraid-of).

### 2018

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/i1fGk8XJ7jI/mqdefault.jpg" class="past-talk" alt="Blockchain 2018"/>
Panel Discussion about Blockchain;
[Blockchain Conference 2018](https://moscow.bc.events/ru);
<span class="city">Moscow</span>, <span class="country">Russia</span>;
20 November;
[видео](https://youtu.be/i1fGk8XJ7jI).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/21vDI9L2kmI/mqdefault.jpg" class="past-talk" alt="DevOpsPro 2018"/>
How True Experts Manage Their Expertise;
[DevOpsPro](https://www.devopspro.ru/speakers/);
<span class="city">Moscow</span>, <span class="country">Russia</span>;
14 November;
[видео](https://youtu.be/21vDI9L2kmI).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/y0X-WQ1bOUI/mqdefault.jpg" class="past-talk" alt="Bee Mobile 2018"/>
Software Testing Philosophy;
[Bee Mobile Meetup](https://www.facebook.com/events/1913869582250737/);
<span class="city">Moscow</span>, <span class="country">Russia</span>;
7 November;
[видео](https://youtu.be/y0X-WQ1bOUI).

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">A</aside>
<img src="https://i.ytimg.com/vi/55mwAbuDrV8/mqdefault.jpg" class="past-talk" alt="Joker Conf 2018"/>
Quality vs. Quantity;
[Joker Conf](https://jokerconf.com/2018/talks/6lu7550n0kew2eeugei4sq/);
<span class="city">St. Petersburg</span>, <span class="country">Russia</span>;
20 October;
[видео](https://youtu.be/55mwAbuDrV8),
[slides](https://www.slideshare.net/YegorBugayenko/quality-vs-quantity-120177792).
This is one of the best conferences organized by JUG.ru. There is nothing
else to say. The venue, the travel organization, the staff, and of course the
audience. These guys know how to do their work. The only problem we've had
this year was the food---it was terrible, thanks to the venue providers (ExpoForum),
shame on them (that's why not A+). Aside from that, Joker rocks!

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/WwjU1ORdz4s/mqdefault.jpg" class="past-talk" alt="GeeCON Prague 2018"/>
Expertise vs Experts;
[GeeCON Prague](https://2018.geecon.cz/speakers/#bio);
<span class="city">Prague</span>, <span class="country">Czech Republic</span>;
18 October;
[video](https://youtu.be/WwjU1ORdz4s),
[slides](https://www.slideshare.net/YegorBugayenko/experts-vs-expertise-119883955).
I'm not for the first time at this event and it seems to be pretty stable
at its quality. It is, as they claim, not-for-profit. It happens in a cinema,
which affects the quality, I believe. The screen is huge, the light is dim,
the sound is not so perfect. Also, the focus of the event is not clear---it is
just about tech in general? Anyway, I keep coming because I like the city :)

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/d_gZUcpBdRM/mqdefault.jpg" class="past-talk" alt="AppsConf 2018"/>
Who Cares About Quality?;
[AppsConf](https://appsconf.ru/2018/abstracts/3721);
<span class="city">Moscow</span>, <span class="country">Russia</span>;
9 October;
[видео](https://youtu.be/d_gZUcpBdRM),
[slides](https://www.slideshare.net/YegorBugayenko/who-cares-about-quality).
The event was organized by the same guys as DevOpsConf and happened
at the same venue, in Moscow. Again, as with the previous one, the quality
of the venue seriously affected the entire impression of the event. The audience
was pretty well prepared, but I totally missed the committee part---even though
it did exist there. Would be great to see more attention paid to the quality
of talks.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/NFJNp5ke4CM/mqdefault.jpg" class="past-talk" alt="DevOpsConf 2018"/>
Quantity vs. Quality;
[DevOpsConf](https://devopsconf.io/moscow/2018/abstracts/3723);
<span class="city">Moscow</span>, <span class="country">Russia</span>;
2 October;
[видео](https://youtu.be/NFJNp5ke4CM),
[slides](https://www.slideshare.net/YegorBugayenko/quantity-vs-quality-117828058).
It's a nice event, with about 100 people at my talk, was pretty warm and
welcome. The quality of the venue was rather low (you can see it at
my video), although the food was pretty decent. Also, I wasn't sure the
event was focused enough on the DevOps subject. My talk wasn't really reviewed
by any committee and I'm not sure it actually exists there.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B+</aside>
<img src="https://i.ytimg.com/vi/KCx1o_lSMkI/mqdefault.jpg" class="past-talk" alt="DevOpsDays Boston 2018"/>
Expertise vs Experts;
[DevOpsDays Boston 2018](https://www.devopsdays.org/events/2018-boston/speakers/yegor-bugayenko/);
<span class="city">Boston, MA</span>, <span class="country">USA</span>;
25 September;
[video](https://youtu.be/KCx1o_lSMkI),
[slides](https://www.slideshare.net/YegorBugayenko/experts-vs-expertise).
Surprisingly, it was a very good event. Usually, as, I believe, I wrote before,
US-based events are way worse in quality comparing to Europe and especially
Eastern Europe. This one was pretty decent. The quality of the venue, the video
(which is not published yet, which is sad), the food, and travel---everything
was good. The audience (about 150 in my talk and about 500 in the entire event),
which is the most important factor, was rather interested
and engaged. I will definitely try to attend again.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate orange">C-</aside>
<img src="https://obs.com.ua/images/obs2.svg" class="past-talk" alt="Odessa Blockchain Summit 2018"/>
Zold: Experimental Cryptocurrency Without Blockchain;
[Odessa Blockchain Summit](https://obs.com.ua/);
<span class="city">Odessa</span>, <span class="country">Ukraine</span>;
6 September;
[slides](https://www.slideshare.net/YegorBugayenko/zold-a-cryptocurrency-without-blockchain).
The event was pretty small (about 20 people at my talk with about 80 in total), despite
the promised 300. Also, the venue was rather unusual for tech talks---some sort of a hotel
lobby. Also, the video recordings of our talks were lost, for some reason. And I wasn't
filming myself :( That's sad.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/MCaKPYBMXyI/mqdefault.jpg" class="past-talk" alt="CryptoBBQ 2018"/>
Life Without Blockchain;
[CryptoBBQ](https://cryptoevent.io/cryptobbq);
<span class="city">Moscow</span>, <span class="country">Russia</span>;
23 Aug 2018;
[видео](https://www.youtube.com/watch?v=MCaKPYBMXyI).
[slides](https://www.slideshare.net/YegorBugayenko/life-without-blockchain).
The organization of the even was decent, including food, the venue, etc. However,
I totally missed the program committee part---did it exist there? It seemed
that the majority of talks were there because they were either friends of
organizers (my case) or paid. Maybe it's inevitable in the area of cryptocurrencies?

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/klCNgqlAflI/mqdefault.jpg" class="past-talk" alt="Meetup 2018"/>
12 шагов от Java к ООП;
[RedCode Meetup #1](https://www.meetup.com/RedCode/events/250405723/);
<span class="city">Krasnodar</span>, <span class="country">Russia</span>;
17 May 2018;
[видео](https://www.youtube.com/watch?v=klCNgqlAflI).

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B+</aside>
<img src="https://i.ytimg.com/vi/_cdni0NMus0/mqdefault.jpg" class="past-talk" alt="DevExperience 2018"/>
Math of Love?;
[DevExperience 2018](http://devexperience.ro/speakers/yegor-bugayenko/);
<span class="city">Iași</span>, <span class="country">Romania</span>;
23 April 2018;
[video](https://www.youtube.com/watch?v=_cdni0NMus0),
[slides](https://www.slideshare.net/YegorBugayenko/math-or-love).
Surpisingly, it was a nice event organized by a good team. They did care
about the quality and really wanted to help us speakers to deliver it to
the audience. The venue was good, the food was good, the travel organization was good,
but the most important part was the preparation of attendees. I would definitely
try to speak there again, if they organize again.

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/BQegLaUIvgs/mqdefault.jpg" class="past-talk" alt="DevExperience 2018"/>
How to Cut Corners and Stay Cool;
[DevExperience 2018](http://devexperience.ro/speakers/yegor-bugayenko/);
<span class="city">Iași</span>, <span class="country">Romania</span>;
23 April 2018;
[video](https://www.youtube.com/watch?v=BQegLaUIvgs),
[slides](https://www.slideshare.net/YegorBugayenko/how-to-cut-corners-and-stay-cool).

### 2017

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/B1MkVQb-hy0/mqdefault.jpg" class="past-talk" alt="DeepRefactoring 2017"/>
TDD наоборот или как срезать углы;
Почему меня не взяли в Amazon;
[DeepRefactoring 2017](http://deeprefactoring.ru/yegor256);
<span class="city">Voronezh</span>, <span class="country">Russia</span>;
20 December 2017;
[видео-1](https://www.youtube.com/watch?v=B1MkVQb-hy0),
[видео-2](https://www.youtube.com/watch?v=ZhWOlaMqppM).

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B+</aside>
<img src="https://i.ytimg.com/vi/6mfo_FHL3PE/mqdefault.jpg" class="past-talk" alt="DevTernity 2017"/>
How Much Do You Cost?
[DevTernity 2017](https://devternity.com/);
<span class="city">Riga</span>, <span class="country">Latvia</span>;
1 December 2017;
[slides](https://www.slideshare.net/YegorBugayenko/how-much-do-you-cost-83117011),
[video](https://www.youtube.com/watch?v=6mfo_FHL3PE).
It was my second year with these guys and I liked it more than in 2016.
The travel, the food, the equipment, the venue were very good. What they still
are missing, I believe, is the interaction between speakers and the audience
outside of the presentation rooms. They need to work harder, I believe, to
connect me with my listeners before the show and after it. Also, to connect
me with other speakers. Aside from that, they are definitely growing, I will
try to attend next year.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B+</aside>
<img src="https://i.ytimg.com/vi/3QT7jaoOa9w/mqdefault.jpg" class="past-talk" alt="DotNext 2017"/>
TDD Upside Down;
[DotNext 2017](https://dotnext-moscow.ru/2017/msk/talks/3ehxgjdfiiws4kkygqa4qc/);
<span class="city">Moscow</span>, <span class="country">Russia</span>;
12-13 November 2017;
[slides](https://www.slideshare.net/secret/cUPqyS0ZwPhKL6),
[видео](https://www.youtube.com/watch?v=3QT7jaoOa9w).
The event was organized by JUG.ru guys (authors of JPoint and Joker) and
it was rather good, as usual. Maybe because it was not Java community, I didn't
get as much value from the event as I was getting from JPoint, but the
overall impression was good. The accomodation, the venue, the equipment,
the food were perfect. What I missed was the promotional part and the social
activity around the talks.

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/VQtdNQd7wIU/mqdefault.jpg" class="past-talk" alt="Семинар в ДНУ"/>
Four factors of success;
[Семинар в ДНУ](https://www.facebook.com/photo.php?fbid=10214062047615171)
(Днепропетровский Государственный Университет,
факультет "Международные Отношения," кафедра "Международная Экономика")<br/>
<span class="city">Dnipro</span>, <span class="country">Ukraine</span>;
13 September 2017;
[видео](https://www.youtube.com/watch?v=VQtdNQd7wIU).

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/nVmRY4Ri4CA/mqdefault.jpg" class="past-talk" alt="PgDay 2017"/>
PostgreSQL + Liquibase + Docker + Maven + Java = Integration Tests;
[PgDay 2017](https://pgday.ru/ru/2017/speakers/136);
<span class="city">St. Petersburg</span>, <span class="country">Russia</span>;
5-7 July 2017;
[video](https://www.youtube.com/watch?v=nVmRY4Ri4CA).
The conference was well organized, but rather small for five tracks. There
were no more than 30 people at my talk. The venue was far away from the
city center which made it difficult to see the historic center of
St. Petersburg. The equipment was not of a high quality. The food was great,
the audience was well prepared, the organizers werefriendly.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B</aside>
<img src="https://i.ytimg.com/vi/cv23Z6xpwDw/mqdefault.jpg" class="past-talk" alt="JDK.IO 2017"/>
Java Annotations Are a Bad Idea;
[JDK IO 2017](http://www.jdk.io/);
<span class="city">Copenhagen</span>, <span class="country">Denmark</span>;
19-20 June 2017;
[video](https://youtu.be/cv23Z6xpwDw),
[slides](https://www.slideshare.net/YegorBugayenko/java-annotations-are-a-bad-idea).
The food, the accomodation, the audience, the equipment was good. The location
was rather far away from the hotel. Aside from that, the conference was
surprisingly good, even though I was told that in 2016 there were not enough
attendees. This year there were just two tracks, about 80 people at my talk.
Will be glad to visit again.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate orange">C+</aside>
<img src="https://i.ytimg.com/vi/oiNI2jF46h0/mqdefault.jpg" class="past-talk" alt="BDMSummit 2017 Summer"/>
Make Customers Trust You;
[BDMSummit 2017](http://bdmsummit.com/yegor-bugayenko-2017s/);
<span class="city">Kyiv</span>, <span class="country">Ukraine</span>;
17 June 2017;
[video](https://youtu.be/oiNI2jF46h0),
[slides](https://www.slideshare.net/YegorBugayenko/make-customers-trust-you).
The event was much smaller than it was announced. I hardly had 40 people
in the room, even though my talk was one of the first. The venue was
average, the organization was good, the food was tasty.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B</aside>
<img src="https://i.ytimg.com/vi/Rip_04Bv3Jk/mqdefault.jpg" class="past-talk" alt="PMCon 2017"/>
How to Be Honest and Keep a Client;
[PMCon Kharkiv 2017](http://pmcon.dev-pro.net/);
<span class="city">Kharkiv</span>, <span class="country">Ukraine</span>;
11 June 2017;
[video](https://youtu.be/Rip_04Bv3Jk),
[slides](https://www.slideshare.net/YegorBugayenko/how-to-be-honest-and-keep-a-client).
There were some technical problems in my talk (you can see them in the video),
but aside from that the event was interesting and well-organized. The team
definitely did it with passion and invested a lot of effort in it. Maybe
a better warming up social procedures would be helpful next year. Would be
glad to attend again, if they invite.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">A-</aside>
<img src="https://i.ytimg.com/vi/1bAixLaOCSA/mqdefault.jpg" class="past-talk" alt="JavaDay Minsk 2017"/>
Object Oriented JUnit Tests;
[JavaDay Minsk 2017](http://javaday.by/);
<span class="city">Minsk</span>, <span class="country">Belarus</span>;
3 June 2017;
[video](https://www.youtube.com/watch?v=1bAixLaOCSA),
[slides](https://www.slideshare.net/YegorBugayenko/objectoriented-junit-tests).
This was my second year and it did work even better than in 2016. The location
was better, the accomodation was perfect, the team was very dedicated, the
audience was interested. Will definitely try to attend next year.

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/BgLqFTY1Rwk/mqdefault.jpg" class="past-talk" alt="JUG.ua Meetup 2017"/>
Object-oriented Mistakes in OpenJDK;
[JUG.ua Meetup](http://jug.ua/);
<span class="city">Kharkiv</span>, <span class="country">Ukraine</span>;
1 June 2017;
[video](https://www.youtube.com/watch?v=BgLqFTY1Rwk) (part 1),
[video](https://www.youtube.com/watch?v=IWroBKW8_QI) (part 2).

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">A-</aside>
<img src="https://i.ytimg.com/vi/CCr8hRE_TUs/mqdefault.jpg" class="past-talk" alt="JEEConf 2017"/>
Object-Oriented Flavor for JUnit Tests;
[JEEConf 2017](http://jeeconf.com/speaker/yegor-bugayenko-2/);
<span class="city">Kyiv</span>, <span class="country">Ukraine</span>;
27 May 2017;
[video](https://www.youtube.com/watch?v=CCr8hRE_TUs),
[slides](https://www.slideshare.net/YegorBugayenko/objectoriented-flavor-for-junit-tests).
As usual, this conference was very good, but this year something was missing.
The venue was perfect, the accomodation, the team, the audience, the
equipment at the highest level. I guess the content could be better with
the budget these guys have available. More cutting-edge talks, more panel
discussions, more provocation, more scandals. It was rather quiet and routine.
Will try to attend next year.

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/GS45LzE3LPQ/mqdefault.jpg" class="past-talk" alt="JEEConf 2017"/>
How Much Do You Cost?;
[JEEConf 2017](http://jeeconf.com/speaker/yegor-bugayenko-2/);
<span class="city">Kyiv</span>, <span class="country">Ukraine</span>;
26 May 2017;
[video](https://www.youtube.com/watch?v=GS45LzE3LPQ),
[slides](https://www.slideshare.net/YegorBugayenko/how-much-do-you-cost).

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate orange">C-</aside>
<img src="https://i.ytimg.com/vi/DLk_5BmgTVk/mqdefault.jpg" class="past-talk" alt="Kyiv Outsourcing Forum 2017"/>
How to Avoid Outsourcing Disaster;
[Kyiv Outsourcing Forum 2017](http://outsourceforum.org/);
<span class="city">Kyiv</span>, <span class="country">Ukraine</span>;
26 May 2017;
[video](https://www.youtube.com/watch?v=DLk_5BmgTVk),
[slides](https://www.slideshare.net/YegorBugayenko/how-to-avoid-outsourcing-disaster).
The event was smaller than I expected, the location was of a rather
low quality, and the audience was pretty much random. Maybe that's because
of the subject, or the time of the year.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate orange">C</aside>
<img src="https://i.ytimg.com/vi/HSh_Gpnn6fo/mqdefault.jpg" class="past-talk" alt="GeeCON 2017"/>
What's This InterruptedException About?;
[GeeCON 2017](https://geecon.org/);
<span class="city">Kraków</span>, <span class="country">Poland</span>;
18-19 May 2017;
[video](https://www.youtube.com/watch?v=HSh_Gpnn6fo).
The event was very big, but many things were not as good as I would expect.
It was in the cinema, as in 2016&mdash;not the best location, if you ask me.
The food was average, the accomodation too. The key issue was the lack
of social connection between speakers and attendees.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B</aside>
<img src="https://i.ytimg.com/vi/IGbteQpTNCA/mqdefault.jpg" class="past-talk" alt="RigaDevDays 2017"/>
How Bright Is Your Future?;
[RigaDevDays 2017](http://rigadevdays.lv/);
<span class="city">Riga</span>, <span class="country">Latvia</span>;
15 May 2017;
[video](https://www.youtube.com/watch?v=IGbteQpTNCA),
[slides](https://www.slideshare.net/YegorBugayenko/how-bright-is-our-future).
The event was rather good, even though the location was not great (the cinema),
the food was average and the equipment was not perfect. There were enough
people for my talks, they were interested and I've got many interesting
responses.

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/K_QEOtYVQ7A/mqdefault.jpg" class="past-talk" alt="RigaDevDays 2017"/>
What's Wrong With Object-Oriented Programming?;
[RigaDevDays 2017](http://rigadevdays.lv/);
<span class="city">Riga</span>, <span class="country">Latvia</span>;
15 May 2017;
[video](https://www.youtube.com/watch?v=K_QEOtYVQ7A),
[slides](https://www.slideshare.net/YegorBugayenko/whats-wrong-with-objectoriented-programming).

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">A</aside>
<img src="https://i.ytimg.com/vi/20QBvrHq6TA/mqdefault.jpg" class="past-talk" alt="JPoint 2017"/>
Java Annotations Are a Big Mistake;
JPoint 2017;
<span class="city">Moscow</span>, <span class="country">Russia</span>;
8 April 2017;
[видео](https://www.youtube.com/watch?v=20QBvrHq6TA) (with English subtitles),
[slides](https://www.slideshare.net/YegorBugayenko/java-annotations-are-evil).
JPoint is one of the best tech conferences I've spoken at so far. Its
strong points are the social activities between speakers, the community,
equipment, location, accommodation, and help with travel. Its weak points
still are the content and its focus on the Russian-speaking community. It would be
great if they could make their events more international and less "Russian-only."
Aside from that, this is definitely an event I would try to attend again.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">A</aside>
<img src="https://i.ytimg.com/vi/85B3FV_sB60/mqdefault.jpg" class="past-talk" alt="JBreak 2017"/>
Utility Classes Are Killing Us;
[JBreak 2017](https://2017.jbreak.ru/speakers/yegor-bugayenko/);
<span class="city">Novosibirsk</span>, <span class="country">Russia</span>;
4 April 2017;
[видео](https://www.youtube.com/watch?v=85B3FV_sB60) (with English subtitles),
[slides](https://www.slideshare.net/YegorBugayenko/utility-classes-are-killing-us).
Yet another great event by [JUG.ru](https://jug.ru/) in Siberia. This was
my first time there, and I enjoyed almost everything: the location, the
organization, travel planning, equipment, and audience. The only thing I didn't
like was the quality of food. Aside from that, I would say that JBreak is an
even better event than JPoint. Maybe because I like smaller one-day events more than
bigger ones that take a few days.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B+</aside>
<img src="https://i.ytimg.com/vi/MSBf2RftCKo/mqdefault.jpg" class="past-talk" alt="DevOn Summit 2017"/>
A Few Best Practices for Time-Wasting on a Software Team;
[DevOn Summit 2017](http://www.devonsummit.com/speakers/);
<span class="city">Delft</span>, <span class="country">The Netherlands</span>;
30 March 2017;
[video](https://www.youtube.com/watch?v=MSBf2RftCKo).
Surprisingly, the event was rather good, even though it was commercial
and put on by a private company (usually such events suck). This one was well-
organized with interesting speakers, good equipment, and a lot of passion
from the team. I received a lot of negative comments from the audience about
my subject, but that's how it has to be with the problem I'm discussing. I'll
definitely recommend it next year.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/TLM9eN0b6zo/mqdefault.jpg" class="past-talk" alt="AgileDays 2017"/>
Избавляйтесь от экспертов;
AgileDays 2017;
<span class="city">Moscow</span>, <span class="country">Russia</span>;
24 March 2017;
[видео](https://www.youtube.com/watch?v=TLM9eN0b6zo).
The event was rather big, and the audience rather active, but I didn't really
feel like I was "there." In the two days I was there, I didn't even meet anybody
from the team that organized it. I was by myself, sitting in the lobby, waiting
for my slot&mdash;this is not what motivates a speaker. Aside from that,
everything was decent: the food, the equipment, the location, the travel, etc.
I believe it's important to be there, because the event is rather big.

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/biE86esgFAE/mqdefault.jpg" class="past-talk" alt="AgileDays 2017"/>
Семь врагов нашей мотивации;
AgileDays 2017;
<span class="city">Moscow</span>, <span class="country">Russia</span>;
24 March 2017;
[видео](https://www.youtube.com/watch?v=biE86esgFAE).

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate orange">C</aside>
<img src="https://i.ytimg.com/vi/lvoQZGsY56k/mqdefault.jpg" class="past-talk" alt="Kharkiv PMDay 2017"/>
Management Without Managers;
[Kharkiv PMDay](http://kh.pmday.org/yehor-buhayenko2017s/);
<span class="city">Kharkiv</span>, <span class="country">Ukraine</span>;
4 March 2017;
[slides](https://www.slideshare.net/YegorBugayenko/management-without-managers),
[видео](https://www.youtube.com/watch?v=lvoQZGsY56k) (with English subtitles).
Yet another event by [LemBS](http://lembs.com/), this time in Kharkiv.
The organization was rather good: the travel and accommodation, the food, the
equipment. What was not really good was the content&mdash;they can do much
better in such a big city with many outsourcing companies. Also, the promotion
part was not as strong as it should be&mdash;most people in the room had never
heard anything about me, etc.

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/qqWC3_cQHAc/mqdefault.jpg" class="past-talk" alt="JUG.ua 2017"/>
OOP Java Puzzlers;
[JUG.ua](https://events.epam.com/events/kyiv-jug-feb28)<br/>
<span class="city">Kyiv</span>, <span class="country">Ukraine</span>;
28 February 2017;
[видео](https://www.youtube.com/watch?v=qqWC3_cQHAc).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/LPLqLaSwSsI/mqdefault.jpg" class="past-talk" alt="JUG Dnipro 2017"/>
Decorators, Decorators, Decorators;
[JUG Dnipro](http://dataart.ua/events/dp/java-user-group-dnipro-dekoratory-dekoratory-dekoratory/);
<span class="city">Dnipro</span>, <span class="country">Ukraine</span>;
11 February 2017;
[видео](https://www.youtube.com/watch?v=LPLqLaSwSsI).

### 2016

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/GQLFc-ttCX0/mqdefault.jpg" class="past-talk" alt="Morning@Lohika"/>
Object-Oriented Java by Example;
[Morning@Lohika 2016](https://dou.ua/calendar/13589/);
<span class="city">Lviv</span>, <span class="country">Ukraine</span>;
24 December 2016;
[видео](https://www.youtube.com/watch?v=GQLFc-ttCX0).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/qAxLtSYN0nw/mqdefault.jpg" class="past-talk" alt="UADevClub"/>
Make Your Java Object-Oriented, 64 Practical Steps;
[UADevClub](http://xpinjection.com/articles/oop-meetup-with-yegor-bugaenko-december-20th/);
<span class="city">Kyiv</span>, <span class="country">Ukraine</span>;
20 December 2016;
[видео](https://www.youtube.com/watch?v=qAxLtSYN0nw).

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B</aside>
<img src="https://i.ytimg.com/vi/7EytYc7K5JA/mqdefault.jpg" class="past-talk" alt="DevTernity 2016"/>
XDSD: Meetings-Free Software Development Methodology;
[DevTernity 2016](http://devternity.com/#/11);
<span class="city">Riga</span>, <span class="country">Latvia</span>;
1 December 2016;
[video](https://www.youtube.com/watch?v=7EytYc7K5JA).
The size of the event was perfect, the audience was motivated, and the
organizers were actively involved, so I liked it. What I didn't like
was the food and the lack of "social glue" between presenters, attendees, and
everybody involved. I'm sure next year they will do it better.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate orange">C+</aside>
<img src="https://i.ytimg.com/vi/R1lA7pN60xg/mqdefault.jpg" class="past-talk" alt="BuildStuff Ukraine 2016"/>
Who Is a Software Architect?;
BuildStuff Ukraine 2016;
<span class="city">Kyiv</span>, <span class="country">Ukraine</span>;
21-22 November 2016;
[slides](http://www.slideshare.net/YegorBugayenko/who-is-a-software-architect),
[video](https://www.youtube.com/watch?v=R1lA7pN60xg).
It was probably too big to be managed right. The Lithuanian part was a bit
better, while the Ukrainian was not so great at all, maybe because I don't like
that Olympiski sport center. Also, in Vilnius there were maybe 15 people
at my presentation&mdash;that was just sad. What I did like was the food.

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/wd-SA1HVmLg/mqdefault.jpg" class="past-talk" alt="BuildStuff 2016"/>
How Do You Know When Your Product Is Ready to be Shipped?;
[BuildStuff 2016](http://www.buildstuff.lt/);
<span class="city">Vilnius</span>, <span class="country">Lithuania</span>;
18 November 2016;
[slides](http://www.slideshare.net/YegorBugayenko/how-do-you-know-when-your-product-is-ready-to-be-shipped),
[video](https://www.youtube.com/watch?v=wd-SA1HVmLg).

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/hkXLOxZ6Fs4/mqdefault.jpg" class="past-talk" alt="TopConf Tallinn 2016"/>
7 Sins of a Software Project;
[TopConf 2016](http://topconf.com/tallinn-2016/speaker/yegor-bugayenko/);
<span class="city">Tallinn</span>, <span class="country">Estonia</span>;
17 November 2016;
[slides](http://www.slideshare.net/YegorBugayenko/seven-sins-of-a-software-project),
[video](https://www.youtube.com/watch?v=hkXLOxZ6Fs4).
The event was rather small (about 300 people), but well-prepared. At my presentation,
the room was full.

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/mq4bsnKK0qs/mqdefault.jpg" class="past-talk" alt="TopConf Tallinn 2016"/>
Keep Your Servers in GitHub;
[TopConf 2016](http://topconf.com/tallinn-2016/speaker/yegor-bugayenko/);
<span class="city">Tallinn</span>, <span class="country">Estonia</span>;
16 November 2016;
[slides](http://www.slideshare.net/YegorBugayenko/keep-your-servers-in-github),
[video](https://www.youtube.com/watch?v=mq4bsnKK0qs).

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate orange">C</aside>
<img src="https://i.ytimg.com/vi/_61CuGhyv-o/mqdefault.jpg" class="past-talk" alt="DevOpsPro Moscow 2016"/>
A Practical Example of a One-Click Release;
[DevOpsPro Moscow 2016](http://www.devopspro.ru/yegor-bugayenko/);
<span class="city">Moscow</span>, <span class="country">Russia</span>;
15 November 2016;
[video](https://www.youtube.com/watch?v=_61CuGhyv-o).
The event was rather small and chaotic. I tried my best to make my speech
interesting, but the audience wasn't really ready.

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/ADd00BotEbI/mqdefault.jpg" class="past-talk" alt="msk.jug.ru"/>
Вредная архитектура MVC;
[msk.jug.ru](https://jugmsk.timepad.ru/event/400420/);
<span class="city">Moscow</span>, <span class="country">Russia</span>;
14 November 2016;
[видео 1](https://www.youtube.com/watch?v=ADd00BotEbI),
[видео 2](https://www.youtube.com/watch?v=utGIIqRGbQc),
[видео 3](https://www.youtube.com/watch?v=03l8o2uu5K4).

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate orange">B+</aside>
<img src="https://i.ytimg.com/vi/tCr9dtGdi2c/mqdefault.jpg" class="past-talk" alt="XP Days Ukraine 2016"/>
XDSD: How Extreme Is Your Team?;
[XP Days Ukraine](http://xpdays.com.ua/);
<span class="city">Kyiv</span>, <span class="country">Ukraine</span>;
12 November 2016;
[video](https://www.youtube.com/watch?v=tCr9dtGdi2c),
[photos](https://www.facebook.com/yegor256/posts/10211115240946846).
This event was organized by the same people who did JEEConf. This time it was
smaller, at a different place, and with less attention to detail, if you ask me.
However, my overall impression was very good; the organizers definitely know what
they are doing. I will try to attend again next year.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/03PXmPc7Q3g/mqdefault.jpg" class="past-talk" alt="Øredev 2016"/>
ORM Is an Offensive Anti-Pattern;
[Øredev 2016](http://www.oredev.org/2016/speakers/yegor-bugayenko);
Malmö, Sweden;
9-10 November 2016;
[slides](http://www.slideshare.net/YegorBugayenko/orm-is-an-offensive-antipattern),
[video](https://www.youtube.com/watch?v=03PXmPc7Q3g),
[photos](https://www.facebook.com/yegor256/posts/10211092077247768).
The event was <del>pretty</del> too big; I would say about 800 attendees, 60 speakers, six tracks, and three
full days plus workshops. For that size of a conference, organizers need
to do way more "social" work for speakers and everybody else. I made almost
no connections there, and most people I met had the same problem. It's a typical
issue for big conferences&mdash;you simply get lost. At this one, they had every
chance to make a great event, but... Aside from that, the venue was great,
the food was good, and the travel and accommodation were perfect. I will definitely try
to attend next year.

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/EDKbYVEInMU/mqdefault.jpg" class="past-talk" alt="Øredev 2016"/>
Built-In Fake Objects;
[Øredev 2016](http://www.oredev.org/2016/speakers/yegor-bugayenko);
Malmö, Sweden;
9-10 November 2016;
[slides](http://www.slideshare.net/YegorBugayenko/builtin-fake-objects),
[video](https://www.youtube.com/watch?v=EDKbYVEInMU).

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B</aside>
<img src="https://i.ytimg.com/vi/4SRoLYxvIQ8/mqdefault.jpg" class="past-talk" alt="JavaDay Kyiv 2016"/>
A Practical Example of AOP With Aspect (in Russian);
[JavaDay Kyiv 2016](http://javaday.org.ua/kyiv/);
<span class="city">Kyiv</span>, <span class="country">Ukraine</span>;
14 October 2016;
[slides](http://www.slideshare.net/YegorBugayenko/practical-example-of-aop-with-aspectj),
[video](https://www.youtube.com/watch?v=4SRoLYxvIQ8),
[photos](https://www.facebook.com/yegor256/posts/10210826984460614).
The venue was great, the size average (about 500 people), and organizers were
very friendly and motivated. I liked the event. A few things definitely
need to be improved, though: the food and the number of tracks. There were too many tracks,
I guess, for the number of people who attended. It would be better to invite fewer
speakers and focus the audience on the best of them. And spend
the money they saved on better food.

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/cGcCcxx4xrg/mqdefault.jpg" class="past-talk" alt="JavaDay Kyiv 2016"/>
Java vs. OOP;
[JavaDay Kyiv 2016](http://javaday.org.ua/kyiv/);
<span class="city">Kyiv</span>, <span class="country">Ukraine</span>;
15 October 2016;
[video](https://www.youtube.com/watch?v=cGcCcxx4xrg).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/Y-16C5yhKLo/mqdefault.jpg" class="past-talk" alt="JavaDay Kyiv 2016"/>
Trial by Combat for OOP Honor (in Russian);
[JavaDay Kyiv 2016](http://javaday.org.ua/kyiv/);
<span class="city">Kyiv</span>, <span class="country">Ukraine</span>;
15 October 2016;
[video](https://www.youtube.com/watch?v=Y-16C5yhKLo).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/A-9FjaOIsw8/mqdefault.jpg" class="past-talk" alt="Object Thinking Meetup #2"/>
Why Static Methods Are Evil;
[Object Thinking Meetup](https://www.meetup.com/Object-Thinking/events/232602670/);
<span class="city">Palo Alto, CA</span>, <span class="country">USA</span>;
9 August 2016;
[video](https://www.youtube.com/watch?v=A-9FjaOIsw8).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/pynZF10U880/mqdefault.jpg" class="past-talk" alt="Object Thinking Meetup #1"/>
How Anemic Objects Kill OOP;
[Object Thinking](http://www.meetup.com/Object-Thinking-in-Silicon-Valley/events/228145728/) (Meetup #1);
<span class="city">Palo Alto, CA</span>, <span class="country">USA</span>;
12 July 2016;
[slides](http://www.slideshare.net/YegorBugayenko/how-anemic-objects-kill-oop),
[video](https://www.youtube.com/watch?v=pynZF10U880).

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/3dJP_LtUGgg/mqdefault.jpg" class="past-talk" alt="SLC DevOpsDays 2016"/>
8 Maturity Levels of Continuous Integration;
Salt Lake City DevOpsDays;
<span class="city">Salt Lake City, UT</span>, <span class="country">USA</span>;
15 June 2016;
[slides](http://www.slideshare.net/YegorBugayenko/eight-maturity-levels-of-continuous-integration),
[video](https://www.youtube.com/watch?v=3dJP_LtUGgg).
There were about 250 people with just one track and a pretty good
organization, even though the budget was rather low. I liked the event and
the audience. However, the venue was not comfortable at all
(It was literally a church).

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B</aside>
<img src="https://i.ytimg.com/vi/6hOBfjJ2bpw/mqdefault.jpg" class="past-talk" alt="JavaDay 2016"/>
Java vs. OOP;
[JavaDay 2016](http://javaday.by/);
<span class="city">Minsk</span>, <span class="country">Belarus</span>;
11 June 2016;
[slides](http://www.slideshare.net/YegorBugayenko/java-vs-oop),
[photos](https://www.facebook.com/javadayby/photos/?tab=album&amp;album_id=1060019404063727),
[video](https://www.youtube.com/watch?v=6hOBfjJ2bpw).
It was a surprisingly well-organized one-day event with more than 300 attendees,
two tracks, and an inexpensive entry ticket ($75). Even though the budget
was rather low, they paid for travel and hotel, and invited speakers mostly
from abroad. The audience was well-prepared for my talk, and I got many questions
right after the presentation and throughout the rest of the day. However, the
venue was not really comfortable, and the content was mostly outdated.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">A+</aside>
<img src="https://i.ytimg.com/vi/7yTIWFZrXpg/mqdefault.jpg" class="past-talk" alt="GeekOUT 2016"/>
Chat Bots Architecture;
[GeekOUT 2016](http://2016.geekout.ee/speakers/yegor-bugayenko/);
<span class="city">Tallinn</span>, <span class="country">Estonia</span>;
9 June 2016;
[slides](http://www.slideshare.net/YegorBugayenko/chat-bot-architecture),
[photos](https://www.facebook.com/yegor256/posts/10209692585621352),
[video](https://www.youtube.com/watch?v=7yTIWFZrXpg),
[official video](https://vimeo.com/album/3998953/video/170745388).
Almost everything was done perfectly at this event. There were more than 500 attendees
and just two tracks (when I was speaking). The venue was very comfortable,
modern, and located within walking distance from the center. All the logistics
were done perfectly, the food was of high quality, the team was personally
there and in permanent contact with speakers. It's absolutely a must to be there
again.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate orange">D</aside>
<img src="https://i.ytimg.com/vi/vU_x6oK437I/mqdefault.jpg" class="past-talk" alt="NDC Oslo 2016"/>
Talk to Your Microservice Via a Chat Bot, Not UI;
NDC Oslo;
<span class="city">Oslo</span>, <span class="country">Norway</span>;
8 June 2016;
[slides](http://www.slideshare.net/YegorBugayenko/problems-with-chat-bots),
[video](https://www.youtube.com/watch?v=vU_x6oK437I).
It was a very big event with, I'd guess, 1,500 visitors and nine (!) tracks.
What was good was they paid for all travel expenses, and the venue was
really modern. Aside from that, everything else was not so good. There was
no focus on content, the audience wasn't prepared at all, and there were many
sponsor booths. Besides that, I never even met the organizers.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate orange">C+</aside>
<img src="https://i.ytimg.com/vi/APCUGQlkO3U/mqdefault.jpg" class="past-talk" alt="ITEM 2016"/>
OOP Is Dead? Not Yet!;
[ITEM 2016](http://item.com.ua/?utm_source=yegorbugayenko&amp;utm_medium=blog&amp;utm_campaign=item2016#speakers);
<span class="city">Dnipro</span>, <span class="country">Ukraine</span>;
3 June 2016;
[slides](http://www.slideshare.net/YegorBugayenko/oop-is-dead-not-yet),
[video](https://www.youtube.com/watch?v=APCUGQlkO3U).
There were about 400 people, two or three tracks, and a terrible venue. Seriously,
the place was a total disaster, even though it's a newly built conference
center. The sound, the location of rooms, the after-talk areas&mdash;everything
was uncomfortable. Also, the content was not really well-selected. They invited
a few star speakers just because of their names, which is usually a mistake.
The after-party was good, though. It seemed that the organizers tried to do this event
with love, but the venue and speakers, unfortunately, didn't play along.

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/sZoJ3gO4PSo/mqdefault.jpg" class="past-talk" alt="ITEM 2016"/>
Is Your CEO or Your Programmer the Boss?;
[ITEM 2016](http://item.com.ua/?utm_source=yegorbugayenko&amp;utm_medium=blog&amp;utm_campaign=item2016#speakers);
<span class="city">Dnipro</span>, <span class="country">Ukraine</span>;
2 June 2016;
[slides](http://www.slideshare.net/YegorBugayenko/who-manages-who),
[video](https://www.youtube.com/watch?v=sZoJ3gO4PSo).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/4DCrWRuwxos/mqdefault.jpg" class="past-talk" alt="ITEM 2016"/>
Don't Be Overly Excited About Amsterdam;
[ITEM 2016](http://item.com.ua/?utm_source=yegorbugayenko&amp;utm_medium=blog&amp;utm_campaign=item2016#speakers);
<span class="city">Dnipro</span>, <span class="country">Ukraine</span>;
2 June 2016;
[video](https://www.youtube.com/watch?v=4DCrWRuwxos).

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/ZVn7ufg-tk0/mqdefault.jpg" class="past-talk" alt="PMDay Lviv 2016"/>
Micromanagement;
[PMDay Lviv](http://pmday.com.ua/);
<span class="city">Lviv</span>, <span class="country">Ukraine</span>;
28 May 2016;
[photos](https://www.facebook.com/rostyslav.chayka/posts/10208232510802147),
[video](https://www.youtube.com/watch?v=ZVn7ufg-tk0).
There were more than 400 people, two days, and four tracks. The venue, the food, and
the transportation were rather good, taking into account the ticket price. Besides
that, the audience was very motivated and engaged. The only downside was a very
short time slot for each talk (30 minutes), very short breaks (10 minutes), and
the number of speakers. It felt too crowded. Aside from that, I would definitely
try to visit again.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B+</aside>
<img src="https://i.ytimg.com/vi/NflR7DKwxDY/mqdefault.jpg" class="past-talk" alt="DevOpsPro 2016"/>
Deployment Scripts Are Dead; Meet Rultor;
[DevOps Pro](http://devopspro.lt/);
<span class="city">Vilnius</span>, <span class="country">Lithuania</span>;
26 May 2016;
[photos](https://www.facebook.com/yegor256/posts/10209578080758802),
[video](https://www.youtube.com/watch?v=NflR7DKwxDY).
The organization was very good. Not perfect, but very good. There were about
300 people and four tracks (I think it's too many). The only problem was
with the content. It looked like they paid too much attention to logistics
and forgot about content. Aside from that, it's definitely a place to see again.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">A</aside>
<img src="https://i.ytimg.com/vi/63tS3HNmhiE/mqdefault.jpg" class="past-talk" alt="JEEConf 2016"/>
ORM Is an Offensive Anti-Pattern;
[JEEConf 2016](http://jeeconf.com/speaker/yegor-bugayenko/);
<span class="city">Kyiv</span>, <span class="country">Ukraine</span>;
21 May 2016;
[slides](http://www.slideshare.net/YegorBugayenko/orm-is-a-perfect-antipattern),
[photos](https://www.facebook.com/yegor256/posts/10209552490959073),
[video](https://www.youtube.com/watch?v=63tS3HNmhiE).
The venue, the logistics, the food, the organization, the size (more than 1,000 people),
and the preliminary screening of my presentation...everything was very good. What I didn't like
was the number of tracks (too many) and the list of speakers, which I believe
almost copied JPoint. It would be great to see new faces. My overall impression was
very positive, and I definitely will try to attend it next year.

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/EnhRgXrHCC4/mqdefault.jpg" class="past-talk" alt="JEEConf 2016"/>
How Immutability Helps in OOP;
[JEEConf 2016](http://jeeconf.com/speaker/yegor-bugayenko/);
<span class="city">Kyiv</span>, <span class="country">Ukraine</span>;
21 May 2016;
[slides](http://www.slideshare.net/YegorBugayenko/how-immutability-helps-in-oop),
[photos](https://www.facebook.com/yegor256/posts/10209552490959073),
[video](https://www.youtube.com/watch?v=EnhRgXrHCC4).

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B</aside>
<img src="https://i.ytimg.com/vi/nCGBgI1MNwE/mqdefault.jpg" class="past-talk" alt="DEVit 2016"/>
Need It Robust? Make It Fragile;
[DEVit 2016](http://devitconf.org/);
<span class="city">Thessaloniki</span>, <span class="country">Greece</span>;
20 May 2016;
[slides](http://www.slideshare.net/YegorBugayenko/need-it-robust-make-it-fragile),
[photos](https://www.facebook.com/yegor256/posts/10209535256568224),
[video](https://www.youtube.com/watch?v=nCGBgI1MNwE).
Surprisingly, the conference was very good. Just two tracks for about 400
attendees, a motivated audience, good equipment, video recording, etc. What I
obviously didn't like was the venue (not really comfortable), the mess with
the schedule (my talk was delayed for more than 30 minutes), and an absence
of focus on a specific subject. Aside from that, it was a positive experience.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate orange">C</aside>
<img src="https://i.ytimg.com/vi/vOMqDcSXnT0/mqdefault.jpg" class="past-talk" alt="I T.A.K.E. Unconference 2016"/>
Microservices as Chat Bots;
[I T.A.K.E. Unconference 2016](http://itakeunconf.com/);
<span class="city">Bucharest</span>, <span class="country">Romania</span>;
19 May 2016;
[slides](http://www.slideshare.net/YegorBugayenko/microservices-as-chat-bots),
[photos](https://www.facebook.com/yegor256/posts/10209525009272048),
[video](https://www.youtube.com/watch?v=vOMqDcSXnT0).
It was a rather small conference (around 150 people) without any specific
focus. The venue (Radisson) was perfect, but the number of tracks was too many. There
were fewer than 30 people in my room. Also, the organization was rather messy,
and my talk was delayed for more than 20 minutes.

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/p7m7_iiqaHI/mqdefault.jpg" class="past-talk" alt="Bucharest JUG"/>
How Much Immutability Is Enough?;
[Bucharest JUG Meetup](http://www.meetup.com/Bucharest-Java-User-Group/events/228944158/);
<span class="city">Bucharest</span>, <span class="country">Romania</span>;
18 May 2016;
[slides](http://www.slideshare.net/YegorBugayenko/how-much-immutability-is-enough),
[photos](https://www.facebook.com/yegor256/posts/10209525009272048),
[video](https://www.youtube.com/watch?v=p7m7_iiqaHI).

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate orange">C</aside>
<img src="https://i.vimeocdn.com/video/584587968_590x332.webp" class="past-talk" alt="GeeCON 2016"/>
Fail Fast. Into User's Face;
[GeeCON](http://2016.geecon.org/speakers/info.html?id=120);
<span class="city">Kraków</span>, <span class="country">Poland</span>;
13 May 2016;
[video](https://vimeo.com/177215750),
[slides](http://www.slideshare.net/YegorBugayenko/fail-fast-into-users-face),
[photos](https://www.facebook.com/yegor256/posts/10209494716834756).
Even though it's a big (more than 1,000 people) and popular European conference about Java, my
overall impression was not really positive. The venue was not
comfortable at all (it was a cinema), there were no tables for food, and we
were eating lunch in cinema chairs. The number of talks and tracks was
too many, and the audience was very unfocused. What seriously affected my
impression was the way listeners left the rooms during the talks;
check out this [tweet](https://twitter.com/yegor256/status/731113702691352576).
Besides that, the organization was rather formal and messy. There is a lot
of room for improvement.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate orange">C+</aside>
<img src="https://i.ytimg.com/vi/Ht0JI41kA4I/mqdefault.jpg" class="past-talk" alt="Baltic DevOps 2016"/>
Continuous Integration May Have Negative Effects;
[Baltic DevOps](http://topconf.com/baltic-devops-2016/speaker/yegor-bugayenko/);
<span class="city">Tallinn</span>, <span class="country">Estonia</span>;
10 May 2016;
[slides](http://www.slideshare.net/YegorBugayenko/preflight-build-pitfalls),
[photos](https://www.facebook.com/yegor256/posts/10209460572181161),
[video](https://www.youtube.com/watch?v=Ht0JI41kA4I).
The conference was rather small (around 150 people), but well-organized. What
I didn't really like was the food and the venue. (We even had some other
conference going on in the room next to us.) Also, the audience was not really
engaged nor prepared, as it seemed to me. I believe this event may improve
and become better; the potential is definitely there.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/pt9uHp35fwM/mqdefault.jpg" class="past-talk" alt="NTPM 2016"/>
Meetings or Discipline;
[New Trends in Project Management](http://ntpm.pl/);
<span class="city">Gdynia</span>, <span class="country">Poland</span>;
26 April 2016;
[slides](http://www.slideshare.net/YegorBugayenko/meetings-or-discipline),
[photos](https://www.facebook.com/yegor256/posts/10209365963416001),
[video](https://www.youtube.com/watch?v=pt9uHp35fwM).
It was an interesting event, mostly because the audience was full
of questions and really interested in project management. The location, the
food, logistics, etc. were good enough. I didn't really like the content
other speakers were delivering, though. I suspect that most of them were invited
there because of their names.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/-Y4XS7ZtQ2g/mqdefault.jpg" class="past-talk" alt="JET Conference 2016"/>
An Immutable Object-Oriented Web Framework;
JET Conference;
<span class="city">Minsk</span>, <span class="country">Belarus</span>;
25 April 2016;
[photos](https://www.facebook.com/yegor256/posts/10209351820262431),
[video](https://www.youtube.com/watch?v=-Y4XS7ZtQ2g).
There were about 250 people present. The location was not good at all&mdash;it was a cinema.
Also, the audience was so serious or so shy that it
was rather difficult to present. Not just for me. Also, I got an impression
that speakers were invited just because of their names, not the content they
deliver. Aside from that, the impression was positive.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">A-</aside>
<img src="https://i.ytimg.com/vi/aER4uwyFbqQ/mqdefault.jpg" class="past-talk" alt="JPoint 2016"/>
ORM - это обидно (ORM Is an Offensive Anti-Pattern);
[JPoint 2016](http://javapoint.ru/en/);
<span class="city">Moscow</span>, <span class="country">Russia</span>;
22-24 April 2016;
[slides](http://www.slideshare.net/YegorBugayenko/orm-is-offensive),
[photos](https://www.facebook.com/yegor256/posts/10209338227802628),
[video](https://www.youtube.com/watch?v=aER4uwyFbqQ).
It was a very big (more than 1,200 people) and a very well-organized
Java conference. The food, the location, the logistics, everything. My
presentation was carefully screened beforehand by the organizers, and I received a few
valuable corrections. The content, I would say, was not so perfect. I would
recommend looking at new names in the industry, and invite those who are less
known but working on something hot and interesting. Besides that, the event
was perfect.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">A</aside>
<img src="https://i.ytimg.com/vi/F4N25kZ2zQU/mqdefault.jpg" class="past-talk" alt="JPoint 2016 Students Day"/>
Объектно-Ориентированное Вранье (Object-Oriented Lies);
[Student Day](http://students.javapoint.ru/talks/bugaenko/)
<span class="city">Moscow</span>, <span class="country">Russia</span>;
22-24 April 2016;
[slides](http://www.slideshare.net/YegorBugayenko/object-oriented-lies),
[photos](https://www.facebook.com/yegor256/posts/10209338227802628),
[video](https://www.youtube.com/watch?v=F4N25kZ2zQU).
It was one of the best conferences I've attended so far, very well-organized and
carefully planned in a perfect and rather expensive location. Besides that,
my speech was screened beforehand. I even had to present it over Skype, and some
corrections were received. I would suggest inviting new speakers&mdash;it seems there are almost the same faces every year.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/gL4XwP-EBOg/mqdefault.jpg" class="past-talk" alt="WEBIT.Festival 2016"/>
Continuous Integration May Have Negative Effects;
[WEBIT.Festival 2016](http://www.webit.bg/speaker.php?id=2128);
<span class="city">Sophia</span>, <span class="country">Bulgaria</span>;
20 April 2016;
[photos](https://www.facebook.com/yegor256/posts/10209310350105703),
[video](https://www.youtube.com/watch?v=gL4XwP-EBOg).
It was a huge event with, I'd guess, more than 1,500 attendees. Even for my presentation,
there were 150 people in the room. The location, the food, the logistics&mdash;everything was good.
The only negative part was a total lack of focus on the
content. Speakers were talking about everything. I didn't even understand
why my presentation was accepted there :)

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B</aside>
<img src="https://i.ytimg.com/vi/b6r2W3P9vgY/mqdefault.jpg" class="past-talk" alt="NextBuild 2016"/>
Blame the Project;
NextBuild 2016<br/>
<span class="city">Eindhoven</span>, <span class="country">The Netherlands</span>;
16 April 2016;
[slides](http://www.slideshare.net/YegorBugayenko/blame-the-project),
[photos](https://www.facebook.com/yegor256/posts/10209283233547806),
[video](https://www.youtube.com/watch?v=b6r2W3P9vgY).
The event was free to attend but very well-organized. The location was
comfortable, the audience was motivated enough, and the organizers really
cared about the event. The only bad thing was a total absence of speaker
screening. Nobody checked my presentation beforehand, and I can only assume
that the same happened to other speakers.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B+</aside>
<img src="https://i.ytimg.com/vi/xbovkm0tTn0/mqdefault.jpg" class="past-talk" alt="AgileEE 2016"/>
Meetings Are a Threat to Code Quality;
[AgileEE 2016](http://Kyiv2016.agileee.org/);
<span class="city">Kyiv</span>, <span class="country">Ukraine</span>;
9 April 2016
[slides](http://www.slideshare.net/YegorBugayenko/meetings-are-a-threat-to-code-quality),
[photos](https://www.facebook.com/yegor256/posts/10209222357985955);
[video](https://www.youtube.com/watch?v=xbovkm0tTn0).
The organization, food, location, audience, welcoming, and departing were very good, but
the content was rather poor. Most talks were rather boring and poorly prepared.
Aside from that, everything else was good, and I liked being there.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate orange">C+</aside>
<img src="https://i.ytimg.com/vi/9j5pq71BS5U/mqdefault.jpg" class="past-talk" alt="Outsource People 2016"/>
Software Outsourcing, 10 Years Ahead Prediction;
[Outsource People 2016](http://outsource-people.com/en);
<span class="city">Minsk</span>, <span class="country">Belarus</span>;
8 April 2016
[slides](http://www.slideshare.net/YegorBugayenko/software-outsourcing-10-years-ahead),
[photos](https://www.facebook.com/yegor256/posts/10209219903204587),
[video](https://www.youtube.com/watch?v=9j5pq71BS5U).
The conference was rather small but well-focused. The audience was actively
engaged and asked a lot of questions. There were about a hundred people at my talk.
The quality of the location was average, and my expenses
were not reimbursed. Also, the content was not really well-prepared or monitored.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/dE0_j4Kk6jo/mqdefault.jpg" class="past-talk" alt="Agilia Conference 2016"/>
Meetings Help Us and Kill Our Projects;
[Agilia Conference 2016](http://agiliaconference.com/agilia-conference-2016/speakers/yegor-bugayenko/);
<span class="city">Olomouc</span>, <span class="country">Czech Republic</span>;
5 April 2016
[slides](http://www.slideshare.net/YegorBugayenko/meetings-help-us-and-kill-our-projects),
[photos](https://www.facebook.com/yegor256/posts/10209204748545730),
[video](https://www.youtube.com/watch?v=dE0_j4Kk6jo).
There were more than 250 people and just two main tracks&mdash;a good setup.
It was a comfortable location, careful organization, good food, and expenses were
paid. The only problem was the content. Most presentations
were rather boring and not well-prepared. Aside from that, I liked it.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate orange">C</aside>
<img src="https://i.ytimg.com/vi/LB_YLWhGrco/mqdefault.jpg" class="past-talk" alt="SEDC 2016"/>
Meetings and Motivation, Friends or Enemies?;
[SEDC 2016](http://www.sedcconference.org/);
<span class="city">Washington, D.C.</span>, <span class="country">USA</span>;
31 March 2016;
[slides](http://www.slideshare.net/YegorBugayenko/meetingsfree-programming),
[photos](https://www.facebook.com/yegor256/posts/10209166064338649),
[video](https://www.youtube.com/watch?v=LB_YLWhGrco).
The place was good, the food was very good, the organization was not bad, but
the audience was rather old and out-of-subject. Maybe system engineering is
not really my thing, but most of these guys live somewhere in the 1990s. And there
were fewer than a hundred people for four tracks. Just about 20 per
presentation. It's not really a conference but more like a meetup.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate red">F-</aside>
Microservices as Chat Bots;
[CascadiaIT](http://casitconf.org/casitconf16/talks/);
<span class="city">Seattle, WA</span>, <span class="country">USA</span>;
12 March 2016;
[slides](http://www.slideshare.net/YegorBugayenko/microservices-as-chat-bots),
[photos](https://www.facebook.com/yegor256/posts/10208900274414067).
It was a very small conference, with barely 10 (!) people in the room. The
talks were separated into six rooms, with no specific focus on subjects. Moreover,
I don't think they did any preparation of speakers or even selection of them.
Clearly, the event was there only to make money. The lone thing I enjoyed
was the city, one of my favorites,&mdash;Seattle. Aside from that, it was
a time-wasting event for me.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B-</aside>
<img src="https://i.ytimg.com/vi/QMcDa2eyRBY/mqdefault.jpg" class="past-talk" alt="Kyiv DevOps Day"/>
Need Robust Software? Make It Fragile;
[Kyiv DevOps Day](https://www.facebook.com/events/1492540384386929/);
<span class="city">Kyiv</span>, <span class="country">Ukraine</span>;
27 February 2016;
[slides](http://www.slideshare.net/YegorBugayenko/need-robust-software-make-it-fragile),
[photos](https://www.facebook.com/yegor256/posts/10208769445463425),
[video](https://www.youtube.com/watch?v=QMcDa2eyRBY).
Looks like these DataRobot (the sponsor of the event) guys
care about quality and do this with passion. There were about 180 people at
my speech, and the reaction from the audience was rather active. What this event can improve
on is to pay attention to the preparation of speakers and limit their number
to just four. They had too many (six), and most of the talks were rather boring, overloaded
with text-rich slides. Also, the place should definitely be changed; NSC Olimpiyskiy
is just trash. To be honest, the previous event at Fedoriv Hub was much better
(I would give it an "A").

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate red">F</aside>
<img src="https://i.ytimg.com/vi/mHCwlZSlZeU/mqdefault.jpg" class="past-talk" alt="DeveloperWeek 2015"/>
Talk to Your Microservice Via a Chat Bot, Not UI;
[DeveloperWeek 2016](http://www.developerweek.com/);
<span class="city">San Francisco, CA</span>, <span class="country">USA</span>;
17 February 2016;
[slides](http://www.slideshare.net/YegorBugayenko/chat-bots-are-the-new-ui),
[photos](https://www.facebook.com/yegor256/posts/10208695807182514),
[video](https://www.youtube.com/watch?v=mHCwlZSlZeU).
This was a shame for the entire industry&mdash;a money-making event with
zero attention to quality. Just random speakers, random attendees, random
subjects&mdash;anything that helped them make money selling
tickets.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate red">F+</aside>
<img src="https://i.ytimg.com/vi/Xj226o2xI9Y/mqdefault.jpg" class="past-talk" alt="DevNexus 2015"/>
Talk to Your Microservice Via a Chat Bot, Not UI;
[DevNexus 2016](https://www.devnexus.com/s/speakers#Yegor_Bugayenko);
<span class="city">Altanta, GA</span>, <span class="country">USA</span>;
16 February 2016;
[slides](http://www.slideshare.net/YegorBugayenko/chat-bots-vs-ui),
[photos](https://www.facebook.com/yegor256/posts/10208707358871299),
[video](https://www.youtube.com/watch?v=Xj226o2xI9Y).
This was a huge event with, I would say, more than 2,000 participants and almost
no effort from organizers to make it interesting. Talks were mostly
from sponsors promoting their own products or from clowns making a
living by talking about "why writing clean code is important."
Needless to say, they didn't
compensate travel expenses for speakers, even while making a lot of money
on tickets. It was a waste of time and money.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate green">B+</aside>
<img src="https://i.ytimg.com/vi/qRZYJGYdrwk/mqdefault.jpg" class="past-talk" alt="TECClub 2016"/>
XDSD: Meetings-Free Software Development Methodology;
[The Entrepreneurs' Club](https://www.facebook.com/events/166135913758018/);
<span class="city">Palo Alto, CA</span>, <span class="country">USA</span>;
11 February 2016;
[slides](http://www.slideshare.net/YegorBugayenko/xdsd-management-without-meetings),
[photos](https://www.facebook.com/yegor256/posts/10208653076874283),
[video](https://www.youtube.com/watch?v=qRZYJGYdrwk).
There were about 50 people in the room, most of whom were rather
interested and engaged. The place was comfortable, equipment was of
good quality, and the focus was right on my talk, as I was the only presenter.
I received a number of leads from this event.

### 2015

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate orange">C+</aside>
<img src="https://i.ytimg.com/vi/6SfIc5ff-8U/mqdefault.jpg" class="past-talk" alt="DevOpsDays Warsaw 2015"/>
"Continuous Integration May Have Negative Effects";
[DevOpsDays Warsaw 2015](http://devopsdays.pl/);
<span class="city">Warsaw</span>, <span class="country">Poland</span>;
24-25 November 2015;
[slides](http://www.slideshare.net/YegorBugayenko/continuous-integration-is-dead),
[photos](https://www.facebook.com/yegor256/posts/10208114809057924),
[video](https://www.youtube.com/watch?v=6SfIc5ff-8U).
The event was rather big, with more than 300 people in the room. However, the audience
was rather passive, and presentations were mostly from sponsors. The event was there
primarily to make money, which is always a downside. The location was rather
bad&mdash;an old Soviet-time hotel.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate orange">D</aside>
<img src="https://i.ytimg.com/vi/jUil-aTImgU/mqdefault.jpg" class="past-talk" alt="BuildStuff 2015"/>
"How Do You Talk to Your Microservice?";
[BuildStuff 2015](http://buildstuff.com.ua/);
<span class="city">Kyiv</span>, <span class="country">Ukraine</span>;
23 November 2015;
[photos](https://www.facebook.com/yegor256/posts/10208100666144360),
[slides](http://www.slideshare.net/YegorBugayenko/how-do-you-talk-to-your-microservice),
[video](https://www.youtube.com/watch?v=jUil-aTImgU).
The place was a total trash pit (small rooms in NSC Olimpiyskiy) with bad lighting,
bad sound, and a lack of proper ventilation. There was no preparation of talks
or any communication with speakers. These guys are just making money
in a hyped market. It's a shame.

<div class="talk-event">&nbsp;</div>
<aside class="venue-rate orange">C</aside>
<img src="/images/2015/dat-flock-2015.jpg" class="past-talk" alt="DATFlock 2015"/>
"What Keeps Us Motivated and Why We Get Lazy";
Distributed Agile Teams, Flock 2015;
<span class="city">Berlin</span>, <span class="country">Germany</span>;
19-20 November 2015;
[photos](https://www.facebook.com/yegor256/posts/10208081948956442).
There were fewer than a hundred people in total, separated by, I would guess, four rooms.
It was a rather small event, but participants were active. Agile is in general
a very boring subject; maybe that's why the event was also rather slow, despite
all the attempts of organizers to make it fun.

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/2a2nWELIk-Y/mqdefault.jpg" class="past-talk" alt="Kyiv DevOps 2015"/>
"Continuous Integration Is Dead";
[Kyiv DevOps Meetup](http://www.meetup.com/Kyiv-DevOps/events/224967053/);
<span class="city">Kyiv</span>, <span class="country">Ukraine</span>;
19 September 2015;
[photos](https://www.facebook.com/yegor256/posts/10207965398482753),
[video](https://www.youtube.com/watch?v=2a2nWELIk-Y).

<div class="talk-event">&nbsp;</div>
<img src="https://i.ytimg.com/vi/3IXk5yEJMIs/mqdefault.jpg" class="past-talk" alt="San Francisco DevOps 2015"/>
"CI Is DEAD. Or Is It?!";
[San Francisco DevOps Meetup](http://www.meetup.com/San-Francisco-DevOps/events/221628916/);
<span class="city">San Fancisco, CA</span>, <span class="country">USA</span>;
23 April 2015;
[video](https://www.youtube.com/watch?v=3IXk5yEJMIs).

