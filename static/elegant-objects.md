---
layout: static
title: "Elegant Objects"
description: |
  Elegant Objects is a book about object-oriented
  programming, from an idealistic and a bit futuristic
  point of view.
permalink: elegant-objects.html
image: https://cf.jare.io/?u=http://www.yegor256.com/images/books/elegant-objects/cover.png
keywords:
  - book about object-oriented programming
  - book about oop
  - object-oriented programming book
  - object-oriented programming
  - object thinking
style: |
  .book-event {
    clear: both;
    margin-top: 2em;
  }
  #vol2-reviewers {
    display: none;
  }
  .rv {
    width: 30%;
    display: inline-block;
    padding: .5em;
    vertical-align: top;
  }
  .rv img {
    width: 75%;
    display: block;
    filter: grayscale(100%);
  }
  .rv .name {
    display: block;
    font-weight: bold;
  }
  .rv .text {
    display: block;
    font-size: .8em;
    line-height: 1em;
  }
  .rv .votes {
    display: block;
  }
---

{% badge /images/books/elegant-objects/cover.png 160 http://goo.gl/W2WVMk %}

"Elegant Objects" is my first book. It is about object-oriented
programming, from an idealistic and, maybe, a bit futuristic
point of view. There are 23 independent recommendations for
a practical OOP designer on how to make code cleaner, classes
more solid and architecture more visible. It is available for sale
on [Amazon](http://goo.gl/W2WVMk) (please, don't forget to review it there!),
ISBN: 1519166915.<br/>
<a href="http://goo.gl/W2WVMk"><img src='/images/books/amazon-buy-button.png' style='height:30px'/></a>

<!--more-->

Feb 24, 2017:
The list of reviewers of the second volume is ready (alphabetic order). I'm very
sorry if you're not in the list, but wanted to be. There will be
[more books](/books.html) in the future, you will still have a chance. Aside from that, you are always
welcome to read the book and send me your
corrections, they will get
you to the "acknowledgment" list. See how others
[do that](https://github.com/yegor256/elegantobjects). Here you are:

  * [Andrey Valyaev](https://github.com/DronMDF)
  * [Fabrício Barros Cabral](https://br.linkedin.com/in/fabriciofx)
  * [Igor Dmitriev](https://www.linkedin.com/in/igor-dmitriev-3a29b15a)
  * [Ilya Vassilevsky](https://www.linkedin.com/in/vassilevsky/)
  * [John Page](https://www.linkedin.com/in/johnpage76)
  * [Kiryl Karatsetski](https://www.linkedin.com/in/kkaratsetski)
  * [Marcos Douglas B. Santos](https://www.linkedin.com/in/mdbs99)
  * [Oksana Semenkova](https://media.licdn.com/mpr/mpr/shrinknp_400_400/p/5/005/0a7/326/2676cd2.jpg)
  * [Piotr Chmielowski](https://www.linkedin.com/in/pchmielowski)
  * [Silas Reinagel](https://www.linkedin.com/in/silasreinagel)

If you see yourself in the list, please [email me](mailto:blog@yegor256.com)
and we'll discuss practical
details. I'm ready to mail you the manuscript in a few days.

{% badge /images/books/elegant-objects/cover-razbor-poletov.png 125 %}

Feb 23, 2017:
Русская версия первого тома опубликована при поддержке подкаста
["Разбор Полетов"](http://razbor-poletov.com/)
и ограниченным тиражем в **128 экземпляров**. Это не книга
на русском языке, а английский оригинальный текст, дополненный
вступлениями на русском. Объем книги 330 страниц (оригинальный
английский вариант содержит только 229 страниц). Также, это издание
начинается с ревью, сделанного пятью участниками подкаста (в
порядке получения ревью):
[Барух Садогурский](https://twitter.com/jbaruch),
[Антон Архипов](https://twitter.com/antonarhipov),
[Антон Черноусов](https://twitter.com/golodnyj),
[Алексей Абашев](https://twitter.com/abashev) и
[Виктор Гамов](https://twitter.com/gamussa).
Купить ее можно, написав письмо на [shop@yegor256.com](mailto:shop@yegor256.com).
Повторного тиража на русском языке не будет! Тексты ревью всех пяти
участников подкаста я выложу онлайн сразу после продажи последнего
экземпляра этого тиража. Цена: $40. Для участников конференций, где
я выступаю: $20 (бывают [еще скидки](/books.html)).

Feb 7, 2017:
This is the full list of everybody who expressed
the desire to become a reviewer of the **2nd volume** of
Elegant Objects. I have to select up to 12 people, please help me with your
vote. What does it mean to be a reviewer? It's easy:

  * I will mail you the draft of the book (paper copy, not PDF);
  * You criticize it as much as you can;
  * You scan it and send me back in PDF;
  * I take your suggestions and corrections into account;
  * Your name will be in the list of acknowledgements in the book;
  * You get a free signed copy of the book.

Pay attention, I need your negative comments, not positive ones. I don't
really need you to say how much you like the content&mdash;it's pointless.
I need you to tell me where it's missing, or unclear, or wrong.
People in the list are sorted by the date I've got their applications.
I excluded some really blank applications. If you feel I did that by mistake
to your application, please [email me](mailto:blog@yegor256.com).

<a href="#" id="show-link" onclick="
  $('#show-link').hide();
  $('#vol2-reviewers').show();
  $('#vol2-reviewers a.vote').click(
    function(a) {
      $('#reviewer').val(
        $(this).closest('.rv').find('.name').text()
      );
      return true;
    }
  );
  return false;
">Show the list</a>

<div id="vol2-reviewers">
  <div class="rv">
    <a href="https://www.linkedin.com/in/mdbs99">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAIwAAAAJDA0ZjQ2OGE2LWU4NzUtNGQ4NS04OGE3LTNhZjI3NjViODcyNA.jpg"
        alt="Marcos Douglas B. Santos"/>
    </a>
    <span class="name">Marcos Douglas B. Santos</span>
    <span class="text">I try to make all my code object-oriented. I have a blog about
    OOP and I have over 15 years of systems development experience.
    I was a reviewer of Bloghacks too — last Yegor's book published.</span>
    <span class="votes">20 votes</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/johnpage76">
      <img src="http://m.c.lnkd.licdn.com/mpr/mpr/shrinknp_400_400/p/8/000/1ea/1c7/3fc7e80.jpg"
        alt="John Page"/>
    </a>
    <span class="name">John Page</span>
    <span class="text">I have an annoying habit of finding even the tiniest mistakes
    (typos, grammar, consistency etc.) in other people's work. ;)
    English is my native language and I have read and reread most
    of Yegor's OO publications and have some knowledge and strong
    opinions in that area. (Though I certainly don't have all the answers
    I'm irritatingly good at raising the questions.)</span>
    <span class="votes">1 vote</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/kkaratsetski">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAIFAAAAJDNhYzBiMDk4LTIxMWUtNDA3ZC1iYjRhLTg4ZDY4ODUwNWZhYg.jpg"
        alt="Kiryl Karatsetski"/>
    </a>
    <span class="name">Kiryl Karatsetski</span>
    <span class="text">I always look for the best solution of engineering tasks.
    Software Engineer in Fitbit.</span>
    <span class="votes">1 vote</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/bartoszbilicki">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAANVAAAAJDQwYWM4YjJjLTg0MTItNDI5Mi05YjY5LTQyODY2YzJjYTk5YQ.jpg"
        alt="Bartosz Bilicki"/>
    </a>
    <span class="name">Bartosz Bilicki</span>
    <span class="text">Software developer with 13 years of expertise.
      I adore best clean code, automation and devops practices,  but I am not object fanatic.
      When there are simpler tools that do the job, I happily use them (Spring, Hibernate, Jackson, I am looking at you!).
      Having read >60 IT books, I know how to distinguish useful
      concepts from theorycrafting and marketing bull****.
      You will receive honest and straight review.</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/silasreinagel">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAkvAAAAJDRmYTYwZmM5LTM5MDgtNGMyNC05ODFkLTBjYmFhNjVkN2I2MQ.jpg"
        alt="Silas Reinagel"/>
    </a>
    <span class="name">Silas Reinagel</span>
    <span class="text">I am a passionate Object-Oriented Programmer, with excellent
    writing/communication skills.</span>
  </div>
  <div class="rv">
    <a href="https://in.linkedin.com/in/abhishekmanocha">
      <img src="https://media.licdn.com/media/p/3/000/014/103/1ae9320.jpg"
        alt="Abhishek Manocha"/>
    </a>
    <span class="name">Abhishek Manocha</span>
    <span class="text">First time for me for reviewing. But two simple reasons, I am in
    the OOPs for last 12 years, hold a Technical Architect position,
    want to share my knowledge in tangible. Second, I resonate with
    Yegor on many points. I am follower of his blog since long.</span>
    <span class="votes">3 votes</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/miroslavgenov">
      <img src="https://media.licdn.com/media/p/3/005/080/225/146c8dd.jpg"
        alt="Miroslav Genov"/>
    </a>
    <span class="name">Miroslav Genov</span>
    <span class="text">Java Developer for most then 10 years of experience
    that values Good Design and clean codebases. </span>
  </div>
  <div class="rv">
    <a href="https://ph.linkedin.com/in/carlos-miguel-miranda-0b899392">
      <img src="http://www.teamed.io/images/team/carlosmiranda.png"
        alt="Carlos Miranda"/>
    </a>
    <span class="name">Carlos Miranda</span>
    <span class="text">I have been working for Teamed.io projects for two years.
    Having worked with his projects, I am very familiar with Yegor's methods. </span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/quver">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAl0AAAAJDNjZGE4MTQ4LWIyMTgtNDZhNS05YTg1LTE4MTJkNDc5OGI4Mw.jpg"
        alt="Yvgen Troshchiy"/>
    </a>
    <span class="name">Yvgen Troshchiy</span>
    <span class="text">I am enthusiastic specialist with big experience
    in different projects and companies.</span>
  </div>
  <div class="rv">
    <a href="https://ie.linkedin.com/in/francesco-bianchi-4b49784">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/p/4/005/05f/304/1ddc17b.jpg"
        alt="Francesco Bianchi"/>
    </a>
    <span class="name">Francesco Bianchi</span>
    <span class="text">I already reviewed the Volume 1 of this book and was
    (maybe?) the first one to encourage Yegor to write it after having
    some interesting fights with him over his brilliant posts.
    I've already reviewed 10+ technical books published by Manning
    and currently collaborate with them as Senior Technical Development Editor.</span>
    <span class="votes">1 vote</span>
  </div>
  <div class="rv">
    <a href="https://ca.linkedin.com/in/shawn-fuller-11b5267">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/p/1/000/1ca/19f/07308bb.jpg"
        alt="Shawn Fuller"/>
    </a>
    <span class="name">Shawn Fuller</span>
    <span class="text">Years ago I wrote multi-tier web and batch apps in
    Perl, Java, etc.. (Currently a Business Analyst)
    Recently I created a web donation and contact tracker in PHP (MAMP).
    Reading your book, blog, and David West's book I realize I did
    not understand OOP (except for using small class sizes). Like the
    Mulla Nasrudin, who having taken a memory course said:
    "I’m improving. Now I can sometimes remember that I have forgotten something."
    So it is with my OOP abilities. I would bring a combination
    enthusiasm and naïveté to reading your manuscript.</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/bakkiaraj">
      <img src="https://media.licdn.com/media/p/3/000/09a/16f/17b2481.jpg"
        alt="Bakkiaraj"/>
    </a>
    <span class="name">Bakkiaraj</span>
    <span class="text">I mostly write code in Perl with Moose Object Oriented
    concepts. It might be crazy for you but it does really works.
    I am long lover for OOPs programming, Making SW Build and Test
    automation tools with Perl + Moose.</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/oksana-semenkova-99622bab">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/p/5/005/0a7/326/2676cd2.jpg"
        alt="Semenkova Oksana Nikolaevna"/>
    </a>
    <span class="name">Semenkova Oksana Nikolaevna</span>
    <span class="text">I'm very passionate about software architecture and want
    to help you do your book the best. The themes from it
    are very interesting and useful for future development
    and evolution of Java language and its infrastructure</span>
    <span class="votes">1 vote</span>
  </div>
  <div class="rv">
    <a href="https://github.com/DronMDF">
      <img src="https://avatars3.githubusercontent.com/u/2982959?v=3&amp;s=460"
        alt="Andrey Valyaev"/>
    </a>
    <span class="name">Andrey Valyaev</span>
    <span class="text">I want to use right OOP. I want to learn other
    for right OOP. I want to understand some moments in
    right OOP and help to make you book better.</span>
  </div>
  <div class="rv">
    <a href="www.linkedin.com/in/settyblue">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAASIAAAAJDBlMTU0NzRiLTM2NTUtNDQ2Ni04N2NkLTBjNTEzMDUwZWY5OQ.jpg"
        alt="Rakshith Kunchum"/>
    </a>
    <span class="name">Rakshith Kunchum</span>
    <span class="text">I am a graduate student and I want master Java
    in the way the book 'Elegant Objects' narrate and not
    the way the academia teaches me.</span>
  </div>
  <div class="rv">
    <a href="https://linkedin.com/in/0x13a">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAjkAAAAJDliNzM0ZWYxLTMzZjMtNGQyOC1iMTlmLWU2NjhmZGYwNjc1OQ.jpg"
        alt="Diego Mariani"/>
    </a>
    <span class="name">Diego Mariani</span>
    <span class="text">Because I read all of your articles and I can't agree more.
    I'm obsessed with true object oriented programming and software architecture </span>
  </div>
  <div class="rv">
    <a href="https://www.facebook.com/polart.studio">
      <img src="https://scontent-waw1-1.xx.fbcdn.net/v/t1.0-9/10457828_483815805095641_9124450483338096797_n.jpg?oh=c27ecd3694383a2e73343de382bc286d&oe=590BFA0C"
        alt="Victor Bugaenko"/>
    </a>
    <span class="name">Victor Bugaenko</span>
    <span class="text">Because I really believe in EO conception and want
    to make it popular in Russia. http://www.eolang.ru/</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/patrizio-colomba-03628170/">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAJPAAAAJDU3OWY1NjRmLWJhMDMtNDUzYi1iNmViLTAxYzAwMTcxN2EzNQ.jpg"
        alt="Patrizio Colomba"/>
    </a>
    <span class="name">Patrizio Colomba</span>
    <span class="text">OP Passionate and Coder!</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/raulestradaaparicio">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAQrAAAAJDZhNzUyMjc3LWU0ZWYtNDgxZS1iM2E2LTA2NjMyZTAzNDkzNA.jpg"
        alt="Raul Estrada Aparicio"/>
    </a>
    <span class="name">Raul Estrada Aparicio</span>
    <span class="text">I reviewed 256 Bloghacks. I'm the author of
    books about S.M.A.C.K. stack with Apress and Packt Publishing.</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/jonathanblakes">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAfWAAAAJDVkMzIzMWVlLWVmNGItNGIzNy04ZWFjLTRiNWYxZGM0MGNjMw.jpg"
        alt="Jonathan Blakes"/>
    </a>
    <span class="name">Jonathan Blakes</span>
    <span class="text">I have no fixed opinion about Yegor's approach to
    OOP. I have read and re-read the first edition, blog posts, and your
    comments, taking them all with a pinch of NaCl. My review will
    be based on the attempted application of these ideas to a large
    10+ year old Java (6+) and Jython/Python codebase for a scientific
    data acquisition client-server application used by 100+ staff and 1000+ users 24/7.</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/lrozenblyum">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/p/1/000/016/0f4/3caff31.jpg"
        alt="Leonid Rozenblyum"/>
    </a>
    <span class="name">Leonid Rozenblyum</span>
    <span class="text">interesting in reviewing and improving a cool book</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/vassilevsky/">
      <img src="https://media.licdn.com/media/p/4/005/07e/10f/0fd738e.jpg"
        alt="Ilya Vassilevsky"/>
    </a>
    <span class="name">Ilya Vassilevsky</span>
    <span class="text">My superpower is spotting errors. I
    reported 5 errors in (published) Volume 1.</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/pchmielowski">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAYzAAAAJDg1NDVjYWVhLWUxNDAtNDNjOC1iYzVhLTRjNjk5NGRkZGUxOQ.jpg"
        alt="Piotr Chmielowski"/>
    </a>
    <span class="name">Piotr Chmielowski</span>
    <span class="text">IMO this is true also in case of code: “Beauty is the
    first test; there is no permanent place in the world for ugly
    mathematics.” (Godfrey Harold Hardy). Therefore we HAVE TO
    learn how to write a beautiful code.</span>
    <span class="votes">1 vote</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/richardfloodlfm?trk=hp-identity-name">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAaxAAAAJGNiOTFkZGRkLTA0MjktNGExNC1hM2I3LTllOTAyYWRiNzcwNQ.jpg"
        alt="Richard Flood"/>
    </a>
    <span class="name">Richard Flood</span>
    <span class="text">Like a lot of others I am a professional Software Developer.
    I have been working professionally for about 5 years and the work
    I produce has been heavily influenced by Yegor's teachings.
    I would be honored to have the opportunity to help polish his material,
    ready to be viewed by the public.</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/nikem">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAABPAAAAJDQxNGFiMDI5LTVmNWItNGYwYS04YmEwLWE0MjNiNDAyZTQwOQ.jpg"
        alt="Nikita Salnikov-Tarnovski"/>
    </a>
    <span class="name" class="name">Nikita Salnikov-Tarnovski</span>
    <span class="text">I hope to raise many objections so you can polish your arguments</span>
  </div>
  <div class="rv">
    <a href="https://at.linkedin.com/in/paulroho">
      <img src="https://media.licdn.com/media/p/2/000/065/1fa/3300160.jpg"
        alt="Paul Rohorzka"/>
    </a>
    <span class="name">Paul Rohorzka</span>
    <span class="text">I bought (at a horrendous price) and read Vol1 and
    liked it for some thoughts and totally dismiss others. Want to
    contribute a critical voice.</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/sebastian-schwarz-27b72083">
      <img src="https://media.licdn.com/media/AAEAAQAAAAAAAAuqAAAAJGE5ZGUzMGY2LTIxYWEtNDQ4OC05N2YxLTVkYzJmMmFkNjU1YQ.jpg"
        alt="Sebastian Schwarz"/>
    </a>
    <span class="name">Sebastian Schwarz</span>
    <span class="text">I am Clean Code and EO addicted! My co-workers hate
    me for only accepting immutable classes in code reviews!
    Not to mention naming for void and non-void methods. What
    people call "Grammar nazis" in Language, applies to me
    for Elegant Objects. I am a young developer and grew up with
    Clean Code, so for me, all these rules are basics and standard.
    I would love to be part of the Vol2 review team, to contribute
    my passion to the community, thanks for your vote!</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/akryvtsun">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/p/4/000/13a/2e4/00bbf7e.jpg"
        alt="Andriy Kryvtsun"/>
    </a>
    <span class="name">Andriy Kryvtsun</span>
    <span class="text">I like to write efficient and elegant code</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/ricardojob">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAQqAAAAJGU3ZWI1YzMyLTIxYTQtNDUxOS1iYzQ0LTlhNWE4MDAwNTYxNg.jpg"
        alt="Ricardo de Sousa Job"/>
    </a>
    <span class="name">Ricardo de Sousa Job</span>
    <span class="text">I live in Brazil and I have  your first book. I work
    with development about nine years, I'm enthusiast for OO. </span>
    <span class="votes">2 votes</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/alayor3/">
      <img src="https://media.licdn.com/media/AAEAAQAAAAAAAAmKAAAAJGJmNjA1Y2FkLWM4NGMtNGM4Mi1iZTdlLWZkNDMyNTIwNmYwMg.jpg"
        alt="Alonso Ayala Ortega"/>
    </a>
    <span class="name">Alonso Ayala Ortega</span>
    <span class="text">I pay attention to details. I'm an excellent reviewer.</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/igor-dmitriev-3a29b15a">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAkIAAAAJGE1ZmIzNjRmLTdhMTAtNDQ4Ni04OTRiLTI1OGE4YmNiYzE5OQ.jpg"
        alt="Igor Dmitriev"/>
    </a>
    <span class="name">Igor Dmitriev</span>
    <span class="text">I pay attention to details. I'm an excellent reviewer.</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/pholser">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAirAAAAJDczMDM4NWEzLTVlZTMtNDhhNi04YzBmLWY1ZGM4NTM4MjJiMg.jpg"
        alt="Paul Holser"/>
    </a>
    <span class="name">Paul Holser</span>
    <span class="text">OO expertise, clean code, fastidious proofreading</span>
  </div>
  <div class="rv">
    <a href="https://pl.linkedin.com/in/mkordas">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/p/6/000/25e/1da/1db84c9.jpg"
        alt="Michał Kordas"/>
    </a>
    <span class="name">Michał Kordas</span>
    <span class="text">My speciality is code quality. On daily basis I need to challenge corporate, procedural "clean code" approach with real object oriented solutions.</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/anton-rybochkin-93950b10a">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAfsAAAAJDRjOWU0NjYwLTcxYjgtNDUxYi1iNWZmLWUwN2Y3M2VkY2FiMA.jpg"
        alt="Anton Rybochkin"/>
    </a>
    <span class="name">Anton Rybochkin</span>
    <span class="text">I sleep with an editor</span>
  </div>
  <div class="rv">
    <a href="https://br.linkedin.com/in/fabriciofx">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAlDAAAAJDI3OTgwNDEzLTQ1ZmEtNGMwMS1iMGIwLTFmNDE5M2U0YTEwYw.jpg"
        alt="Fabrício Barros Cabral"/>
    </a>
    <span class="name">Fabrício Barros Cabral</span>
    <span class="text">I'm passionate for Object-Oriented Programming and details. I've 10 years experience as researcher and developer and as lecturer, I'm always looking for the best way to explain knowledge for all people.</span>
    <span class="votes">81 votes</span>
  </div>
  <div class="rv">
    <a href="https://www.linkedin.com/in/jameskirkux">
      <img src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/p/8/005/05b/188/344cccb.jpg"
        alt="James Kirk"/>
    </a>
    <span class="name">James Kirk</span>
    <span class="text">I am a steadfast supporter of software engineering best practices (TDD, SOLID, DRY) and think that violations of them should be punishable by extended Nickelback listening sessions.</span>
  </div>
</div>

Feb 6, 2017:
Good news, the second volume is ready (208 pages). Now it's time to select
the team of reviewers, ship the draft to them, collect their opinions
and publish the book. Hopefully, it will be available on Amazon before
March 10. Here is my offer to all new readers of this new book. If you write
a decent review about the book (not necessarily positive,
but long enough for a detailed review) and post it on your blog, Amazon, and
GoodReads I will refund you **$32** (read more about [available discounts](/books.html)).

Nov 20, 2016:
I've got over 50 emails from those who are interested in reviewing
the second volume of the book. With the first volume, I believe, I made
a mistake in selecting reviewers. Not all of them were as effective as
I was expecting. This time I will make it different. I will put all
all of them in a list and let you vote. The best 12, elected by you,
will get the early draft of the second volume and will help me review it. To
get into the list, please fill <del>this simple form</del>.

Aug 22, 2016:
I will collect all reviews of the book written by its readers on their
blogs, to help you better understand what the book is about, why it's
good and how it could be better:

  * [Ben Nadel](http://www.bennadel.com/blog/3108-elegant-objects-by-yegor-bugayenko.htm)
  * [Alexei Vinogradov](http://qa-blog.alexei-vinogradov.de/2016/05/elegant-objects-egor-bugayenko/) (in Russian)
  * [Renaud Pradenc](http://www.renaudpradenc.com/?p=504)
  * [Руслан Кеба](http://rukeba.com/by-the-way/elegant-objects/) (in Russian)
  * [Lee Kelleher](https://leekelleher.com/2016/10/book-review-elegant-objects-vol1/)
  * [Dmitry Bushenko](http://clojure.by/articles/2016-07/elegant-objects) (in Russian)

Jun 17, 2016:
I started a [Gitter chat room](https://gitter.im/yegor256/elegantobjects),
where we will discuss object-oriented
programming and find out what would be appropriate to write about,
on this blog and in the next volume of the book. Join the chat and stay
up to date.

Apr 14, 2016:
Книгу можно купить в России, Украине, и Беларуссии по цене $35 плюс
доставка. Оплатить через PayPal, WebMoney или напрямую на мою карту
MasterCard. Пишите на [shop@yegor256.com](mailto:shop@yegor256.com).
Вам предложат возможные варианты доставки и вообще помогут.

Apr 10, 2016:
I'm starting to work on the **second volume** of this book. If you are
interested to be a reviewer, please send me an [email](mailto:book@yegor256.com)
with a short description of yourself and your LinkedIn profile. If you were
reviewing the first volume, please don't bother. I want a new group of
reviewers.

<div class="book-event"/>
<div style="float:right;margin-left:1em">
  <a href="http://javapoint.ru/en/">
    <img src="/images/2016/jpoint-2016.png" style="height:45px;" alt="JPoint 2016"/></a><br/>
  <a href="http://jetconf.by/#/yegor_bugayenko">
    <img src="/images/2016/jet-2016.png" style="height:45px;" alt="JET Conference 2016"/></a><br/>
  <a href="http://2016.geecon.org/">
    <img src="/images/2016/geecon-2016.png" style="height:45px;" alt="GeeCON 2016"/></a><br/>
  <a href="http://devitconf.org/">
    <img src="/images/2016/devit-logo.svg" style="height:45px;" alt="DEVit 2016"/></a><br/>
  <a href="http://jeeconf.com/speaker/yegor-bugayenko/">
    <img src="/images/2016/jeeconf-logo.png" style="height:45px;" alt="JEEConf 2016"/></a>
</div>
Mar 17, 2016:
The book just made it into the **top 100 Amazon Best Sellers** in
[Object-Oriented Design](http://www.amazon.com/gp/bestsellers/books/4013/ref=pd_zg_hrsr_b_1_5_last) category!
There are [three reviews](http://goo.gl/W2WVMk)
already. Many thanks to their authors! Would
be great if you publish yours&mdash;this will greatly help
in promoting the manuscript. Besides that, I will be presenting the
book at the following conferences in the next few months:
[JPoint](http://javapoint.ru/en/) in Moscow, April 22;
[JETConf](http://jetconf.by/#/yegor_bugayenko) in Minsk, April 25;
[GeeCON](http://2016.geecon.org/) in Krakow, May 11;
[DEVit](http://devitconf.org/) in Thessaloniki, May 20;
[JEEConf](http://jeeconf.com/speaker/yegor-bugayenko/) in Kiev, May 21.
I will give away a few copies at each event, to those who
ask the most interesting questions after my presentations. Don't miss your
chance to say hello and get a free book.

<div class="book-event"/>
Feb 28, 2016:
Over a 100 books sold already, in just one week! I'm glad to see
that you're interested in reading it. I haven't got a single review yet,
but I'm sure there will be some. I would like to ask you to post your
reviews, either negative or positive, directly to
[Amazon](http://goo.gl/W2WVMk).
I'm getting many requests about an **electronic version** of the book.
I'm not planning to turn this into an e-book, at least until the end
of 2018. Mostly [because]({% pst 2016/nov/2016-11-09-why-no-ebooks %})
I'm greedy. I realize that the moment I publish
a Kindle version, it will be available for a free download somewhere.
Although, some of you are saying that the "dead tree" format is not
convenient, since it takes too much space, etc. Here is the the offer.
You buy a paper book now, read it, make a picture of it,
and throw it away, so that it doesn't take space. When an e-book is available,
send me that picture and I will send you a Kindle/epub/PDF/whatever
file **for free**. How does this sound?

<div class="book-event"/>
{% badge /images/books/elegant-objects/cover.png 125 http://goo.gl/W2WVMk %}
Feb 22, 2016:
The book is published! It is for sale,
[on Amazon](http://goo.gl/W2WVMk).
The price is $40.96. The size is 229 pages. The paper is creamy.
The cover is mate. I took into account recommendations and corrections
of 9 reviewers. Two of them were missed, for technical reasons. I will
definitely include them in the next edition. If you decide to buy it,
please leave your feedback
[on Amazon](http://goo.gl/W2WVMk).
It will help me attract more readers. After reading, please shoot me
an email to [book@yegor256.com](mailto:book@yegor256.com).
I'm very interested to know what you think. Thanks!

<div class="book-event"/>
{% badge /images/books/elegant-objects/cactus.svg 125 %}
Jan 27, 2016:
This cute cactus, created by [Andreea Mironiuc](http://andreeamironiuc.com/),
will be on the cover of the book. For a number of reasons. First,
because it's elegant. Isn't it? Second, it's alive, just like
all our objects in Java. Right? Third, it's pretty hard to offend by
breaking its skin and treating it as a bag for other objects. And forth,
I just like it.

<div class="book-event"/>
{% badge /images/books/elegant-objects/contents.png 125 /images/books/elegant-objects/contents.pdf %}
Jan 19, 2016:
Almost all reviewers have finished already. I'm waiting for the
last two to send me their results and will start making
final changes. Fortunately, the overall feedback is **positive**
so far. All reviewers said that the book was worth reading.
Here is its [contents](/images/books/elegant-objects/contents.pdf), by the way.

<div class="book-event"/>
{% badge /images/books/amazon-advantage.gif 125 http://www.amazon.com/Elegant-Objects-Yegor-Bugayenko/dp/1519166915/ %}
Jan 13, 2016:
You can [pre-order](http://goo.gl/W2WVMk)
the book on Amazon.com. The price is **$40.96**.
As promised, the book will be published on **Feb 22**.

<div class="book-event"/>
{% badge /images/books/elegant-objects/seven-pages.png 125 /images/books/elegant-objects/seven-pages.pdf %}
Dec 24, 2015:
Here is a small Christmas gift for those who are interested
in the book&mdash;[**seven pages** from chapter 2.4](/images/books/elegant-objects/seven-pages.pdf), which
covers the subject I haven't discussed on the blog yet.
This is not exactly the text you will see in the book. This is the
text my selected **11 reviewers** received this week from me by mail.
By the way, their names are (in alphabetic order):
[Andrei Istomin](http://www.linkedin.com/in/andrej-istomin-51ba7530),
[Aneesh Dogra](http://in.linkedin.com/in/aneeshdogra),
[Francesco Bianchi](http://ie.linkedin.com/in/francesco-bianchi-4b49784),
[Ion Bordian](http://dk.linkedin.com/in/ion-bordian-06701a88),
[Kanstantsin Kamkou](http://de.linkedin.com/in/kkamkou/en),
[Michal Švec](http://cz.linkedin.com/in/michal-švec-77065711),
[Nicos Kekchidis](http://www.linkedin.com/in/nicoskek),
[Philip Buuck](http://www.linkedin.com/in/philipbuuck),
[Simon Tsai](http://www.linkedin.com/in/simonjtsai),
[Thanasis Papapanagiotou](http://nl.linkedin.com/in/thanpa),
and [Xiasong Pan](http://www.linkedin.com/in/xipan).
I hope to receive their reviews by the end of January. Then, will
spend another 2-3 weeks to take their recommendations into account
and the book will go out at the end of February.

<div class="book-event"/>
Dec 6, 2015:
I've received **63 emails** so far and it's time to choose the best candidates.
I will do it in the next few days and will email them. I will announce
the names of selected reviewers here, soon. Thanks a lot to all of you,
for your readiness to help!

<div class="book-event"/>
{% badge /images/books/elegant-objects/elegant-objects-cover-0.1.png 150 %}
Nov 22, 2015:
The book is ready in its first draft, version **0.1**.
I invite you to become its first reviewer. Send me
an [email](mailto:book@yegor256.com) with a short description about yourself.
I will select a few reviewers (8 is the number I have in mind now).
Then, I will send you a book. It's free and I will
pay for shipping. You will read it (200 pages), and make your corrections
right inside the book. Then, ship it back to me using
UPS [collect on delivery](https://www.ups.com/content/us/en/shipping/time/service/value_added/cod.html).
Your name will be in the book, on the 9th page,
in the list of **acknowledgments**!
I'm interested in your negative feedback mostly.
Tell me what is not clear, what is missing, what needs a more detailed
explanation. But, please, **don't argue** with my ideas. I won't change
them, based on your review. For example, if I'm saying that a
static method is a bad thing and you disagree, don't try to
convince me, it won't help :) This is my opinion and this is what the
book is about. However, I'm sure that my **explanations** and **arguments**
have many flaws. As an early reviewer, you will help me find them.
Again, don't argue with **what** I'm preaching, but complain about **how** I do it.

<div class="book-event"/>
Sep 1, 2015:
The manuscript is finished, in its first draft. Took about 200 hours. Most
of the ideas were taken from the articles previously published on the blog.

<div class="book-event"/>
Jul 5, 2015:
I started to write it.

