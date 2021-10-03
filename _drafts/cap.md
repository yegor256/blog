---
layout: post
title: "Calibrated Achievement Points (CAP)"
date: 2021-10-05
place: Moscow, Russia
tags: management
description: |
  Measuring individual performance is a very complex
  task, especially in R&D teams: here is how we do it.
keywords:
  - measuring individual performance
  - performance individual
  - measure creativity
  - creativity rules
  - creativity
image: /images/2021/04/
jb_picture:
  caption:
---

It's a well-known problem nowadays: how can we measure performance 
and productivity of individual contributors, which do non-routine 
creative work? The best examples are research and development (R&D) teams, which 
usually consist of software engineers, designers, 
scientists, architects, quality experts, product managers, and so on. 
Such professionals deliver results that are hard to get down to simple numbers. 
Many authors argue that the very idea of measuring individual performance is toxic and may only 
lead to negative consequences. We tried to challenge this point of view 
and made an experiment in our team, which demonstrated that individual 
performance can indeed be measured, even if people's work involves creativity, 
and results are hard to predict. We designed a system of 
Calibrated Achievement Points (CAP), which are rewarded to those who deliver 
visible and tangible results of different kinds. The article explains how 
CAPs work and summarizes the results of the experiment.

<!--more-->

{% jb_picture_body %}

"Competitions are for horses, not artists," said 
[Béla Bartók](https://en.wikipedia.org/wiki/B%C3%A9la_Bart%C3%B3k), 
a Hungarian composer about a hundred years ago.
Indeed, how can we measure a productivity of someone making a piece
of art, say, a painting? By the amount of acrylic put on the canvas
per minute? Or maybe we ask painters to compete by the size of the canvas in 
inches---the bigger the painting, the better is the painter!? Obviously, such metrics
would be considered not only useless, but harmful. Encouraging artists
to compete by such productivity indicators will kill the very idea of art
and will most probably discourage most talented artists to participate.

However, it seems that these days there are people who would disagree with the famous composer. 
For example, Jacob Eisenberg from University College Dublin and 
William Forde Thompson from Macquarie University, 
in [their research](https://www.researchgate.net/publication/233148051_The_Effects_of_Competition_on_Improvisers'_Motivation_Stress_and_Creative_Performance)
of how amateur musicians' creativity changes under a stress of competition, demonstrated:
competition positively affects creativity.
A more recent study by Daniel Gross from Duke University confirmed this finding
and extended with a warning: a heavy competition drives us to stop creativity
altogether.
Anil Rathi in [HBR noted](https://hbr.org/2014/11/to-encourage-innovation-make-it-a-competition),
from a business perspective, 
that "well-managed internal competitions amplify the company's overall creative ambience."

Thus, it seems that in the modern world competition and creativity go along.
However, how positive is the effect of competition depends on the
rules the team has to play by and the quality of metrics. 
If the metrics are reasonable and well understood
by all participants, the competition drives the creatitivity.

Of course, measuring the productivity of an artist by the amount of acrilyc they
put on the canvas or the productivity of a composer by the frequency
of pushing the piano keys would be useless and harmful.
However, there are many examples of good metrics in art, sport, and science,
which stimulate creativity of artists, athletes, and scientists for centuries:
[Nobel Prize](https://www.nobelprize.org/) is probably the most famous competition every 
world-class researcher is dreaming to win, Olympic Games and 
World Championships is what we have for athletes, 
[Oscars](https://www.oscars.org/) and [Cannes Film Festival](https://www.festival-cannes.com/en/)
are the competitions for best artists in cinema，and so on.

Even though the value of competition may be well understood by
a business, a practical application of it in an R&D department
may face many obstacles. The main problem would be to answer the question
of both employees and the management: "What are the metrics that can objectively measure
the performance of our people, who are not athletes or actors?"

After more than a year of experiments we found an answer and built
a system of CAPs. We defined a list of 30+ possible achievements 
any member of our R&D team can make while working with the scope of
our research and development. These are some of them, as an example (the "limit"
in the brackets is how many achievements of this type are possible to count in one year):

  * "Major Product Release": 30 (4)
    --- a software product in a major version is packaged and released to its users;
  * "Conference Article Accepted": 70
    --- a new research paper submitted to a computer science conference and accepted there for publishing;
  * "Technical Report Accepted": 40 (4)
    --- an short 2-4 pages internal report about technical results is submitted to
    our review board and accepted by it;
  * "New Hire": 20 (4)
    --- a new employee has passed all required interviews and joined the team;
  * "GitHub Star": 1
    --- most of our software projects are open source, that's why we reward for new stars obtained in GitHub;
  * "Lecture or Seminar": 5 (4)
    --- an educational presentation made inside the department.

The list is available for everybody in our internal Wiki. Each member
of our team can decide for themselves, what achievements to deliver
in order to win in the ranking. The achievements from the list don't replace
the everyday work everybody is doing, but are the "extra mile" anyone
can walk in order to stand out.

Some achievements are personal, such as a lecture or a conference article,
while others may only be created by a team, such as a major product release
or new GitHub stars. Individual achievements are attributed directly
to the account of an employee, while team achievements are distributed
equally among team members: we have seven teams in our department.

Obviously, the levels of competence and qualification are different
for different people. Some of them are junior programmers, while others
are PhD degree holders with decades of experience. Publishing an 
computer science article for a junior programmer is a much larger achievement
(which is harder to do) than for a seasoned expert. To take this 
misbalance into account we introduced "weights" for each person, which
are used as denominators. For example, if Jeff, a junior programmer with a weight of 
10 publishes an article, he earns 7 points (we divide 70 by 10).
At the same time, if Sarah, a PhD with a weight of 25, publishes an article,
she earns only 2.8 points (we divide 70 by 25).

We organized our results monitoring system with a "push" principle in mind:
everyone is responsible for reporting their own results to our team assistant.
We don't "pull" the information from them, they decide by themselves
when and what to report. The team assistant collects the data in a simple
Excel spreadsheet and emails it to everybody once a week (there are about 50
people in our team). The document contains the journal of all achievements
reported to the moment, the ranking of every team member, and their weights.

Since the information is publicly available weekly, we encourage every
team member to dispute the achievements of others, if they feel so. We don't
have a special auditor for the results people report. Instead, peer review
demonstrates perfect results: when someone reports something that 
violates our expectations of quality or fairness, almost
immediately a concern gets raises. Most disputes, which happen every few months,
we resolve by open  discussions.

As was noted by David Sarnoff, an American businessman and pioneer 
of American radio and television, "competition brings out the best in products 
and the worst in people." The CAP system we designed helped us not only
see the best in product by increasing the productivity and creativity of
our people, but also decrease the amount of those "worst," which inevitably
surfaces when people compete against each other. The CAP system gives us
the rules, which are fair and transparent enough to significantly reduce the amount
of conflicts and cheating.

