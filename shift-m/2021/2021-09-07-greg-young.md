---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Shift-M/49"
date: 2021-09-07 12:00:00
place: Moscow, Russia
permalink: /shift-m/2021/49.html
description: |
  Greg Young is the author of CQRS design pattern,
  a software architect, and a very well known speaker.
keywords:
  - podcast
  - project management podcast
  - management podcast
  - podcast software management
  - podcast programming
nospell: true
image: /images/andreea/podcast.png
---

<iframe width="100%" height="450" scrolling="no" frameborder="no" allow="autoplay" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/1121396074&color=%23ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true&visual=true"></iframe><div style="font-size: 10px; color: #cccccc;line-break: anywhere;word-break: normal;overflow: hidden;white-space: nowrap;text-overflow: ellipsis; font-family: Interstate,Lucida Grande,Lucida Sans Unicode,Lucida Sans,Garuda,Verdana,Tahoma,sans-serif;font-weight: 100;"><a href="https://soundcloud.com/yegor256" title="@yegor256" target="_blank" style="color: #cccccc; text-decoration: none;">@yegor256</a> · <a href="https://soundcloud.com/yegor256/shift-m49-greg-young-about-software-design" title="Shift-M/49: Greg Young about Software Design" target="_blank" style="color: #cccccc; text-decoration: none;">Shift-M/49: Greg Young about Software Design</a></div>

[Greg Young](https://twitter.com/gregyoung) was our special guest.

Video is [here](https://www.youtube.com/watch?v=JER03qMCmIk).

## Transcript

[00.00.00] **Yegor**: Hi everybody. This is the next episode of Shift-M podcast, and we have a special guest Greg Young with us today. He is, in my opinion, one of the best software architects uh right now in the world because he's not only the author of quite interesting concept of software architecture, but also as far as I understand the person who writes code quite actively every day so I would love to talk to him today about writing code and managing other people writing code, and then software architecture in general. So, Greg could you, please say a few words about yourself. What do you do right now would you work on?

[00.00.35] **Greg**: Well, let's see this morning, I was actually working on finishing something I started a couple years ago and just had kind of left off. So, it's a client for event store written in C. The cool thing about it being in C is that. Obviously, you can use it from pretty much anywhere. 

[00.00.59] **Yegor**: So, you actually code in C right now?

[00.01.02] **Greg**: I've coded in C regularly for coming up on 20 years

[00.01.05] **Yegor**: Is it C++

[00.00.00] **Greg**: No, straight C

[00.01.10] **Yegor**: Why not C++? I'm just trolling a little bit, but still

[00.01.17] **Greg**: Well, one, when I write C++, I have a tendency of writing C and C++. I've just never gotten that far into C++. Two, for me the halving of a c client is actually much more valuable than a C++ client, because it can be used in essentially anything. What if I were to have a 68040. Do you think I could compile my c code down for 68040 and get it working what about my C++ code? Oh, well, maybe let's talk about what compilers we might be looking at

[00.02.02] **Yegor**: Right

[00.02.04] **Greg**: But it the whole reason I've been playing with the C client and it's not this isn't any serious work. This is just, you know, it's me playing around has been that it would be one client, that can be used from essentially anywhere. 

[00.02.25] **Yegor**: And, you know, we jumped, we decided to do this talk this interview after I met your tweet out of many other tweets you make. But this one got me very interesting and let me actually quote it well, you're saying there that you are not happy with people more and more people saying that they are CTOs chief technical officers, but they don't code, and you don't find this trend, you find this trend scary, so why it's scary what's wrong with that?

[00.02.50] **Greg**: Well, I I've worked as a consultant for many years, and I've been to many organizations where I go and talk to a chief technology officer, and well they literally don't know how to code and it's very very difficult to be in such a position without having understanding of code. So we are going to be telling people to do things and we are setting direction, but we are incapable of looking at the work, hat's being produced, we're incapable of knowing the quality of the work that's being produced

[00.03.33] **Yegor**: It's everywhere. I mean I've never met in my life. I've never met anyone in the position of the CTO who would actually write code, because they know how to code some of them, but they don't do it every day. They've done it long time ago, maybe, when there were programmers, but when they are CTO, they don't even think about that. 

[00.03.53] **Greg**: So, I think there's a happy mix where you end up with a CTO, who's actively looking through code, and who occasionally sends pull requests, but isn't necessarily spending you know six hours a day actively writing code, but they should at least have some basis in writing code, and it's not that they wrote code 20 years ago. It's they, they still know how to actively write code. Being a CTO and not getting into the code of your teams is actually quite difficult. I mean what are you basing things off, if you're not in that code are you just going off of what they say?

[00.04.55] **Yegor**: Yeah, that's true. You know what they say, because I have a few friends, a few people who I know quite close who are CTO, and when I ask them, this question do you really code? They say we do more high-level things because coding is something other people can do. That's the very typical answer they give

[00.05.11] **Greg**: And I'm not suggesting that CTO should be coding. Six hours a day, it's more seeing a pull request from a CTO should be a fairly normal thing. Even if it's not something important, it's you know, they're just looking through some code, and well they saw this function, and they wanted to refactor it. So, they sent a pull request for it, because it came out a little bit nicer after refactoring. 

[00.05.40] **Yegor**: So, they have to look at the code. They have to once upon a time go to the repository check what's going on there, so they have it has to be in their agenda their everyday routine works not just attending meetings, right, not just talking to people, but actually opening the repository going through the code. 

[00.05.57] **Greg**: And if you if you're not doing that then what are you basing everything on? I don't know I'm not at all suggesting that you know a CTO should be coding 30 hours a week or, but they should at least have familiarity with the code base. 

[00.06.22] **Yegor**: And do you think in general coding is an art, something which is creative or it's more like a manufacturing process?
[00.06.31] **Greg**: I would definitely have to go with art on that one there are some pieces of code that you will come into that there's lots of well-known ways of handling it. And you're basically just going to be following the same pattern that you've used 50 times before, but once we start looking at systems in general. It doesn't really fall down that because you start getting into like okay, so we're going to do microservices. Okay, how are those microservices going to talk to each other what are those patterns going to look like where are my boundaries and this suddenly starts getting into much more. 


[00.07.27] **Yegor**: And this is art?


[00.07.30] **Greg**: That is approaching art. I mean you're still following patterns. Am I going to use events or am I going to use direct communications in a request response way. I mean there's patterns that are being applied here, but overall, it's much closer to a form of art than to a mechanical process. 

[00.07.58] **Yegor**: You know, some say that we have 20 million programmers in the world right now. It's hard to believe, that we have 20 million artists to me. 

[00.08.09] **Greg**: Oh, you might be surprised, how many terrible artists there are at home. They come home, and they paint, and you just never hear about them. 


[00.08.23] **Yegor**: Yeah, you make a point good point, and this is about the design patterns you mentioned I was recently discussing the design patterns in general, with a few students, and I found out that some people believe the design patterns are actually good thing. And there are books about that recommending people how to design stuff using the patterns. And at the same time there is a there's another group of authors, who say that design patterns actually make programming more routine. And because of that more we duplicate more code because we do the same over and over again and that leads to the code duplication.


[00.09.04] **Greg**: So, for me, the main benefit of design patterns really has nothing to do with code. For me, the main benefit of a design pattern is I can use some words to describe concept, and you understand me. If I were to say that I think we should use an abstract factory around the creation of this object. You would go, oh, okay, now whether or not we actually end up implementing it in that way is a whole secondary discussion, but just going back and forth between you and I we just talked about something that was relatively complex. And we did it in one sentence, when you start seeing things in code and they happen to be following design patterns. You can kind of normally see it and be like well, I think I know what this is doing without going and looking further into it. But I should still probably look further into it. Just in case.

[00.10.13] **Yegor**: So it's like a vocabulary for us, right?

[00.10.16] **Greg**: Yeah. And if you see a foo singleton, I'm willing to bet that you're going to guess that there's only one instance of it

[00.10.31] **Yegor**: Right, so we need to teach young programmers these design patterns and give them full, you know, full amount of them, because there are many of them not 10 not

[00.10.41] **Greg**: Right. Maybe, maybe it's building up vocabulary of well-known solutions to common problems, where communication is going to happen better between people. Instead of me, having to drop class diagrams of how we're going to do this I can say we're going to follow something similar to this pattern. And everyone goes, oh, okay


[00.11.06] **Yegor**: What about these people saying that patterns lead to duplication? Do you understand what they mean by that?


[00.11.12] **Greg**: Yes, there are some patterns that can lead to duplication


[00.11.22] **Yegor**: Like let's say. Yeah, let's say, there's a single tone. So, you learn about singleton and then you see singleton, here, singleton, there singleton, there, so you make three singletones, and it looks to you as your program. It looks to you easier, because you know singletone. So, you put it in all the places. But at the same time, you over and over re-implement uh the same concept, which, probably, could be replaced by something else and extract it to someone place. And then, instead of having three single tones, you were going to have one place with something


[00.11.52] **Greg**: We're getting we're getting into one of my favorite topics, now which is code duplication. And the reason it's one of my favorite topics. I have a rather controversial view on it I like code duplication. So, one of the things that I hate is coming into a code base where everything is connected to everything. And then you have to make a change to this base thing, and you realize it's going to affect 3428 other places. And you're like holy crap. What is going to happen if I do this, and I I've argued online before that one of the things we should be looking at more is to try denormalizing our code, to reduce dependencies. And I know that that's completely in the face of what everybody actually recommends, which is that we normalize our code, but there's some benefits to denormalizing your code as well. Have you ever gone and worked? On, let's say, a thousand-line self-contained piece of code. 


[00.13.07] **Yegor**: What's self-contained?


[00.13.08] **Greg**: Self-contained? No dependencies on anything, it's just a thousand lines of code top to bottom and it's beautiful because you can make it do whatever you want and you can go change anything that you want


[00.13.24] **Yegor**: Right, so, well, this is the library's framework, so you think they make code less understandable. 


[00.13.32] **Greg**: They absolutely do, how many times have you had a bug in your framework?


[00.13.39] **Yegor**: Yeah, many times


[00.13.41] **Greg**: And then it or something that was non-intuitive or and you end up in the weeds for eight hours, trying to figure out how to get your framework to do this, when if you just had code in front of you it'd be like this is 10 minutes



[00.14.00] **Yegor**: Right



[00.14.01] **Greg**: And I'm not saying that one way is right and the other is wrong. I'm saying that we've been over optimizing to one side, and that's the normalization side.



[00.14.12] **Yegor**: So, denormalization is like looking at the library and saying: okay, I don't need to have the library. I just need this piece of functionality from the library. So, I take it from the library extracted, put it into my code, use it, maybe modify it a little bit. But now I have it inside my code, and I know what it does. And this is the denormalization


[00.14.32] **Greg**: Why not?


[00.14.36] **Yegor**: It's interesting never thought about that


[00.14.38] **Greg**: And this doesn't apply for all code, obviously. But it's a relatively common experience to run into where it's like no, I'm just gonna copy and paste this code out of that into my code and move forward. And now I have no dependency on what anyone does to that code in the future. I have no dependency on that library. That's my code. 


[00.15.11] **Yegor**: Maybe we can have it in the computers, like some plugins some AI, maybe which can suggest us to do that, maybe the AI can only computer, whatever can look at our code and say you're overusing the library, because you're you depend on a huge library where you need basically just one function out of it. So how about you take it from there, put it here and then your code becomes more readable?


[00.15.32] **Greg**: Absolutely, and there's another side of this which a lot of people don't think about which is security. So, when I have a dependency on that whole library, I also have dependency on all of its vulnerabilities. Whereas when I took the 100 lines of code out of the 50 000, I now have dependency on those 100 lines of code and it I want to be very clear. I should always do this it's well how much that stuff am I actually using, and you'd be amazed how often you take a dependency on this massive thing and then you use the equivalent of 100 lines of code out of it


[00.16.22] **Yegor**: Right, that's a good point. So do you really do that in your code like this denormalization or it's just a theory


[00.16.30] **Greg**: Oh, no, no! I've used this kind of denormalization for a very very long time


[00.16.37] **Yegor**: And then your code becomes longer right, it's more readable but longer. Just like you said a 1000 like okay…


[00.16.41] **Greg**: And a big part of why I started doing it was my background at the time. I used to work in embedded systems, in embedded systems. This is completely freaking normal to do. Because we are loading on to a very small device. So, if I can cut 6k off of my image. That's a win we got to the point where we had basically filled our EEPROMs. So now anytime you want to make a change. You had to worry about whether or not it would fit on the EEPROM after you made the change


[00.17.27] **Yegor**: EEPROM? What is that?


[00.17.29] **Greg**: Oh, eeprom is a chip that goes onto the board that you basically have your code on think of it. As like an electronics storage system. Some of them are rewritable, ome of them are not rewritable. It's basically uh. Your code is going on a chip. You don't have disks or anything like that, maybe a good analogy in a PC might be you were writing BIOS. When you're writing bios, you put it on a chip, and it goes on the board. Most embedded I shouldn't say most embedded systems, many embedded systems are EEPROM based


[00.18.23] **Yegor**: And what about unit tests if you believe in unit testing, I don't know, that's probably, my first question to you. Do you believe in unit testing and maybe test-driven development as well?


[00.18.35] **Greg**: So, have you ever seen mighty moose


[00.18.37] **Yegor**: See what?


[00.18.38] **Greg**: mighty moose


[00.18.39] **Yegor**: mighty moose? No


[00.18.43] **Greg**:  mighty moose is a product I created some time ago. It was fine and basically what it would do is it would figure out which unit tests needed to be run, when you change code. So if you change some code, it will figure out that these are the unit tests that could, possibly, be affected, and then run those unit tests. I've been writing unit tests for a very long time and writing tooling on top of it. I am a strong believer in writing unit tests and integration tests. 


[00.19.24] **Yegor**: And you know the difference?


[00.19.25] **Greg**: Absolutely.


[00.19.27] **Yegor**: Can you explain?


[00.19.29] **Greg**: Scope, how many things am I interacting with


[00.19.34] **Yegor**: And if I'm interacting with three things this is the unit test or integration test


[00.19.38] **Greg**: I would need to look at the code in question, because there are some times where I might be calling a method on an object, an internal to that object it then uses another object internally in which case I would say that's that looks more like a unit test, but it's more likely to end up being an integration test a perfect example of the former might be I am calling a method on a customer object and inside of that method it's uh interacting with a name value object and with an address value object. So, we have three objects there, but that's absolutely a unit test. 


[00.20.24] **Yegor**: So, there is not a clear line between unit testing and the integration testing still, because you mentioned three things I touch and let's say there are three things and I touch a file


[00.20.36] **Greg**: Well, the general line for me is. If we were to look at ddd as an example, so I have unit tests on my aggregate, but inside of my aggregate I might have many objects inside. 


[00.21.00] **Yegor**: Yeah, so when you test it


[00.21.02] **Greg**: Looking as one concept the aggregate if that kind of makes sense?


[00.21.08] **Yegor**: Yes, definitely and now let's try to write the union test for this concept. It's going to be a unit test or integration? 


[00.21.14] **Greg**: That's going to be a unit test. Although I have a much more useful way of putting this. And I've used this definition for many years, which is this fast or is this slow if it's fast then it's a unit test if it's slow, then it's an integration test


[00.21.42] **Yegor**: Again, quite difficult to give a specific definition of slow and fast



[00.21.47] **Greg**: Fast for me as it runs in one or two milliseconds. So, this is more a definition based on use than a definition that is actually useful because you could write something that touches 500 objects and it can be fast. What I'm looking for there is more my unit tests. I intend to be running on a very regular basis. Hell with mighty moose, it was every time you saved your code. All your tests were wrong. So, I want that to be fast and that's very important to keep fast. Then I have a bunch of tests which might still be highly valuable, but they're slow. I just don't want them being run every time that I change my code


[00.23.02] **Yegor**: Because your entire test suit is slow right you. That's why you create the system in order to run on this specific test because the full test suit is too slow. 


[00.23.12] **Greg**: Well, and it all comes down to value so my fast test. They run really quickly, and they tell me what things are broken. I basically want to optimize for them to run as fast as possible and to tell me as much stuff as broken as possible. My other tests, hey are more focused on quality. They're focused on I have not made drastic mistakes, that might go forward. If that kind of makes sense?


[00.23.54] **Yegor**: Yeah


[00.23.55] **Greg**: They are not fast. They take a long time to run. Perhaps maybe an hour. What I'm doing is I'm looking between the two of those and I'm trying to optimize for my workflow. If all my tests run in 10 seconds. That's no problem. If my tests take 15 minutes to run, while I'm sitting there actively developing code, I'm not going to run them. 


[00.24.24] **Yegor**: Do you really have tests which go for 15 minutes?


[00.24.26] **Greg**: I have had tests that take days


[00.24.33] **Yegor**: Really, I mean like integration. 


[00.23.35] **Greg**: I was going to say this is more when you start getting into things like what about elections an event store one month. So we have elections that run, how do you test that the election algorithm actually works properly. So, we're gonna need to throw up a couple nodes like fake nodes, and then what we're gonna do is we're gonna throw in randomized failures between them and then we're gonna let it run for a while. And because of the way things works you have timeouts you have all these other things that can occur that we literally had nodes sitting doing elections for days. Another good example of a test that can take days, but I'm going to take days and I turn into months for you. How do you know that the data is actually on disk?


[00.25.44] **Yegor**: After like making a file creating a file or…


[00.25.48] **Greg**: No, it's something like event store you do it right? 


[00.25.51] **Yegor**: Yes


[00.25.52] **Greg**: It comes back to you and says: okay, you're right. You're all good is that data on disk right now? 


[00.26.00] **Yegor**: It's a good question. I would do some things through the operating system and check on the file system and check it. You know like around my software and check what's going on there. 


[00.26.09] **Greg**: That's not good enough, so what you end up needing to do and pretty much every database company has done this at some point is we're going to set up clients, that are doing rights, and they're tracking what's been told to them by the database. And then what we do is we pull the power on that node and plug it back in, when it comes back up, then they verify everything that they've been told is actually correct. 


[00.26.37] **Yegor**: So, you kind of crash this recovery?


[00.26.40] **Greg**: And we and we will do this 10 000 times. 


[00.26.47] **Yegor**: Oh, oh, yeah. Because one time may not guarantee, that the next time we really gonna


[00.26.53] **Greg**: You might, you might have just gotten lucky, and the buffers had just been cleared at right when you pulled power. So, you need to do it time and time and time and time and time again. If you go on the event store website and this might be a fun one to pull up with pictures of it uh just for people listening. There's actually a blog post with pictures of our powerful clusters.



[00.27.19] **Yegor**: Interesting. 


[00.27.20] **Greg**: But I'm not even sure, if I would call that an integration test at that point that's more


[00.27.27] **Yegor**: It's more like non-functional properties tests it's like quality-of-service test, because you don't really test the functionality you test like how it is resilient to failures. I don't know something like that, right? 


[00.27.39] **Greg**: Well and what's fun with it is you're not just testing. The software big part is you're also testing the hardware. 


[00.27.47] **Yegor**: That's right, the whole system, actually, the file system operating system your software. How they get together, but it is important I totally get it, maybe even more important than functionality tests


[00.28.00] **Greg**: Well and what's funny is that was literally one of the most important tests we were running. Well, what happens if your database uses data during a power outage. 


[00.28.19] **Yegor**: Yeah, right


[00.28.20] **Greg**: You'd be rather missed about this entire thing. 


[00.28.25] **Yegor**: Yeah, interesting. And but this is more like for system software, right? I mean I totally get the purpose. I'm just thinking how it's applicable to other like most software products people develop right now, because I think most people don't do system development. They do more like on the level of applications right like mobile application. For example, you don't test right. 



[00.28.46] **Greg**: And this this would not work very well on like a random mobile app right um. But this is the same kind of testing. I used to do a lot in the company that I worked in early in my career where we're doing embedded systems. And a big part of that kind of testing is randomized testing. I want to see if I can make it break. The nice thing about this kind of testing is once you've been off running in that environment for a while. Simulating real failures, making sure you come back from them properly etc etc. You have a fairly high level of confidence. When you go to put this thing into production. We forced it to fail 27 000 times, and we were able to recover from it 27 000 times the chances of having one failure in production and it is taking us down, are relatively low


[00.29.44] **Yegor**: Yeah for sure, and how do you control this power on power off. So, you have to connect your software with some power switch, which is programmable


[00.29.52] **Greg**: We actually have these. They sell them so basically what it is it's a little box that sits between the electrical outlet and the computer, and you basically plug it into the electrical outlet. And then you plug the computer into it, and it has a network connection, and you can I've seen varying ones. Some of them are HDP. Some of them are TCP, and you can basically send an http post to it, telling it to turn off power outlet too. Then you can send another http post. To it turn on power outlet 2.


[00.30.30] **Yegor**: Cool, so you made this hardware as well for testing people sell it. 



[00.30.33] **Greg**: No, there're people that sell this out there it. You could also do something uh like an x10 interface? The ones that we picked up we picked up because they support http: which was just kind of nice as opposed to having to deal with x10 or something like that. But there's quite a few of these kinds of tools that exist out there and they're not very expensive. And they have a load of uses outside of what we're discussing. Consider, for instance, if I were going to be running a restaurant and one of the things in my restaurant was, I had a big television-based menu system that was all over the restaurant. Well, if I plugged it in with all of these in order to shut everything off, I could just do it right from the cash register, right? So, when I say close out close out turns off all the tvs. Okay, as opposed to making somebody walk around hitting the power buttons on all of them right and it's especially true at some place like a McDonald's where these screens are often embedded in the wall, and you might not easily be able to do that




[00.32.00] **Yegor**: Got it got it and the next question which I wanted to ask you about test, driven development, so do you believe in that? Do you believe in writing tests before writing code, because many people say that test driven development is sort of dead, so people don't use it so it was a good concept 20 years ago, but no more we actually write codes first? 


[00.32.20] **Gregr**: So I think the main value of tdd does not necessarily come from writing the test first, but there's a massive amount of value in writing the tests. Now, one thing I have found is that especially in younger developers writing the test first actually helps a lot



[00.32.49] **Yegor**: Really? Younger…


[00.32.51] **Greg**: Yes, because they, they don't necessarily have the clear form of what they want to build in their head yet, if that kind of makes sense?


[00.33.00] **Yegor**: Yes, yes


[00.33.05] **Greg**: So, showing from the outside this is how I intend to use this thing, and then moving to the inside to actually make it work actually helps quite a bit. But when you have a solid idea of what that thing inside is already going to look like, you get far less value from writing the test first. You still get the value of having the test over time, although there's better ways of doing that



[00.23.47] **Yegor**: But in general you think tasks are necessary because again there are people who are saying that tests in general uh it's a like flawed idea that it only takes our time and then these tests just go away because the code moves faster than the test so tests cannot catch up. So, we throw them away and then just they're just like burdens staying in the repository. 


[00.34.06] **Greg**: You have to you have to remember I am a fairly big fan of fear-improved languages now with theorem-proof languages, when you go to write a test my compiler is going to tell you that it's going to fail. So, there's literally no value in you, having written that test you should be focused on your contracts that said most of us are not working in those environments today. 


[00.34.36] **Yegor**: Yeah, that's my question. What kind of language are you talking about


[00.34.37] **Greg**: Oh, do you want to be Spec Sharp


[00.34.40] **Yegor**: Okay


[00.34.42] **Greg**: You literally write contracts on something where I would say? For instance, this argument must be greater than or equal to zero and less than the size of the array, that's being passed down and it will be proven that anywhere that calls this will have made sure this is true. 


[00.35.05] **Yegor**: It's like designed by contracts paradigm. 


[00.35.08] **Greg**: It is absolutely designed by contract, but it's designed by contract with fear improver running over. 


[00.35.17] **Yegor**: It's even stronger approach. 


[00.35.18] **Greg**: Well, it's basically that when you write your contracts. I will not allow you to call something that you have not proven that you meet the contract of



[00.35.30] **Yegor**: We don't have this stuff in Java C#. And all those modern languages right Python. 


[00.35.35] **Greg**: No, no, no Spec Sharp. Spec Sharp was and we're talking this. This goes back a decade so Spec Sharp was a version of C# that supported this. And it came with a theorem prover, which was named Boogie. And Boogie would actually go through and theorem. Prove your C# code now interestingly Spec Sharp did not really move forward. It's kind of like went off on a side path, but quite a few things out of the prover and the general idea of what they were doing, did actually come into the language. So, there are things that are not nearly as much, but there are things which are today returned as compiler errors in c sharp which were not previously, and you can do this based on annotations etc. 


[00.35.32] **Yegor**: So, this checker is the checker and zoom. So, this checker runs after I type my code in or while I type my code in?


[00.36.17] **Greg**: So, it can do both so basically, it's just part of the compiler pipeline. So, it's the same as if you're typing code. And if you haven't finished a type of name, it turns red, right? Or if you mistype a type of name, it'll turn red this works in roughly the same way, because it was actually built into the compiler. So, you're basically just getting computers for the things, that aren't meeting your contracts



[00.37.20] **Yegor**: It's powerful, but it seems that if this is not on the market right now or not very popular. It seems that programmers are not very happy about these contracts. They, probably, would like to have more freedom and write whatever they like



[00.37.35] **Greg**: Well, the big problem is different types of code need different levels of formality, so in something like implementing large parts of event store. This would have been very valuable. Implementing an asp.net page for your mom's pet store. It would not be so valuable, and it would probably take you longer to write that little asp.net page using such a thing. And different types of code bugs have very different cost associated with them in a lot of places. Having a bug, it's like okay, we lost three dollars in other places, having a bug is a million-dollar penalty. 


[00.38.55] **Yegor**: And still, this is where people don't use this design by contract to my experience


[00.39.00] **Greg**: You, you see a lot of these types of formal proving occurring in things like I need to build an aircraft control system. 


[00.39.20] **Yegor**: Oh, I know


[00.39.20] **Greg**: Bug here might be rather expensive. 


[00.39.22] **Yegor**: Yeah, I can imagine



[00.39.23] **Greg**: What's been interesting is that they the ideas have been coming out into more general software. Another thing that you'll find here is for instance modeling things as state machines versus modeling them as typical procedural code because I can actually prove a state machine. Have you ever had to do this?



[00.39.54] **Yegor**: No, not in my real life, no other… I just know it exists but ask like any random regular programmer. I don't know any company, they would say no, we don't even know what you're talking about. I know Java I know objects, methods, classes, single tones. 



[00.40.10] **Greg**: Well, I had actually looked at writing a language, which was rather specifically around some messaging concepts in particular dealing with things, like process managers, you would write top-down code and basically you could use join so I need to await on something, or I need to join awaiting multiple things and your top-down code would actually produce a state machine. And the whole reasoning for producing is that state machine is that if I limit your language to what I can produce into that state machine, I can formally verify your code


[00.40.59] **Yegor**: And then after you verify my code. What happens you could erase some exceptions, you're gonna uh your analyzer, gonna complain not let my code go to production. So, what happens?



[00.41.10] **Greg**: I'm going to give you a compile error that this will fail at runtime. 


[00.41.14] **Yegor**: Oh, so it's sort of like a static, another analysis, which is happening all right



[00.41.19] **Greg**: So, I found that you told me this process manager should complete within 15 minutes I found a path, because it's represented as a state machine where it might take 18 minutes, here's the messages, that would take you along that path


[00.41.41] **Yegor**: Right and that will stop programmers from writing the code, which is broken potentially


[00.41.47] **Greg**: Well, you wouldn't be physically possible of compiling, that wouldn't work I mean it should work this way, if it doesn't work that way you, you cannot compile it. 


[00.42.03] **Yegor**: You know how many people I'm at who are saying and believing that static analysis is a bad idea, that preventing people from writing the code, they would like to write it is a bad idea. They're saying like we should let programmers do, whatever they like and then let the see the code in production and the long story after that


[00.42.20] **Greg**: And again this depends on the type of code that we're discussing. There's a huge amount of code that this is completely fine to allow things like process, managers, not so much because when you have a process manager go out to lunch, there's a direct cost associated to that. I would much rather know that my process managers actually terminate and are guaranteed to terminate and are guaranteed to terminate within. A given SLA, than to have to run all the monitoring etc associated with them to be able to track whether or not. We've actually had an issue. 


[00.43.18] **Yegor**: What would you say to a programmer let's say in your team who just joined your team and finds out that you have so many control system in place, which does the checks which you just explained, and the programmer says it's quite annoying because I write the code, I try to push it through to the product. You know to the to the pipeline and I get mistakes. I get errors. I can't complete my tasks. So, it's very annoying for me. I don't like it. 



[00.43.43] **Greg**: I've got a really good statement to have in that conversation. That's probably not going to be a conversation in the office. That's probably going to be conversation after work with a beer and it's going to be so… I want you to stop and think for a minute what happened, what would happen if you didn't get those error messages and you were instead having to deal with that same problem. But it occurred in production. It stopped you from being able to push it, because there was a possible error that could happen in production. If it happened


[00.44.26] **Yegor**: But you understand that this is extra work for programmers to go through all these checks it. 


[00.44.30] **Greg**: It is and you get accustomed to it pretty quickly, but I would much rather have you get a compiler error than for you to have 40 000 separate processes managers, all go out to lunch at the same moment. And now how are you going to correct those 40 000 things that we're running. Are you gonna go edit state variables by hand?



[00.45.04] **Yegor**: So, you would try to convince programmers to,  you would try to encourage them to believe that this is something. They that we all need to have this extra task. There's extra validations



[00.49.18] **Greg**: You know,  I've done this in the past. And what my main thing that I focused on in order to even justify it was what happens when these things do go wrong. And it's oh, my god! This is a nightmare. 


[00.45.38] **Yegor**: And who do you blame in this case the programmer who makes the mistake or the programmer who didn't implement the check or who's at fault when something goes wrong with the production?


[00.45.48] **Greg**: Well, we could also say that maybe it was QA. Maybe it was my worry is not associating blame to somebody. My worry is ensuring. It doesn't happen. I would much rather just have this be impossible to happen even if it you know you're gonna you're gonna have to spend a day or two to kind of learn how this thing with the joint calculus actually works. But then we never have this happen in production. Our risk is gone. And again, t's not the situation where one of these processes goes off the rails that I'm worried about it's when there's 500. One process going off the rails. It's okay, you know what manual intervention we're going to have customer service handle this one that went off the rails and no big deal. Well, there's 500 of them. This is a completely different story. 


[00.45.52] **Yegor**: Yeah, that's true


[00.45.56] **Greg**: But all that we're trying to really prove. Here is that we have this process. This process starts with x. And these are the termination points of these of this process. And all that we're going to try to prove. Is that we reach a termination point not that it's always successful just that we reach a known termination point. We have not gone out to lunch right


[00.47.26] **Yegor**: And don't you think that it's time to blame, not people for the mistakes. We have on production, but programming languages which we have now, because of them we have so many bugs. Because of the design of the languages which in my opinion the design. Okay, in the opinion of some people it's the languages which are super flexible, which allow programmers to make whatever they want. For example, having, I don't know procedure block of code without contracts and so on and so forth. And because of that most programmers don't just use it and code production systems. Just like this uh like you explain. Asp.net.mama page. 


[00.48.07] **Greg**: Okay, so many years ago I used to work as an electrician, and we had an expression back then that is very applicable here, A craftsman never blames his tools. 


[00.48.32] **Yegor**: It's a good one, but still you know, if you're a craftsman then yes, you have an experience of 20 years then, of course you don't blame your tools. But most programmers remember, there are 20 millions of them and most of them are not craftsmen. They are like junior programmers, who don't know how to use java or C++ or C the right way. So they just…



[00.48.52] **Greg**: Now we're at the point of talking about an electrician, who's using a butter knife to take apart a light socket exactly and it's complaining that his butter knife doesn't work very well, it's like well, what you need to do is you need to learn how to use a screwdriver and I'm not trying to take a piss out of them or something like that, but it's a lot of the stuff that we see today is not problems with the tools. That's problems with the people using them. 


[00.49.32] **Yegor**: So, you think there is no room for improvement of the modern programming languages, which we have so you're happy with the languages? 


[00.49.38] **Greg**: Well, I think fear improving is one major one, but I don't think new language features are for the most part going to fix a lot of the issues that people are facing. 


[00.50.00] **Yegor**: Well, if you embed this theorem, proving into modern programming languages, then I believe it will fix a lot of things if compilers



[00.50.08] **Greg**: There's a big problem with that in that, when we're talking about having a junior developer out working in this code, the same junior developer is writing the contracts as is writing the code. 


[00.50.20] **Yegor**: Yeah, that's true. 


[00.50.22] **Greg**: So, the contracts are likely about as valid as that code is



[00.50.31] **Yegor**: So you're saying that the languages we have right now are very easy to use and very easy to make mistakes with, but it's like a trade-off, right?

[00.50.40] **Greg**:  Right. And that that's a good trade-off for some types of code and it's a bad trade-off for other types of code. I can assure you, you would much rather go write an implementation of paxos in a formally proven environment, than trying to write it in JavaScript



[00.51.06] **Yegor**: But very few people do that



[00.51.10] **Greg**: Correct, but there's lots of code that kind of fits this pattern, a lot of domain models. Actually, fit this pattern very well and we're even taught today to do things, to reduce scope inside of domain models, let me give a perfect example value objects. Value objects are immutable correct? 


[00.51.35] **Yegor**: Right



[00.51.36] **Greg**: And all validation of that value object happens within the constructor when you're building it up so now, I can carry this thing around, and I can assume things about it. It's the same type of thing


[00.51.55] **Yegor**: And that's good. 


[00.51.57] **Greg**: I'm limiting the scope of things that could, possibly happen coming off of it what if I could give more information about that value object that the compiler would be able to check



[00.52.10] **Yegor**: Like what. 



[00.52.12] **Greg**: Oh, let's just say that we had a positive money value object. And then you wrote an if statement that was checking if it was negative that then you should go and do these things and the compiler were to tell you, that thing can't be negative



[00.52.32] **Yegor**: Interesting. So, the object will go around the code, bringing constraints together with it, and the compiler will know these constraints? Nice




[00.52.44] **Greg**: Well, and it's not just the object, it's methods themselves have constraints on them. So, I have said that when you called my function, I must be greater than or equal to zero. And I must be less than or equal to the length of this array. So, now if I call something else, that comes forward. 



[00.53.12] **Yegor**: That's nice




[00.53.13] **Greg**: Basically what it ends up doing is it ends up removing these repetitive if statements that are all throughout the code because it pushes that all the way out to the edge. One really cool thing about this and I should say this is both a good thing. And a bad thing is then two years from now I change that, and I say it must be greater than or equal to one. How many places does this affect. My theorem prover comes through and it's like here's 19 000 places that affects. Oh, I might not want to make that change. 




[00.53.57] **Yegor**: Maybe it's time to design a new language for you, you ever thought about that?




[00.53.59] **Greg**: Well, I started working on a new language, but my language was very specific. 




[00.54.05] **Yegor**: And where is it now?



[00.54.10] **Greg**: I'd say it's about half done, but like it has liked a syntax it actually compiles, but I want to change things with it. It's related to those process. Managers I was discussing before in time where you actually have time as an intrinsic part of the language. 



[00.54.42] **Yegor**: Do you think there is room in this world for new languages and I mean popular languages, not something which we make for you know, for like a lab work or for fun, but really mainstream programming languages, which will eventually, maybe, replace Java or C++ . We're done with that we just stick to java and forever. 



[00.55.10] **Greg**: No, I think you've seen some interesting trends, going on the last decade. One of which is people moving a lot more functional



[00.55.21] **Yegor**: Right, and it continues people move and move to functional programming. I know people who wear object-oriented programmers, and now they're functional, and they say, they will never come back. 




[00.55.32] **Greg**: Well, and there's, there's two parts to this as well so one part of it is that people started getting into functional programming. The other part of it is that people's languages, that they were using started becoming more functional: C# is a drastically different language today, than it was 10 years ago or 15 years ago. 




[00.56.02] **Yegor**: Java is also now full of functional things full of these function expressions. 




[00.56.09] **Greg**: The one of the funniest ones was when they introduced link, how often did you see people actually write link statements versus how often you saw people write a bunch of for loops or for each loop, and then ReSharper told them would you like to make this into a link statement. 



[00.56.40] **Yegor**: But people say that functional programming is more difficult to understand for junior programmer. That's why it's only good for somebody who is old enough and mature enough to understand and it's much easier to write procedures and objects and methods to functional is not the mainstream paradigm and will never be that's what I've heard. 



[00.56.57] **Yegor**: I don't believe that statement is true instead what I'm going to propose is that either would be roughly equivalent to learn as your first language, but once you've already learned procedural programming, then learning functional programming is a little bit more difficult. In the same way, that if you started off as a functional programmer, and then you got into imperative code you'd be like. Oh, boy, there's a bunch of stuff, I need to learn here. It's more



[00.57.40] **Yegor**: Where you started where did you start? What's your story?



[00.57.45] **Greg**: You don't want to know my first language. 


[00.57.48] **Yegor**: What is it assembly?



[00.57.49] **Greg**: I was working in two languages when I started one was basic, the other was assembly there. You go and which you can't go wrong with assembly. I mean you'll definitely learn something, if you spend some time to learn assembly. 



[00.58.05] **Yegor**: Yeah, so they scarred you for life, these languages. 



[00.58.09] **Greg**: And, you know, I was posting about this I'm trying to think if it's on twitter or not this was maybe a month or two ago. So, I can even tell you. I'm 90 sure the first computer science book I ever bought. It was mastering turbo assembler. 



[00.58.35] **Yegor**: Yeah, I remember that language Turbo Assembler. 



[00.58.39] **Greg**: Well, but it was it was cool. You could do so much stuff in it. Oh, yeah, you can't do a lot of that stuff today. 




[00.58.48] **Yegor**: People don't learn that stuff now go around and ask modern programmers. They don't have no idea what assemblies they have no idea. What's the architecture of this of the hardware then they know? They don't know what the register inside CPU is. They have no idea. What is the bus inside the inside the computer, so…



[00.59.04] **Greg**: I have a lot of people that sometimes I maybe once a year or so I'll put up on twitter? Oh, I got my books. And so, every time that they're making changes to the Pentium chips you, you can actually order the books from intel about the changes in the processor and basically, it's like it's like documentation at a machine and assembly level explaining to you. How the processors change very few people order them, but they're free. 



[00.59.42] **Yegor**: I didn't know



[00.59.45] **Greg**: They will literally. Send you out these books



[00.59.49] **Yegor**: Cool, I'll try, interesting. So do people know to, do people have to know the architecture of a hardware? What's your opinion or maybe it's for system engineers and we are just



[01.00.00] **Greg**: It depends what kind of code you're writing? If you're writing a business system, no



[01.00.09] **Yegor**: If you would teach students, let's say you have a class of students. They're all you know 20 years old, and you have to teach them computer science or software development software design. Would you tell them about the architecture of the hardware? 



[01.00.19] **Greg**: Most likely not unless we're going to be doing something like working in embedded systems in which case absolutely you need to know this. 



[01.00.32] **Yegor**: Oh, yeah, that's for sure. But if there are like software developers going to design web services and whatever on the web then, no




[01.00.40] **Greg**: There's probably still some knowledge that's needed, but it's drastically less knowledge, it's not something that you're going to run into on a weekly basis, but you might still run into it. So, you should probably know at least some basics about the subject. But you don't need to know in depth now if we're going to talk about a group of Java developers, who are building an algorithmic trading system. I would give a very different answer. This is when you start getting into things like mechanical sympathy. Because well you have to.



[01.01.41] **Yegor**: Right, because Java took away this connection to hardware from us and C and C++ were quite connected. I remember that time when I switched from C from C++ actually to Java and C++ you kind of felt the hardware. You know, there's memory you allocate the memory. You can anymore any moment of time you can write assembly language right next to your C code. But then we move to Java and boom. That was like a completely different world from now on, there's no computer there. It's just uh, just objects, just methods variables. You know so he's a good or bad. That's a big question for me. I still don't know because I see people around me who are like 15 years younger than me. And they have no idea what's going on the computer all they know is like objects frameworks libraries. 




[01.02.30] **Greg**: There's a big benefit to this as well which is I can go and write code on my laptop here and I can move it over to let's say a 68 or 40. If it's written in something like say Java, I can just emulate it here on my web document. It works pretty much the same way as it's going to work on that 6840. And for a vast number of systems. This is completely okay, it's completely okay that I can run it and it's going to run the same as don't get me wrong. It might have some slightly different performance characteristics. It might have slightly different memory characteristics, but we don't care


[01.03.24] **Yegor**: Exactly



[01.03.27] **Greg**: There's a big difference between that and trying to fit something into 32k of memory on an embedded chip. 




[01.03.34] **Yegor**: Oh, yeah, so you're actually you're looking into the future. It seems so you're not being uh depressed about the situation that will lose the connection to the hardware. You think that future is about programmers thinking more on a higher level more conceptually



[01.03.50] **Greg**: In general, yes, and I think we're going to find more and more things coming out to focus on productivity more than anything else, because this is what most developers deal with that's their main issue. It's not about how can I make this web page be able to serve 5 000 requests per second as when right now we cap out of its I need to make these 27 web pages in the next 30 days




[01.04.27] **Yegor**: Right. And this productivity I actually wanted to ask you about this, so many people some people say that productivity is the elusive term. It's like a false objective that we shouldn't aim for productivity. We should even measure productivity, we should let programmers do what they do best, and then whatever comes out of their laboratories. Then this is the result. So, we should never push them to any goals any metrics any measurements. 



[01.04.55] **Greg**: This is going to be completely team and organization based. Some people do well with the whip cracking behind them. Other people, they do worse with a whip, cracking behind them. 




[01.05.17] **Yegor**: What about you?




[01.05.19] **Greg**: Depend what I'm working on



[01.05.32] **Yegor**: So, in some cases actually, you know, measuring productivity for you, may help you move faster


[01.05.39] **Greg**: And in other cases it might make me move slower or slower.


[01.05.41] **Yegor**: There  you go



[01.05.49] **Greg**: The one that you really have to worry about though and I've seen this in organization after organization after organization is where they say that we're going to measure productivity and we're going to use this standardized format to measure all of our productivity and oddly all the team members, then optimize for the measurement of productivity not for the creation of good software. Now, these two things may or may not actually be aligned. It could be that I show up as a very productive developer in your metric, but what I'm being productive as producing a bunch of crap. 



[01.06.30] **Yegor**: Yeah, but if the metrics are designed well, if they are actually preventing this from happening people abusing the system, then it seems like it's possible to measure and programmers will be happy, and their overall result will be bigger because of the matrix



[01.06.52] **Greg**: The only problem is that what you're describing there is something that has yet to be found in anything resembling a generic faction, So, now we, we have all of these different places all creating their own little metric systems. 



[01.07.12] **Yegor**: Yeah, and they're all wrong



[01.07.15] **Greg**: Well and who created the metric is actually a very important question. Do those metrics actually align in any way shape or form with what we actually want? Let me let me just give a really obvious example here so I'm going to make the metric for our organization lines of code per day. So now you end up putting in a thousand lines of code per day, but your code is utter crap. 



[01.07.45] **Yegor**: Yeah, well, it's a lousy metric imagine another metric. How many bugs you fix per day, the bugs reported by clients. 



[01.07.54] **Greg**: Oh, oh, I've seen this one in use. So, what ends up happening is they create bugs. They create bugs, that are very simple to push them out. So, then they can go and fix them



[01.08.10] **Yegor**: See we're too smart. People are smarter than metrics



[01.08.14] **Greg**: And this is why metrics are hard to come up with. There are some metrics, which are very good as an example uptime



[01.08.27] **Yegor**: Right, for example, exactly



[01.08.28] **Greg**: Uptime is something that you can't really cheat on. You're either up or you're not



[01.08.35] **Yegor**: You can also cheat you can remove the features. You can take off the features. The system becomes more stable because it's simpler and then uptime goes up. So, if you if I pay you for the uptime, you as a programmer will be very resistant on introducing new features every time, I come to you with a new idea. You will be always pushing me back, because you know that will hurt the uptime. So that's also a negative side. 



[01.08.59] **Greg**: But that's actually a good pushback, because I told you I valued the uptime. And now you're coming back to me going. No, no, no, no. If I if I start adding all these features, it's most likely going to negatively impact my uptime. This is a good discussion. 



[01.09.22] **Yegor**: Yeah, you're right. So, you think it's good in general for programmers to protect their scope and not let all the possible features get in, right? 



[01.09.35] **Greg**: I think anyone who's ever worked in a production code base. We have all at some point received the most idiotic feature request that you can imagine



[01.09.47] **Yegor**: Yeah, right



[01.09.50] **Greg**: Where it literally, you are left scratching your head going who would actually want that. Like I can't even come up with any reason. Why someone might want this



[01.10.05] **Yegor**: Yeah good point



[01.10.06] **Greg**: Even having talked to the user who does want it. I am still left without words as to why they actually want it. 



[01.10.19] **Yegor**: Well, I agree here, I definitely agree with you. I have one last question for you, because we're running over time already. What about your book, because I actually asked a few people before starting this interview, a few my followers. What kind of question I should ask you and two people said ask him about the book, because they said the book was this 90 of your books is very interesting. So, when are you planning to finish it?




[01.10.40] **Greg**: Oh, so the versioning book? 



[01.10.42] **Yegor**: Yes, that's right. 




[01.10.44] **Greg**: The versioning book is essentially done um the work. That needs to be done. I I've talked to some varying places about it is basically moving it to a physical form. It's layout work. It's like I even have all the art done and the art is actually really cool. It's not currently up in the lean PUB version when I was out in Gran Canaria, I hired a street artist



[01.11.08] **Yegor**: Cool




[01.11.11] **Greg**: And when I say street art, so I don't mean like a graffiti artist. I mean like one of the guys that, when you come down and you're on holiday with your wife. They'll be like. Hey, do you want me to draw a picture like a caricature of you and your wife. I gave him all the images. And he drew like caricatures out of all the images. 



[01.11.33] **Yegor**: How much did you pee?



[01.11.34] **Grag**: Oh, with a couple hundred bucks 




[01.11.35] **Yegor**: Oh, cool! 



[01.11.40] **Greg**: This isn't a huge piece of work for him. I think there was something like 20 images for him to do, and most of them are relatively simple, but he drew them up nicely like hand drawn. 



[01.11.55] **Yegor**: And when where are you going to publish it's going to be lean pub, as well electronic book or you're going to go for publisher



[01.12.00] **Greg**: I've talked to the couple publishers and it's a book. That's in a weird market from a publisher perspective. Well, it it's weird, because it's not really a book that you would ever want to put onto a shelf that say barnes and noble like it's just such a niche topic. 




[01.12.28] **Yegor**: They told you that




[01.12.32] **Greg**: Well, pretty much I mean it's not like if I were. When I started writing another book, which was about event sourcing in general that book they'd be like yeah sure like we can throw that out on the on the shelf at the bookstore we can throw that up on amazon people will buy it no problem. Just very niche like who's your target audience on that that would be walking through barnes and noble. 



[01.13.07] **Yegor**: Yeah, see it's all about money. They care about mass market. So, they want to sell like thousands of copies tomorrow



[01.13.20] **Greg**: Right, and I've gone through, I've done varying print layouts things like that what's most likely going to end up happening. I found a service that basically do all the layout work with them. And then you can tell them. Okay, I want to print up 300 of these. And then they offer that they will drop ship them to people. If that kind of makes sense?



[01.13.47] **Yegor**: Yeah, it does from their point of view. 



[01.13.53] **Greg**: It's just much easier, dealing with that, than trying to deal with the book companies. And everything that's going to be involved with it


[01.14.02] **Yegor**: Right


[01.14.05] **Greg**: And, I I'm not faulting the book companies in any way. I mean I understand their business model, and where there's not really alignment between the two. It's not really their specialty. 



[01.14.26] **Yegor**: How much time did you spend on the book to write it



[01.14.32] **Greg**: Oh, that's a good question! 



[01.14.35] **Yegor**: Well, let's talk about calendar time first and then your work hours




[01.14.41] **Greg**: You'd be surprised, how little time was actually spent



[01.14.47] **Yegor**: Calendar-wise or the effort



[01.14.50] **Greg**: So calendar-wise there was quite a bit of time spent, but effort-wise not so much



[01.14.54] **Yegor**: Like not so much means what? Two days, two weeks, two months



[01.14.02] **Greg**: If I had compressed the time, probably like two weeks. 



[01.15.08] **Yegor**: That's cool, because you knew what to write like, right? You didn't need to do some research to prepare the materials



[01.15.17] **Greg**: Right and a lot of it was not the writing of things to start with it was the okay, let me send this off to five people, and have them read it and see what they come back with and was there a section they don't like. And maybe, I should rewrite that section or… Does that kind of make sense?


[01.15.41] **Yegor**: Yeah it does, and how big is the book, how many pages right now?


[01.15.48] **Greg**: I'd have to go pull it up, it's not very long 



[01.15.51] **Yegor**: I mean, I'm asking these questions because some of the people who are listening to us right now. They may think about publishing a book as well, so we need to tell them your experience, and then they may learn from you so what would you what would you tell them the people who haven't yet started



[01.16.09] **Greg**: With writing a book, it's going to depend a lot on your topic, the main thing to start with is trying to get a chapter layout, and to get that kind of set. So basically, it's kind of like building software. The first thing I want to start with is what is a rough idea of my overall goal, and then to move forward from there



[01.17.03] **Yegor**: Which is hard to do I imagine that's why you're emphasizing that



[01.17.07] **Greg**: Well it's hard to stick to it. If that kind of makes sense?




[01.17.13] **Yegor**: It means that you have some initial idea in the beginning and then in a few chapters down the road. You change everything right. 




[01.17.20] **Greg**: Well, yeah. And then it's well. I know I need to rewrite chapters two and three, and I've done this myself. And I've watched lots of other people do it, where you start getting into this thing of, I'm no longer really creating new content. I'm just rewriting the content that I already have in slightly different ways. 



[01.17.48] **Yegor**: Yeah, it's not a happy experience. I can imagine well, maybe, for some people it isn't a good experience, like the whole process of writing could be enjoying, but when the result is disappearing, every second months



[01.18.02] **Greg**: The other thing that I would tell people in terms of writing, especially for things like computer science, and I've learned this over time is to try to get as many personal examples of things into the text as possible. So, it's not just if I tell you, if you do this, you're going to end up failing, tell me the story about how you did it and you failed


[01.18.38] **Yegor**: No



[01.18.50] **Greg**: Because that story, especially if it's a good one is something that's going to stay in my mind and it builds up your authenticity that it's not just that I'm telling you. Don't do this, I'm telling you don't do this, because I did it and here's where I *** up


[01.19.08] **Yegor**: And in your book, you told them these stories. 


[01.19.10] **Greg**: Yes, and that that's a big part of what I was trying to get into the book was not just that this is how you should do things, but it's also. Well, you know, I'm not some magician over here, who just came up with all this stuff. Here's where I didn't do these things and I really screwed up, and this is what you're trying to avoid


[01.19.38] **Yegor**: Good. I think that's a that's a smart advice to people who… because yeah, I know I mean many books are pretty abstract, and they say very good things about things in general, but they don't go down to examples. And that's why they're boring to read I totally agree. 



[01.20.00] **Greg**: Honestly, there's a lot that we can learn from failures and actually seeing what failed why it failed, retrospective back on the failure is a very good way of learning. Why you should avoid that failure in the future. Well and how to avoid that failure in the future. 



[01.20.29] **Yegor**: Okay, that's quite positive. I believe quite positive finish of the story of the of the talk. I keeps. 



[01.20.36] **Greg**: Oh, my god where'd he goes! 


[01.20.38] **Yegor**: Sorry, sorry, sorry, hold on this camera is annoying. So, thank you very much for coming for the interview. I really enjoyed talking to you and I really hope to see you sometime, next time, maybe in the future. 


[01.20.54] **Greg**: Well, you mean like once flights are going again and. I actually think we're getting pretty close to it at this point. 


[01.21.00] **Yegor**: Yeah, I also hope so


[01.21.03] **Greg**: Within the next few months. I think you're going to start seeing a lot of things opening up. 


[01.21.09] **Yegor**: I also hope so honestly because it's annoying. What's going on now

[01.21.16] **Greg**: Well, I just want to be able to jump on a plane to London land in London: go work jump on a plane out of London


[01.21.23] **Yegor**: Where are you right now by the way. I didn't ask you. 



[01.21.25] **Yegor**: I am near New York city. 



[01.21.30] **Yegor**: All right. Okay, okay, thanks for the talk, Greg. Let me I'll let you go. Thanks for your time


[01.21.35] **Greg**: Enjoy?



[01.21.36] **Yegor**: Absolutely, you too


[01.21.37] **Greg**: All right. Bye
