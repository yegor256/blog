---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Shift-M/27"
date: 2018-02-04 12:00:00
place: Dnipro, Ukraine
permalink: /shift-m/2018/27.html
description: |
  TDD philosophy is something we don't teach and don't
  really understand in most cases; GeePaw nailed it
  with many interesting metaphors.
keywords:
  - podcast
  - project management podcast
  - management podcast
  - podcast software management
  - podcast programming
nospell: true
image: /images/andreea/podcast.png
---

<iframe width="100%" height="450" scrolling="no" frameborder="no" allow="autoplay" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/435988986%3Fsecret_token%3Ds-XPw5e&color=%23ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true&visual=true"></iframe>

[GeePaw Hill](http://geepawhill.org/) was a special guest.
He is a coach, a programmer, an expert in Agile/XP/TDD and
a thinker.

His Twitter: [@GeePawHill](https://twitter.com/GeePawHill)

## Transcript

[0:00 Yegor] Michael. Should I say GeePaw or I should Michael?

[0:03 GeePaw] It really is GeePaw. That's not a.. you know, a stage name, that's what people call me. It's short for “grandfather”. Depending on the counting I have between zero and eleven grandchildren. And that's not unusual when you're 58, which I am now, but at the time I became a  grandfather I was just 31…

[0:27 Yegor] Wow.

[0:28 GeePaw] ...and it was very unusual and it seemed very funny to people, so they started calling me Grandpa and then eventually GeePaw. And that's why I'm called GeePaw.

[0:36 Yegor] Okay, it's GeePaw.

[0:37 GeePaw] Yeah.

[0:38 Yegor] Thanks. Thanks for joining us. I already started recording, so let's just say this is the new episode of the podcast, it's called Shift-M, everybody thanks for listening, and we have a special guest, who just already introduced himself. But can you say a few more words about yourself, your professional background?

[0:57 GeePaw] Sure. I am a software a development coach. What I do is I go around and I work with teams of programmers down on the floor and up maybe two-three levels off of the floor and what I do is I just help them get strong. I'm very sticked in the Agile tradition, before Agile there was a thing called extreme programming, and I'm one of that first generation of early adopters of extreme programming. So I really started coaching almost 20 years ago, full time. And that's what I do. I visit teams all over North America, Europe, China and I live with them for a while. And in a living with them, we learn from each other, and hopefully we day and night both become a way stronger.

[1:54 Yegor] Uh-huh. Thanks a lot. I have a lot of questions about testing today, about quality assurance plus testing. We decided to pick that topic, right?

[2:03 GeePaw] Yes.

[2:04 Yegor] Because it seems like you write about that a lot and that's why we've thought about that. So basically my first thing which I wanted to say, as far as you mentioned, you're in this market for many-many years and we didn't have this test-driven development like up until recently, right? So it's something new. So we had just… all we made was testing I believe.

[2:27 GeePaw] Yeah. Right.

[2:28 Yegor] So it was just testing, testing and then now it's test-driven development, TDD. And what do you think, this TDD actually works or not? Because there are two opposite opinions.

[2:38 GeePaw] Right. So you mentioned that I talk a lot about TDD. One of the reasons I do  talk about all the aspects of the Agile, one of the reasons why I talk so much about TDD is precisely because I've seen it to be so amazingly successful, both for me and for the teams that I work with. I just get so much bang for the buck using these techniques. There are parts of the  Agile world that I like a lot, but I'm less confident about. But with TDD I have almost complete confidence that it is the best way we know today to shoot more value faster.

[3:19 Yegor] So you really saw the situations where people write some tests first and then they right code?

[3:25 GeePaw] Oh yes, very much so, very much so.

[3:28 Yegor] And it happens when? When the project just starts or when the project already is in the middle?

[3:33 GeePaw] No. So, it can start at any time. But procedurally, sequentially kinda what happens is you tell me that you want to change the code in a certain way. And that could be from scratch, or it could be something what we were doing and what we wanna do is slightly differently. And what I do is I write a test that proves that the code doesn't work that way.

[4:03 Yegor] Uh-huh.

[4:04 GeePaw] And I don't write just any tests, not everything that I write, you know, not everything what we do is a test, is useful to us. But I write a certain kind of test. And that test establishes to our satisfaction that the code doesn't do what I want it to do. Then – I change the code until that test passes. And if that's not enough to get there, right? Then I write another test and so I'm canceling this sequence of test-code-test-code-test-code-test-code, where each test is quite small and each code change is quite small. And that's sort of a general way this scheme works. Now testing first vs testing after. Well you'll meet a lot of people who are very religious about their beliefs in this matter. My experience is that it's almost impossible to not write a little more code than you have test for.

[5:11 Yegor] Exactly.

[5:12 GeePaw] What we should do is effectively putting or creating a sort of a hole in your test capability. But what the TDD does, even though we call it overcoding, right? Even though we still do overcoding just like everybody does, we immediately go back and write the test as quickly as we possibly can. This only works because the tests we're writing are small, and fast, and easy to read, and write, and debug. If they weren't, then the expense of writing a test will just drag us down and kill us.

[5:50 Yegor] Uh-huh. It seems that we're on the same page, because I am a programmer myself and every time I start some new project and there is nothing in there, so there is no code, technically I can not write a lot of test, write any test, so I have to create some code, you know, when a project is completely empty from scratch then it seems, it looks, it happens that I first create some architecture, some skeleton, and then on top of that I can start adding this test and then it goes into test-code-test-code and all as you just mentioned.

[6:21 GeePaw] Yes, very often at the beginning, you know, I just don't know enough, right? I don't know enough to even know what test will look like.

[6:32 Yegor] Exactly.

[6:33 GeePaw] But, we call it the steering promise, and what just steering promise is these tests and testability are, have to be first-class citizens from the very moment when you start to sketch your design. So I never think to myself: “How am I ever gonna do this” without also thinking “How am I gonna do this in such a fashion that I can reliably, rapidly, easily test that it works.” Those two questions go together because they're both first-class citizens.

[7:07 Yegor] So you start coding and you think upfront how you will test it later so you kind of code for tests?

[7:14 GeePaw] Right. Absolutely. Absolutely. The idea is that the test and testability actively steer our design. And we change our design. We change our code just so it will be easier to test.

[7:27 Yegor] And you think it's right to think that way?

[7:30 GeePaw] Yes. Yes. When you first look at it, it feels like “Oh my gosh, I'm not gonna be coding twice as much” because you know you think “well the tests are code too”, right? But it actually works because that extra little trunk of coding dramatically reduces the amount of time we spend on activities that we're not coding. Like running the debugger, or waiting around for disturber to fire up, or waiting for the remote device to boot up – all those things are things that I don't do when I'm doing TDD. Because I wrote the tests so that I wouldn't have to do that.

[8:15 Yegor] Uh-huh. You know what? I agree, but many people keep telling me that our customers don't pay us to write tests. We don't have the budget for that. Sounds like a good technology blah blah blah, we've heard all these seminars, we read the books, but… Sorry.

[8:35 GeePaw] Dude, it's just you, you just hit me with the most awesome softballs, let me blow this right out of the park. [laughing] TDD is the best… okay, this is the money promise. We moved on from the steering promise to the money promise. We're in this for the money. When we write software for living, when we make software, money comes from shipping more value faster. Now, more value could be more function, right, more features in the program. But it could also be a higher level of performance, it could also be greater degree of stability. TDD does not concern itself with defining values. That is somebody else's jobs, right? That's the company. That's the company's job to decide what's value. TDD says if getting to that value involves working with branchy logic in code, then TDD will actually get to that value faster. And again, I know that this is kind of intuitive, that's why TDD is often treated like it's some kind of weird revolution. It's not. It's actually continuation of last 50 years of us getting better in writing codes. But it does feel like that because it is based on a couple of very non-intuitive results. And one of them is precisely that if you want more functions, then all you want in your life is more stuff on your screen, that's doing more stuff for your customer. TDD will get there faster.

[10:17 Yegor] Okay, you understand that, I understand that. Let me give you a practical example. I was working as a soft-reconsulter a few years ago in one company and I had a task of implementing something which was quite difficult to do without the thing you just mentioned, like bootstrapping some device or whatever. So it look like some extra effort to test my stuff. So I started to write a test. I started to write some… not a framer, but some you know, some sky folding around my code in order to simplify my coding. And then my manager asked me next morning because it took time like a few days, so he came to me next morning and said “What are you doing right now” and I said “look, I'm writing these tests sky folding, like test tools in order to simplify my work”, and he said “no-no-no, you don't do that, we need the features, we don't need you to write the test. We need the features, so you're kind of wasting time. We're not paying you to write test, we're paying you to deliver the code”. And what would you do in that case? How to explain…

[11:19 GeePaw] So, of course we see this all the time, right? That's not a surprise that that happens. But here's a thing. You know, it depends on your manager of course, and it depends on your organization you work with, but generally speaking, you know, they don't actually know what we do and they don't know how to do it best. So I don't let managers tell me where to put semicolons, I don't let managers tell me what is the fastest possible way to type.

[11:55 Yegor] Uh-huh.

[11:57 GeePaw] I happen to know where to put semicolons already, in fact, I'm paid to know where to put semicolons, I'm paid to be a capable typist, I know how to do those things. I basically, if you ask me, if I was writing TDD-style test, even if I was investing, I had a time a little bit, although I don't wanna go overboard here, we'll come back to that. Even if I'm investing a little bit in getting testing capability up and running for the first time, those thing are, you know, that's like asking me “What are you doing?” while I'm changing my editor, “We don't pay you to change your editor” as in fact I do have to change my editor because until my editor changes, I can't shift your functions. And that's the true response. It's one of the great mists of this business, that developers have no power. But honestly, I travel all over the world, I go to a lot of shops, I don't know if you've ever seen this, but ever I wander around the room and notice that no one is actually working, they are all surfing cat pictures, or working crossword puzzles or doing what appears to be writing code until you look closely and you realize that they're actually working on their personal bug. I've seen all of those things happen.

[13:25 Yegor] Yeah, what do you think?

[13:28 GeePaw] How do they get away with that? Well they get away with that because the guy two levels above you in the organization has no idea what you do for a living.

[13:38 Yegor] Yeah, true.

[13:39 GeePaw] They can't tell. They see you typing, you look busy – great. The come to you and say: “what are you doing right now?” And you say: “I'm adding this functionality”, I don't say: “I'm adding semicolons or changing the editor, or building a test framework”, I say: “I'm adding this functionality”. And because TDD works, that is because it actually does let you ship more value faster. They're never blanche, they're fine. They're great. They're happy to see you working. Just like if I change my editor to make my hot keys the way I like them, I go faster that way too.

[14:13 Yegor] That's true, but you know in my case it wasn't exactly a manager, it was like a tech lead, so that guy was a programmer as well, so he knew exactly what I was typing and he knew exactly, you know, how code works. So his point was that “Maybe we'll move into another premise, like you said, from money to time premise”. So he said the more like “we understand the value of unit testing, I know what unit testing is for, but look, we need to finish this project and we care about the time to market, so we need to deliver to the market. What you are doing right now – you're building something for the far-far future, when, you know, of course unit testing will of course help us, but sometime in the future, we now need the features, so stop doing that or just implement it.” That was his plan.

[14:56 GeePaw] Right.

[14:59 Yegor] What do you think about that? How can I answer, that is my question. ...Hello?

[15:15 GeePaw] Hey, are you still there?

[15:17 Yegor] Yeah, I'm here. Sorry. Yeah.

[15:18 GeePaw] Okay, we popped off for a second, sorry about that.

[15:22 Yegor] Uh-huh. Okay. Go ahead.

[15:24 GeePaw] So that's a great question. And it really strikes what I was getting up before about how much do I invest in the future. I do not normally write. So let me get you an example of this. If I had uhm… What kind of work do you mostly do? Is it remote device work, or is it a firmware, or is it webware?

[15:46 Yegor] Web. Web.

[15:48 GeePaw] Webware. So in a webware environment I could write a Selenium test. I try to drive the application by controlling the browser. Those tests are extremely expensive to write.

[16:05 Yegor] Yeah.

[16:06 GeePaw] And they give me very little value. And if my lead said to me “I don't want you writing those tests because they don't pay off” I would say.. well it's not that they don't pay off, let me put it in another way. They don't pay off fast enough.

[16:23 Yegor] Uh-huh.

[16:24 GeePaw] Right? That's the real problem. The problem isn't a question of whether they pay the guy acknowledges that they can pay. He says: “I need to pay back faster than that technique can give me.” I happen to agree with him. I don't write that kinda test. The tests I write are called micro tests, they're very small, they're very fast, and they're very easy to write, and run, and debug. And that is why the pay back actually works. Now, ultimately, of course, in any shop, there are house rules. And we can't do anything about set of house rules except “change the rules or change the shop”. But… I mean you know, right, that's an old Martin Fowler line. He said “Change your organization or change your organization.” [laughing] It gives you two choices. Uhm. And that's a reality. And I accept that that's a real rule but the case for the kind of testing that I do is not about slowing me down.

[17:34 Yegor] Uh-huh.

[17:35 GeePaw] We've stumbled into yet another premise, which is the correlation premise. The correlation premise says “Internal quality and productivity are directly positively related.” When internal quality goes up, productivity goes up. When internal quality goes down, productivity goes down. So the first distinction there is you have to make that distinction between internal and external quality. It's pretty easy to understand. External quality is anything your user can tell. Anything that user could say about your program – that's external quality. They could say it's fast, or it's slow, it's pretty, or it's ugly, it's always up and running or it's spotty around 3 o'clock in the morning or whatever, right? Anything that they can observe – that's external quality. And internal quality is anything you can't tell without access to the source code. So giving the distinction between the IQ (internal quality) and EQ (external quality), you cannot trade internal quality for productivity. And that's confusing because you can change trade away external quality, right? If you don't care whether the screen is ugly, I can get there faster. If you don't care whether it runs in a fraction of a second or a couple of seconds, I can get there faster. I can trade away all the things that users value and can observe about our program in order to get to market faster. What I can't trade away is the internal quality and layout of the code. And TDD is based around shaping the code internally so that it has optimal internal quality. I mean we call it TDD, and we talk about it like it's only testing, but really what it is is the modern synthesis. It's test driving, it's merciless refactoring, it's lots and lots of different things including continuous integration and things like that. It isn't just one technique, it's a bunch of related techniques.

[19:58 Yegor] Uh-huh.

[19:59 GeePaw] And what they're about is this. If we wrote down this big complicated production function, that was going to describe what you do today on your job. Right? Think about the different terms that would be in that huge massive polynomial. The three biggest terms are: 1) how complex is the domain. Right? What kind of problem are you trying to solve; 2) how good are you. Realistically, how good are you; and 3) where did you start. That third term is the easiest of those terms to change. Right? It's really hard, I can't change the domain. If they have twisted bizarre business logic - then there's nothing we can do about that, that's what they have. Your individual skill or my individual skill---well they do go up, but they go up and down slowly. But the starting point, the third most important term, why is that so important? Well, because all programming is changing code. You ever noticed that, you know, your first day of work on a new greenfield project - oi, zipzipzipzip [21:23] - you're moving so fast. Why is that? It's cause you're not chan~, you're changing air. Cause there's no code there to change. You don't have to ever make changes against an existing code base. But that's the first day. On the second day there's already code there. And the changes that I make to my code on the second day, the speed with which I can make those changes depends on how good and strong internally the code was on the first day. And that's the correlation premise, it says---you can't trade productivity for internal quality. The less internal quality you have, the slower you go, not the faster---the slower you go.

[22:14 Yegor] I totally agree about that, but let me ask you the next question, so it seems that you are putting the equal sign between the existence of unit test or any test, and the quality of codes. But there are many people saying and in my experience just the presence of tests doesn't mean that the quality of code goes up, because it's so easy to write bad tests. It's so easy to write tests which don't actually help anyhow, but they actually make the code even more messy, because they are wrong tests, there are so many people, we heard about that, like so many anti-patterns for unit tests which will give you a lot of false positive signals and all that kind of things. So what do you think about that? So is it an equal sign between an existence of test and the quality of code.

[23:06 GeePaw] So… so, and you can quote me on this. Oh good god yes. [laughing] Yes, of course. Uhm… One of the problems with this movement, and I am a very harsh critic of a very own movement. You'll hear me out there raising hell all the time. But we tend to… we oversimplify, and we sloganize things that can not be successfully simplified, and successfully turned into little mottoes. So you know there's earlier that I said that all tests are not created equal. Some tests are better than others. TDD isn't start today writing a test before you change any code, kind of thing. I can't give you a sentence that says what the modern synthesis is. ‘Cause the modern synthesis is a bunch of things. And you can, and I have seen it, you can do horrible damage to yourself by starting off with the naïve interpretation of that language and by… like I don't know what can I tell you, it's like... sometimes people watch too much internet. And you hear me, you can hear me, right, you can hear that I'm really enthusiastic about this, I believe in this technique, I use it all the time, I use it for my own night coding, I use it in my daytime projects, I teach it to people, I share it everywhere I go. But it doesn't fit in a sentence like “You always have to write tests”. What we done is we've hit... Gosh! We've covered three already, we're hitting the fourth premise, the fourth premise is the judgment premise. In programming there are no algorithms for writing code. Right? There just is not an algorithm you can use to write code. You know, just a second, I have to relocate, I've got a sudden noise in my bathroom.

[25:25 Yegor] No, I don't hear it.

[25:26 GeePaw] Uh, okay, okay, good. Good to know. Alright. So, there is no prebuilt algorithm that tell you what to type. And that's a good thing because, you know, the day after they invent an algorithm telling us what to type we'll all be out of the job and a week after that we will be hiding in the rubble from the Skynet. Because that is not actually problem that we wish to solve, and seemingly by all standards of theory nowadays it's not a problem that it's just possible to solve, there will never be an algorithm for doing what we do. So what does that mean? That means that as a model for writing code TDD is permanently, unavoidably, irremediably, and happily dependent on individual humans using their individual judgment. There are many-many possible tests I never write.

[26:44 Yegor] Uh-huh.

[26:45 GeePaw] I don't write them because they don't pay me back. Or sometimes I don't write them because they pay me not quick enough. The tests I write have to be cheap to write, they have to be fast, they have to be easy to read, easy to write, easy to debug. If they're not – there's no payback. Well, how do I get there? judgment. I have to use my judgment. I never write a test that says “If I have a method called getx() whose body is return x believe me, I don't ever write a test for getbacks, forget that.

[27:28 Yegor] Yeah.

[27:29 GeePaw] If I had a method So you're in a web world, we have some sort of html, http transport mechanism. You know Oracle, right? Maybe you're using Spring boot, maybe you're not even in Java, you're in some other app, and have this framework. You never test that framework. Using an automated test. You know, yeah, because you know what? It works. Oracle works. I don't write tests to see whether it's equal actually..

[28:01 Yegor] ..is up to date.

[28:03 GeePaw] Occasionally, of course, in real life, occasionally I will write a query that is sophisticated and complex enough as to rattle me. Where isn't just select * from table. But generally speaking, I don't waste time on tests like that. Because the money premise, it doesn't help me ship value faster to write those tests, so I don't write them. A big thing that has to be said over and over and over again, again about this is---no one's asking you to leave your brain at the door.

[28:40 Yegor] Uh-huh.

[28:42 GeePaw] I'm sorry that it sounds like that. And If you go out on the internet, you'll see there plenty of people who seem to be saying that, but they're simply not understanding it themselves. That's the problem when something new and exciting happens, a lot of people jump in. It's very attractive to make statements and say “always” and “never”, and it's very attractive to write simple little mottos that supposedly capture your whole world but that's not real programming. And it has never been real programming. Real programming for money is about shipping more value faster, and we will use any available technique that will let us ship more value faster. TDD is one of those techniques and that's why I use it.

[29:30 Yegor] Okay. I agree. Imagine you're a manager of a group of programmers, and they don't write tests. So how would you motivate them or punish them, or what would you do to change the situation, to make sure that the code starts getting the tests? Because they don't write, I mean they've never done that, they don't want to do that, they don't share your values for example, but you have to somehow change this situation. What would you do?

[30:00 GeePaw] How do you get them to learn CSS?

[30:09 Yegor] Uhm… They just have to learn, otherwise their page doesn't look good.

[30:12 GeePaw] Huh! So…[laughing]

[30:16 Yegor] [laughing] I believe.

[30:18 GeePaw] How do we get them to learn where to put the semicolons? we got them to learn that because that is the job.

[30:25 Yegor] Yeah, it's not gonna compile without the semicolon, but without unit test, they can perfectly implement the feature and return back the pull request to you, which will have the implementation of the feature, a number of classes, new classes they just wrote and zero unit tests. And they will say: “Look, my code works, and you are the manager, you're the tech lead, you're the architect, so now it's your call”. What do you do?

[30:44 GeePaw] I say “Okay, cool, let's see the tests” and they will say “We don't have any tests. Mike, so you're saying..” [laughing] “..It works.”

[30:57 Yegor] Uh-huh. Yeah, and he will say “Of course on my computer, come over I'll show you”

[31:00 GeePaw] [laughing] Exactly!

[31:01 Yegor] “...let me run it for you, you will see, it works, look”

[31:05 GeePaw] Say “I don't have time for that, I work for living too, you know, I don't have time to follow you around and watch your screen”. And furthermore, a far more important leaving that question is this question: “It works on your screen, does it work on the production? It works right now, is it gonna work two months from now?” A lot of developers think of software as something that gets done. The software's done. And now that it's done, since it runs, we will never change it. That's a joke. The day that we stop changing the code that we write is the day that we put software away. We pull the plug on this application and we no longer support it and run it. That's the day we stop changing it. So we're in continuous state, the job of being the developer is developing, is not “doneing”, it's the daily changing of code. And as soon as I introduce change into that situation with any kinda complex logic, when I say complex I don't mean rocket science. I mean two nested IFs. That is when the microtests pay back. Now, am I gonna be able to convince everybody of this on the planet? No, because… and I'll tell you what, because arguments are arguments, right? Listen, I'm a professional talker, I'm good at talk and I can make anything sound good. You want some fried okra - oh, it's really good, yeah girl, you're gonna love fried okra! [laughing] Okay? And the world is full of people who talk really well. As a coach, I do a little bit of talking, no question that, but really my big mission as a coach is actually to get it under your fingertips at the keyboard. It is to get you to actually have the experience. Because here's a thing: once you actually experience it - eh, all my words are nothing, pish-pish - you'll be like “Haha, that's really cool, I do this much-much faster. I found 13 bugs in this thing I thought I was done with. And I know that nobody will be able to change this file from here on out, and break our application without first breaking our microtests. And that's the real beauty of this system. Because we are in a perpetual state of change, that's all we do is change code for a living.

[33:51 Yegor] Uh-huh. You know what we've done a few times in our projects is we had tools to control code coverage. You definitely know what it is. And we were telling new programmers who were coming the project, we were telling them that in our project the coverage threshold is 60%, so when you implement something, you have to return back your pull request with no matter what changes you do, but you technically cannot drop the coverage below 60%, because in that case our continuous integration, continuous delivery system will just reject your change, it will not be merged.

[34:28 GeePaw] Right, same as if it didn't compile.

[34:30 Yegor] For example, yeah, exactly. So what do you think about this approach?

[34:34 GeePaw] So, two questions. One is the question of number, what number should that number be.

[34:43 Yegor] Just arbitrary - fifty or sixty percent.

[34:44 GeePaw] Right, and another one is... another very serious one is the question of… how do I put it, well… if my code that I just am adding has branches in it, I know with certainty that I will develop that code faster if I use those tests. So I don't actually myself need a standard, right, I don't need a rule. And it's just... that's what programming is, it's going as fast as you can, and making changes to code. So I wouldn't need that rule. Going back to number, you know, I hear a lot of numbers, though I think you already understand this, and probably your team did too. You know, the number, eh, it's just a number, and it's an easily gained number, right?

[35:42 Yegor] Yeah. Uh-huh.

[35:43 GeePaw] I can easily generate coverage with tests that actually don't test much of anything. So and yet the spirit of all we are talking about which is to say the code that goes into our code base that has to be our best code. That spirit is the spirit I love and value greatly. I work in shops that have rules ranging from 60 to 90, I'm actually… I've just come away from a shop, I worked there for about 6 weeks with a very large code base in Pearl and their standard number is 70, right? And we have this expression, I don't know if you're familiar with this English expression, it's “honored in the breach”.

[36:28 Yegor] No, I've never heard it.

[36:29 GeePaw] What it means is “well that's a rule we never pay attention to our user following anyway”.

[36:35 Yegor] Okay. [laughing]

[36:36 GeePaw] We only honor it by breaking it. That's the only way we honor that rule, we break it all the time. And there was a situation in this shop. Programmers felt that the way that they were working was such that… It was virtually impossible to achieve that number. It was impossible. And they were right. They were right, in a way they were working they would never have hit that number in a million years. And what we had to do, we showed them... I simultaneously actually taught them how to get better coverage, that was actually the correct coverage, the coverage we needed. And at the same time I gave them permission to blow that number away, forget that number. And in order to do that of course there was a lot of practical hands-on in the code. If we change the code this way, you'll be able to right that test in 5 minutes and get perfect coverage of that complex piece of logic. If we leave the code the way it is, you'll never be able to test that in a million years at any kind of speed that would make you faster. You know, it would double, or triple, or quadruple the amount of time you spend adding a new function.

[37:57 Yegor] Uh-huh. So it seems that you're saying that it's more about the question of motivation instead of punishment, so instead of rejecting the code and saying that “You just broke our rule, so go back do your homework”, instead you're just trusting people and letting them decide what is best for this particular case, right?

[38:14 GeePaw] Yeah, in our shop we have a culture, and the culture has certain expectations: you don't come to work just wearing your underwear, you... [laughing] That's a very important rule, it's not written down anywhere. Well then how come everybody doesn't just come and wear underwear all the time? The reason is that's not how we do things here. And the same thing is true of most of the TDD practices. I don't find that making the rules is particular, I mean it can be used for doing transition, but ultimately it isn't about the rules, it's about us building the culture, in which this is how we live. There are rules or conventions, that are more common in terms of coding standard than the no-underwear rule. But like for instance… oh, what's an example… if I see somebody passing around more than 3 arguments to a method, I'm gonna say to them: “Hey, yo, what are you doing? You got 9 arguments here, this is a smell, this is a problem”. And I'm gonna say that not as a boss, or as a rule maker, I'm gonna say that as a guy sitting next to you who's gonna have to work with that code tomorrow. And we build culture that way. Without any rules at all, we just build it cause we're just humans, that's what humans do.

[39:49 Yegor] I think you believe in code ownership?

[39:53 GeePaw] I believe in… Well I believe in collective ownership.

[39:59 Yegor] So they have to feel like owners of code, right? So they want to see the code good, they want to just write something and walk away and never touch it again, right?

[40:07 GeePaw] Sure. Sure. And not because they're.. yes. But now with a moralistic overtone rather simply recognize the reality of the business. The reality of the business is that there is no walking away. You don't get to walk away unless you're walking away from the organisation.

[40:23 Yegor] But you know what? The statistics tell us and there's recent research done by Stack Overflow, for example, they say that programmers change their jobs approximately every year, so it means that this code ownership will not last for longer, for too long, it will be just 1 year, so it means that next year I will join some company which already has a code base. And when I join it, I realize, perfectly realize that I will stay with this code base for approximately 12 months. So I don't really attach myself to the code base, I'm kind of more like this cowboy mode, you know, I just write something, you kind of pay me for it, you appreciate my contribution, but eventually and quite soon, I will just walk away. So, you see the contradiction?

[41:07 GeePaw] Absolutely I do. It's a very perverse market, isn't it? You know Bob Martin, his back-of-the-envelope version of the development of software programming has made it pretty clear that, you know, the doubling rate for the number of programmers in the world for the last 35 years is just 5 years. Which means at any given time half of all the developers in the world have less than 5 years experience in the field. I'm an old man, I've been a computer geek since I was 20, so I've been a computer geek for 38 years, which makes me something like 0,7%. Hey, I finally made it to the one-percenters! I wish I were in the one-percenters economically, I'm not. But I am in the one-percenters geekfully. Because...

[42:04 Yegor] According to my point, you can not judge everybody else by yourself because you're an exception more like, you're not like just a… you know, you're not like everybody else.

[42:12 GeePaw] Insatiable demand for software has created a lot of very strange aspects, let's mark it, and one of them is job jumping. Now, I'm not a job jumper, because my job just doesn't work that way. I never, I never, not for the last 20 years have I stayed with the same organisation on a full-time basis longer that a couple months.

[42:41 Yegor] You see? [laughing]

[42:43 GeePaw] But that's because I'm a coach, and I'm not a programmer, right? I mean I am a programmer, obviously I'm a geek, but my job requires me to move from place to place, from team to team, from code base to code base. So what if we ultimately come down, it is not my sense of responsibility to the company, it is my desire to add more value faster. Because when I add more value faster, I get more love from my colleagues, I get more money from my organisation. And I know that's a pretty mercenary way to think of it, but so is job jumping every year, and after all you know, there's a reason why people change jobs every year. They change jobs every year because they have no loyalty to their organisation because their organisation has no loyalty to them. And you know without that mutual loyalty, we're stuck in that mercenary situation. As a mercenary, what I wanna do is to get in, get the job done as quickly as possible and get on to the next job. When I say job, really I mean task. Get in, get this task done as quickly as possible and move on the next task. So I wanna be really careful to say that there's zero for me, there are zero moral overtones here. I am not expecting that if your TDD or you must have some sense of responsibility that's higher than anybody else's. Personally I think that is crap. I have no higher responsibility, of course, no, I'm a geek, I love to create code, if I didn't, I wouldn't be in this business. But that's between me and the code, that has nothing to do about the people I work for. The people I work for want all sorts of things I don't actually - by a long range - very often don't approve of. But if you want it to get done faster, then the way to make the code faster is to make that code in a certain way. And nobody hesitates or poses when we're talk about the difference between using a line editor to write HTML versus using a tool that actually shows you wysiwyg, what you see is what you get, results as you're typing in your HTML, in your CSS. Nobody argues about that because it is obviously faster. But there are other techniques that are also faster. Some of them are less obvious, some of them are more obvious. People get on these techniques not because of some moral value that they hold about responsibility for code ownership, they get on these techniques because it makes them faster.

[45:32 Yegor] Yeah, exactly, but very few people right now realize that it makes it faster. That's my point. So, in this aggressive market when everybody… we know, this is reality. Of course, you don't like it, I don't like it as well, but people change jobs, they're job hoppers as you said. So, this is aggressive market. And we know that people will come and go, and can we really trust their internal desire to write tests in a right way, or we need some punishment flash control mechanisms, no matter how bad it sounds, but maybe we need to somehow force them to write tests to make sure they do that, instead of just relying on their, you know, good will.

[46:11 GeePaw] Well, so, so, again, I don't actually hold a moralistic view point about whether we punish or reward, right? For me that's not about morality, that's about effectiveness. The question is does it work. If it works, and you get new hires, do it. If it doesn't work, and you don't get new hires, don't do it. And the problem with most of these control schemes is that they're not very effective. And they actually slow down your more talented people, while not speeding up your less talented people. So, anyway, I certainly understand the contradiction, right? And how hard it is to make a judgment about what level of culture do I provide, what level of structure do I provide, what set of rules do I provide. Those are really complicated problems, and I don't pass judgment on anybody who's trying to come up with this scheme. I'm just saying that we have a tendency to believe that only one scheme works, but there are lots of organisations, that write successful software, they don't have anything by way of rules, except what the team imposes on itself.

[47:31 Yegor] Uh-huh. Let me give you an example. A practical one, which happened to me as well a few years ago. We had a project which was a product actually, which was on the market for like 5 years or so, so it was a pretty big code base and absolutely zero tests. So it was… It's quite typical situation: it's on the market, it works, people use it, there's a huge traffic, but zero tests. And we started to introduce this culture of tests. We started to say, I was the architect, and I was saying “Hey, we need to write tests, let's stop we were doing before, and everytime we change something in the code base, we need to bring in the tests as well”. And very soon a few programmers came to me, and we sat together, and they said “How about we spend some time, like a month, to cover the code we have now with tests? Before we can actually start doing this TDD, and start, you know, introducing.. and start adding tests with every pull request we need to do some work and prepare our code base for that new mentality. So let's just spend the whole month of doing nothing, no features, no bug fixes, nothing, just writing tests, just covering the code base with tests.” And we did that. What do you think of this approach? Is it a good move or...

[48:49 GeePaw] So, a month is right there in a range of “might be a good move, might not be”. Anything longer than a month - I would say “Hell no”, right? We're on this for money, we make money by shipping more value, if I am doing anything that pauses production, then I'm not adding more value. Now, that doesn't mean I can never invest in the future, but it does mean that when you talk about me not adding new value for a month, you better be sure that in the end of that month I'm gonna be significantly faster. Now, that does not mean that I won't spend a few days here and a few days there. You know, adding testing capability where there was no testing capability before, in fact I do that all the time. One of the things that happens when you get to be an old TDD-er like me is you begin to get better and better at incremental and iterative development, where you don't… Well, the code I write is never done. I am constantly making small changes inside my codebase. And the more you get good of that, the more you start seeing ways in which you can take just these 87 lines, no more than that. Take them out of this untestable situation, put them in this testable situation, and still finish that feature faster than the guy sitting next to you who's trying to run and work with the code in an untestable situation. I know that that seems strange, but it's true, right? Um, we get better, people get better with doing things and if you get better at learning how to make change in small steps, then you don't have to pause production. You can make those changes even while you produce code. Trade off, well, I think a month is the longest I would even let a team not ship.

[50:59 Yegor] Uh-huh. Yeah, it was a month. I remembered exactly that number, it was a month. And the team was quite big, like 15 people. So it was like 15 people sitting there doing nothing, just writing tests.

[51:12 GeePaw] So, tell me, did it work? I mean, did you feel good, when you got done?

[51:17 Yegor] Yeah, well, the only thing we definitely achieved is that we trained people to write tests.

[51:20 GeePaw] Right.

[51:21 Yegor] Because before, you know, that's my understanding that people, like you said actually, people don't write tests not because testing is bad, but because they don't know how. So we need to train them, to give them the instruments, like with the new tools for making HTML, let me give you an example. Of course if you don't know how to use that tool, you're gonna use the plain text editor. When you learn the tools, you become more, you know, professional with the tool, then you have a choice at least, you can use it. The same for testing, it's my experience, so when people are like fresh, they look at these TDD books, they read them, they listen to the seminars, and then they say: “Okay, that sounds good, let me get back to work” and they do that. They just don't know how, they don't have the experience, so that was really good for us and a very good opportunity to like buy time and use that time to train people. I remember the problem with actually buying that time, we had a long discussion for a few months with the management, because like you said, it's a pause on production development, on delivery. So we stopped the whole work, so we actually got a go-ahead from the higher level of the organisation, like the CTO, actually approved that and said: “Okay, you guys have this month of work, I will protect you from all other parts of organisation, and let you do that.” So we got the training, that's my experience in that.

[52:37 GeePaw] So that is… That sounds to me like a tremendous win, actually. Once again, right, we're confronting the fact that the demand for the services is insatiable, and you know this idea that we're doubling every five years, that indicates you just how much these people want software, they want it so bad. And it just creates this marker where.. Well I don't what your experience is but most of the teams that I visit are 4 of people who don't really know how to program very well. And I don't mean it in that nasty way, it's not their fault, they didn't get any training, they don't get any support, they learn on their job, and it's like you go in the army and on the first day they send you out and they show you which.. you know, “This is the end of the stick you point at the bad guys, now go over that wall and kill some bad guys.” And it's like “Wow, that doesn't work very well”.But the demand is so high that it works well enough that we keep doing it, we keep not building the skill sets and the cultures that we need to actually be able to ship more value with fewer people in shorter time. So it's awesome that your team did that, I think that's great, and a thing I would say to everybody who's listening here, well, really two things. Thing number one is if it does not actually work, don't do it. It has to actually work. It has just not to work on paper. It has to actually work. And if it doesn't actually work, don't do it. That's the first thing. And the second thing is you cannot ignore the need to teach your people how to work this way. This is not something that you can pick up by watching a single episode of Joe Rainsberger's TDD training or one of my videos. It doesn't come in a video, it doesn't come in 5 minutes, it isn't something that you can learn over lunch time and then apply when you get back from lunch. It takes effort. And as long as companies refuse to support us in building our skillset, they're not gonna get more value. They're just not. So it's really, it's great story that you told me, because it sounds like you're able to convince somebody important enough, somebody with enough weight to say... actually these guys need this and I'm gonna give it to them.

[55:25 Yegor] Yeah, it was like that. What do you think about… well you said that computers will not write codes for us ever, but, you know, there are so many tools which actually write unit tests for us.

[55:35 GeePaw] Yeah.

[55:36 Yegor] So you just give it the class, you give it a method of a class and it just generates you a whole lot of tests. What do you think about this approach?

[55:47 GeePaw] Back in the day, there was a tool called Yacc. Yet another compiler-compiler. And Yacc would take an LALR grammar for programming and it would turn that grammar into the actual code. That would implement that grammar for you. And then you would go in and flash out that code. So it's sort of, as kind of parser for programming languages. And everything was brilliant as long as... you'd never actually had to touch your code to change it in any way. Because computers suck at writing code. Because the hard part in writing code isn't the part where you get the computer to do the thing, a hard part of writing code is a part where you get the code in such a fashion that you or I, or anyone else in our team can come along and maintain, and develop, and enhance that code as we go. That's the hard part. And that's a human thing, not a computer thing. I don't trust those apps and I don't use them. Most of tests they write are slow, most of them are difficult to understand what they're doing, they tend to have very long setups, which make it very hard to see what's going on. Now, you know, I don't know if this has ever happened to you yet, but I've been wrong. And I may yet be wrong. Somebody may in fact be able to show me someday, a thing that can do that automatedly better than I can do it as a human. So I could be wrong, I will say this, I'm not wrong about to_date. Today they have not solved that problem, no matter how good their website looks, they have not solved that problem.

[57:45 Yegor] Uh-huh. Okay, and now comes my final philosophical question.

[57:53 GeePaw] Cool.

[57:54 Yegor] When the code breaks in the production, when the products breaks, when we lose money, when we lose customers, when something happens, we come back and realize that it's because of the bug in the code. That something doesn't work or something is broken here, and then the question is: do we blame the programmer for that, because it's obviously a mistake of a programmer who didn't write the tests, or who didn't test it properly, I mean who didn't create the automated tests. Or do we blame the tester who missed that thing on the way to go. Or who do we blame, or we don't blame anybody?

[58:27 GeePaw] So, in general, I don't blame anybody and it's again, it's because of the perverse market. I can't blame you for writing a non-tested line of code. When nobody's ever shown you how to do this, right?

[58:41 Yegor] Uh-huh.

[58:43 GeePaw] It would be like, you know, there's a reason why you have to go to school in order to learn how to build bridges. Building bridges is actually rather difficult. And it takes practice, and you have to do it in apprenticeship, and you have to spend time in a field with guys who are building bridges, to learn how to build bridges. And we don't do that very well in our industry. And I'm not talking here about the certification or college, I am talking about teaching, we don't teach, we don't teach our developers how to be good. And as a result---when they're not good, what are you going to do, are you going to yell at them? “Oh, you're not good because you never did this thing that I never taught you how to do.” Well ain't that right? [laughing] If you want me to do that, you're gonna have to teach me how to do it, cause people are not born knowing how to write tests. So...

[59:38 Yegor] Is it the fault in the programmer, when something breaks in the production?

[59:41 GeePaw] No, in general, I take the sort of modern systems approach. Virtually, all the problems that we encounter, not all, but most of problems that we encounter in our systems are problems with the systems, there are not problems with the people.

[1:00:00 Yegor] That's a good one, huh.

[1:00:04 GeePaw] Most of them, you know, people forget this, because we all get involved in our attitudes about the world. You know what, in the most of times people want to do well. They would like to do the right thing, they would like to succeed, they would like to win, they would like to be stronger, and better, and faster. All we have to do is cash in on that. All we have to do is take advantage of their natural desire to do that. And then we'll get better.

[1:00:31 Yegor] Sounds awesome, to be honest. [laughing]

[1:00:33 GeePaw] Haha!

[1:00:34 Yegor] Okay, I like it, thanks for… I think we're running out of time, so thank you very much for joining us and being with me today. Uh… that's it?

[1:00:44 GeePaw] Okay, I absolutely enjoyed and I hope you downstream had a good time and you can always find me, I'm GeePaw Hill, it's G-e-e-P-a-w-H-i-l-l. That's my hand-on Twitter, that's my e-mail address: geepawhill@geepawhill.org If you have questions or comments, that come from the podcast, or from any other material, don't hesitate to reach out to me.

[1:01:11 Yegor] Thanks a lot.

[1:01:12 GeePaw] Right, thanks man.

[1:01:12 Yegor] Bye-bye.

[1:01:13 GeePaw] Bye-bye.
