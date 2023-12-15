---
layout: post
title: "Be Indirect in Your Research Questionnaire to Gain More Honesty"
date: 2023-11-28
place: Moscow, Russia
tags: science
description: |
  When conducting a survey to ascertain people's 
  feelings about a topic, it is more effective 
  to use indirect questioning.
keywords:
  - research questionnaire
  - how to build a questionnaire
  - SE questionnaire
  - empirical study questionnaire
  - study questionnaire
image: /images/2023/11/coffee-and-cigarettes.jpg
jb_picture:
  caption: Coffee and Cigarettes (2004) by Jim Jarmusch
style: |-
  .down::after { content: "▼"; color: firebrick; }
  .up::after { content: "▲"; color: seagreen; }
---

Let's say you are conducting research to discover programmers' opinions about
their work environments: whether they appreciate their office spaces or not.
Preparing a survey with a few questions is essential. Their responses will
reveal their thoughts and feelings. After working with several student groups,
I've noticed a common mistake in questionnaire design—they are _too obvious_ with
their questions, simply asking, "How do you feel about this?" There's a more
effective approach.

<!--more-->

{% jb_picture_body %}

Typically, to understand people's thoughts and feelings, we might ask
directly, "What do you think and feel?" This is akin to a doctor
inquiring, "What is your disease? What kind of pill should I prescribe?" While
straightforward, this method suits a doctor less concerned with patient
recovery.

Asking directly also exposes the survey's intent. Savvy respondents may realize
our research goals, potentially skewing results by conforming or sabotaging the
study. Some might claim they enjoy their work environment, while others might
express dissatisfaction. However, few will be entirely candid, feeling more
like researchers than participants.

Here's an example of an ineffective survey structure:

```text
Q1: Is your work environment comfortable?
  - Agree
  - Neutral
  - Disagree
Q2: Do you feel tired at the end of an office day?
  - Agree
  - Neutral
  - Disagree
Q3: Do you enjoy working in the office?
  - Agree
  - Neutral
  - Disagree
```

A skilled doctor, rather than directly asking about diseases, inquires about
symptoms: "How often do you urinate?" or "Are you thirsty upon waking?"
Similarly, in empirical computer science studies, we can engage respondents
with hypothetical scenarios.

By asking respondents directly, we inadvertently shift our research
_responsibilities_ onto them. Our role is to determine if they enjoy their office
space. We should observe their behavior, symptoms, and reactions to draw
conclusions. Simply asking, "Do you feel comfortable?" suggests a lazy or
inexperienced interviewer.
Responding to such a _generic_ question, respondents will have to put together 
their entire experience of being in the office, analyze it, make some
conclusions, and then summarize them for us---this is the work we researchers have to do,
not our interviewees.

Consider this revised questionnaire:

```text
Q4: With a looming strict deadline, where would you 
prefer to work on a critical software module?
  - At home
  - In a café
  - In the office
Q5: When did you last feel exhausted at the end of 
an office day?
  - A few days ago
  - A few weeks ago
  - Don't remember
Q6: How would you rate the office coffee 
machine's quality?
  - Excellent
  - It's OK
  - Poor
```

The first two questions, Q4 and Q5, are _situational_, placing respondents in
specific scenarios. We then _interpret_ their reactions to deduce answers to our
primary question: Do they like their work environments? This interpretation
_method_ should be clarified in the research paper.

Question Q6, while not situational, is superior to Q1-Q3. It avoids asking
respondents to self-diagnose, subtly probing their opinions about office coffee
machines. The responses indirectly indicate their overall satisfaction with the
work environment.

In summary, avoid directly inquiring about illnesses; instead, ask about
symptoms to discreetly pursue your research objective. This approach elicits
more honest responses.

When the list of questions is ready, you can draw a table in your
research paper, listing all questions on a vertical axis and possible
answers on the horizontal one. Under each answer you mention the 
impact it makes to one of your research questions, for example:

|   | A<sub>1</sub> | A<sub>2</sub> | A<sub>3</sub> |
|---|---|---|---|
| Q<sub>4</sub>: With a looming strict deadline, where would you prefer to work on a critical software module? | At home<br/>RQ1<span class="down"/> | In a café | In the office<br/>RQ1<span class="up"/> |
|---|---|---|---|
| Q<sub>5</sub>: When did you last feel exhausted at the end of an office day? | A few days ago<br/>RQ1<span class="down"/> | A few weeks ago | Don't remember<br/>RQ1<span class="up"/> |
|---|---|---|---|
| Q<sub>6</sub>: How would you rate the office coffee machine's quality? | Excellent<br/>RQ1<span class="up"/> | It's OK | Poor<br/>RQ1<span class="down"/> |
|---|---|---|---|

This table clearly explains to readers of your research, why did you
ask these questions and how the responses provided by the 
respondents helped you answer your research questions.