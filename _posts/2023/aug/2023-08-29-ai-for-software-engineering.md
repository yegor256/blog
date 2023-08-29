---
layout: post
title: "Robots vs. Programmers"
date: 2023-08-29
place: Moscow, Russia
tags: ai programming
description: |
  Robots will likely revolutionize software engineering ranging 
  from code reviews and bug fixing to automated refactoring, 
  backlog prioritization, and employee appraisals.
keywords:
  - AI for SE
  - AI for coding
  - ChatGPT for programmers
  - ChatGPT for coding
  - AI for programming
image: /images/2023/08/blade-runner.jpg
jb_picture:
  caption: Blade Runner (1982) by Ridley Scott
---

The [release](https://venturebeat.com/ai/openai-debuts-chatgpt-and-gpt-3-5-series-as-gpt-4-rumors-fly/) 
of [ChatGPT](https://chat.openai.com/) 3.5 has changed everything for us programmers. 
Even though most of us (including me) don't understand how it works, 
some of us use it more frequently than Stack Overflow, Google, and IDE built-in features. 
I believe this is just the beginning. Even though, only [Microsoft](https://www.githubnext.com) 
knows what will happen next, let me try to make a humble prediction too. 
Below, I list what I believe robots (with Generative AI on board) will do in the future.
The further into the future, the lower on the list.
I tried not to repeat what [GitHubNext](https://www.githubnext.com) is already saying. 

<!--more-->

{% jb_picture_body %}

**Report Bugs**. They will go through the codebase, analyze the code, and maybe
  even try to run some tests, then submit bug reports when problems are
  obvious. They will also submit bug reports when they find code that is hard
  to understand, improperly documented, not covered by automated tests, or has security vulnerabilities.
  Additionally, they will report when they see that the code is not following
  conventions or best practices. They will write their reports so nicely and
  provide so many technical details and supplementary links that programmers
  will prefer the reports from robots much more than reports from humans.

**Review Pull Requests**. They will examine the pull requests submitted to the
  repository (either by humans or robots) and review them by making comments on
  certain lines of code, either criticizing the quality of the code and/or
  suggesting better alternatives. They will keep track of the suggestions made
  earlier and will insist where necessary. In the end, the authors of the pull
  requests won't even know who is reviewing them: a human or a robot.

**Refactor**. From a huge collection of well-known micro-refactorings, they will
  select the few most important at any given moment and will submit pull
  requests with the changes. They won't alter the functionality of the code or
  make massive modifications. Instead, they will improve the quality of the
  code in small increments, making it easy for us humans to merge their
  suggested changes. They won't change too much, so we won't feel managed by
  robots, but we will be. Slowly and incrementally, they will improve the
  codebase, making it more readable, maintainable, and better understood ...
  by other robots.

**Backlog Prioritization**. They will sort tasks and tickets into their
  appropriate milestones, determining which ones are of higher priority. They
  will decide which bug should be fixed first and which feature request is more
  important than others. Utilizing historical data, current team velocity, and
  other relevant metrics, they will create a prioritized backlog that aligns
  with both short-term objectives and long-term goals.

**Refine Bug Reports**. They will examine already reported bugs and refine them,
  providing supplementary information, explaining the code to which the bug
  refers, and suggesting code snippets that could potentially reproduce the
  bug. They will do the work that most programmers are too lazy to do: properly
  explain the bug in order to help its fixer.

**Document Source Code**. They will find places in the code that are hard to
  comprehend, such as complex functions, large classes, and big data
  structures. They will generate documentation blocks and then submit pull
  requests with them. Humans will be happy to accept these, since documenting
  someone else's code is a routine and boring part of work. Moreover, keeping
  the documentation in sync with the source code is one of the areas where our
  human negligence is most visible.

**Fix Bugs**. According to the code they already see in the codebase and the
  list of bugs reported in issues, they will generate some fixes and submit
  them as new pull requests. They will explain what the fixes are doing, why
  the improvement is made in this or that way, how critical the fix is, and
  also suggest possible alternatives. We will simply merge them.

**Formalize Requirements**. They will examine the codebase and the comments
  where we discuss it, and will derive a formal definition of the requirements
  we implement. Then, they will formulate the requirements using Use Case
  diagrams, Requirement Matrix, or even informal textual documents like README
  or Wiki. They will keep these documents up to date throughout the entire
  lifecycle of the codebase---something we humans are often too lazy to do.

**Onboard**: 
  They will assist in the onboarding process of new developers, 
  guiding them through the codebase, explaining architectural decisions, 
  and offering personalized tutorials. They will also help us understand
  certain code blocks by providing interactive guidance.

**Analyze Technical Debt**
  They could analyze the codebase to identify areas where technical debt is 
  accumulating and suggest steps to mitigate it before it becomes problematic.
  They will submit tickets where the biggest debt territories will be
  identified and improvements suggested.

**Cleanup Documentation**.
  They will reformat the doc blocks that we humans write for our classes
  and methods, and then submit pull requests with the changes. 
  Formatting the documentation correctly, using HTML, Markdown, Doxia,
  and many other formats, is a boring work where we humans fall short.

**Suggest New Features**. They will examine already implemented functionality
  and will suggest additional features, submitting tickets. They will explain
  the reasons behind such new feature requests, find proper justification, and
  provide examples of how users will interact with the new functionality.

**Document Architecture**. They will observe the codebase and then update the
  documentation about the architecture it implements. This is something
  programmers usually forget to do, or simply don't know how to do right. The
  robots will use UML or perhaps less formal instruments to document the
  architecture, thus making the entire product easier to maintain.

**Estimate**. They will estimate the complexity of every bug report or feature
  request in staff-hours, calendar days, or maybe even in lines of code. This
  information will help the team make planning decisions.

**Predict**. By examining events in a repository, they will spot anomalies in
  our human behavior, such as changes in the mood of programmers in the
  comments, spikes in the intensity of commits, failures in CI/CD pipelines,
  and so on. They will be able to predict larger troubles before it's too late.
  They will predict and then suggest corrective and preventive actions,
  submitting tickets with management or technical suggestions.

**Appraise**. They will observe the activity of every programmer and will
  appraise their productivity. The results will be published directly to GitHub
  issues or perhaps sent to project managers by email. In the end,
  they will decide who of us humans are more valuable to their projects.

I'm thankful to ChatGPT for helping me build this list.

What do you think I missed?

