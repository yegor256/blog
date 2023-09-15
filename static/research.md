---
layout: static
title: "Research"
description: |
  This is what I'm interested in, research wise. If you are
  a student, or an enthusiast, you are welcome to join.
  Email me, we'll discuss.
permalink: research.html
image: /images/andreea/academic-writing.png
keywords:
  - publications
  - papers
  - academic papers
  - yegor bugayenko
  - yegor256 papers
---

{% badge /images/andreea/academic-writing.svg 200 %}

As a junior researcher, I'm interested in two primary subjects:
automated project management and object-oriented programming.
You can find me in
[Scopus](https://www.scopus.com/authid/detail.uri?authorId=30367443600),
[Google Scholar](http://scholar.google.ru/citations?user=cYmXh60AAAAJ)
and [DBLP](https://dblp.uni-trier.de/pers/hd/b/Bugayenko:Yegor) too.
I'm also a co-organizer of [ICCQ](https://www.iccq.ru/).

If you are a student and looking for a research topic for your diploma, 
pick one of the following and text me in Telegram: [@yegor256](https://t.me/yegor256). 
I will help you to do the research and may also play a role of your scientific advisor.

<hr/>

**Jumps Elimination in OOP**:
Recently, we developed [DeJump](https://github.com/objectionary/dejump),
an automated tool that modifies programs written in [EOLANG](https://www.eolang.org),
our own object-oriented language, such that "jumping objects" (GOTO, BREAK, and CONTINUE)
are replaced with recursion or other declarative mechanisms. A research paper
about the tool was recently accepted at a computer science conference ([CSAI'23](http://www.csai.org/)).
However, even though the tool exists, it has not been tested with a larger amount of
source code, and it needs a few important improvements in its algorithm.
Thus, we suggest creating the second version of the tool, with the required improvements
and testing it with larger blocks of code, in order to demonstrate its effectiveness.
A new research paper is expected to be written and published.

**SLR of Object Models**:
There is a famous [λ-calculus](https://en.wikipedia.org/wiki/Lambda_calculus) that underlies functional programming languages,
like Haskell or Scala. At the same time, for object-oriented programming languages,
more than one calculus has been introduced over the last thirty years, such as
[Object-Z](https://en.wikipedia.org/wiki/Object-Z) and 
[VDM](https://link.springer.com/chapter/10.1007/3-540-17654-3_14). 
However, most modern object-oriented languages, such as
Java 18+ or Swift, may not be fully formalized with the help of said calculi.
There are certain limitations in every calculus. In 2021, we made an attempt
to conduct a detailed analysis of existing object-oriented formal models in the form of a
Systematic Literature Review ([SLR](https://www.tu.berlin/en/wm/bibliothek/research-teaching/systematic-literature-reviews/description-of-the-systematic-literature-review-method)). 
Unfortunately, we didn't have enough time
to study each calculus deeply enough, which is why we stopped the research project.
Now, we suggest continuing this work, researching existing models,
and publishing a full academic paper. This paper, if published in a reputable journal or conference,
could become a significant contribution to the theoretical sector of
object-oriented programming.

**Algorithmization of Object-Oriented Programs Written in EO**:
[EOLANG](https://www.eolang.org), our experimental strictly object-oriented programming language,
is very effective for modelling objects and their relationships.
However, it falls short when programming algorithms and mathematics, because the code
tends to run much slower than its procedural counterparts written in C++ or Rust. We suggest
creating a code optimisation tool, which will identify blocks of code inside
EO programs that can be translated to Rust to enhance performance.
Thus, we aim to develop a tool that inserts native code blocks into the original EO program,
bridging two programming paradigms—object-oriented in EO and procedural in Rust—by
connecting them both ways through the [JNI](https://en.wikipedia.org/wiki/Java_Native_Interface) 
interface. The main challenge lies in pinpointing the most suitable code blocks;
their introduction should increase the overall program performance while considering
the additional overhead introduced by JNI roundtrips.

**ChatGPT in Backlog Prioritization**:
There is an existing open-source tool, created more than five years ago,
that assists GitHub programmers in decomposing their tasks into smaller ones and
automatically creating sub-tasks: [0pdd](https://www.0pdd.com). 
We aim to enhance this tool with Machine Learning,
enabling it to prioritize tasks more effectively. Additionally, we want
to integrate [ChatGPT](https://www.chatgpt.com) into the tool to automatically estimate the value of each task
and suggest fast-tracks for those implementing tasks. We have already
made a theoretical attempt to identify an effective solution and have published our findings 
in the [IEEE Access journal](https://ieeexplore.ieee.org/abstract/document/10220100). 
Now, implementing these findings in practice and incorporating
ChatGPT could represent a significant contribution to computer science
and provide invaluable assistance to hundreds of GitHub programmers.

**ChatGPT for GitHub Anomalies Detection**:
The quality of source code and the discipline of repository maintenance
play a crucial role in the success of a software product. However, there is
no automated tool on the market that appraises the quality of an entire
repository and generates recommendations for its maintainers, with a focus
on architectural issues and process flaws. In 2021, we attempted to create
such a tool and even [published](https://dl.acm.org/doi/abs/10.1145/3524842.3528517) some theoretical
findings in this direction. However, we didn’t employ ChatGPT,
as it didn't exist at that time. Now, we believe it would be beneficial
to combine our project analysis algorithm with the capabilities of LLM,
to generate the most effective and useful advice for software teams.

**Analysis of Heap Performance in Different OSs**:
The heap is the primary storage for variable-sized memory blocks in modern
operating systems and virtual machines. Allocating a slice of bytes in
the heap and then releasing it back is a time-consuming operation,
requiring several hundred CPU cycles. However, the exact number of cycles it
takes to allocate and free memory chunks in different virtual machines and OSs
remains unclear. We suggest studying this subject, performing experiments
on a sufficiently large number of testing platforms, summarizing and analyzing
the results, and then publishing a research paper. Such an analysis might assist
creators of programming languages and compilers in making better design decisions.

**Encapsulation Strategy in Design Patterns**: 
In object-oriented programming,
many design patterns are recommended for use. It's commonly believed that if
programmers adhere to these patterns in their code, the code quality will
improve due to clearer design. We hypothesize that most design patterns
emphasize the encapsulation of behaviors rather than data. In other words,
the objects participating in design patterns are typically "dataless"
objects. We propose studying this subject through a Systematic Literature
Review (SLR) of existing literature on design patterns, aiming to either
confirm or refute our hypothesis. The results of our research might be useful
for compiler and programming language designers, prompting them to treat
objects differently if they are dataless.

**Study Programmers' Preferences for Object Extensions**:
In object-oriented programming, additional functionality can be added to classes
using inheritance, decoration, composition, or by simply expanding existing
classes with new code or methods. It is commonly believed that most
programmers, especially those with over 10 years of practical coding
experience, prefer decoration or composition, as these methods typically result
in superior design. To validate this assumption, we propose conducting a survey
among a sizeable group of programmers. We'll present them with various code
snippets and ask them to choose a method for modifications. The findings from
our research might offer insights to designers of new programming languages
about programmers' perceptions of OOP.

**Cost of OOP in Different Languages**:
[Earlier studies](https://downloads.hindawi.com/journals/sp/1999/464598.pdf) 
by various researchers and practitioners have indicated that
object-oriented programming features, such as encapsulation and polymorphism,
are more performance-intensive compared to their procedural counterparts
(like static methods and global variables). However, a direct comparison
between programming languages has not been undertaken. We propose such a
comparison to determine in which object-oriented programming language
programmers incur the highest performance cost for using the object paradigm.
The results of this research might assist other researchers in better
understanding the practical usability of object-oriented programming.

<!--

[Volatility metric to detect anomalies in source code repositories](https://dl.acm.org/doi/abs/10.1145/3486949.3486961),
BCNC 2021: Proceedings of the 1st ACM SIGPLAN International Workshop on Beyond Code: No Code,
October 2021
[PDF](/pdf/2021/volatility.pdf), [LaTeX](https://github.com/yegor256/bcnc-2021-volatility)

[Combining object-oriented paradigm and controlled natural language for requirements specification](https://dl.acm.org/doi/abs/10.1145/3486949.3486963),
BCNC 2021: Proceedings of the 1st ACM SIGPLAN International Workshop on Beyond Code: No Code,
October 2021
[PDF](/pdf/2021/requs.pdf), [LaTeX](https://github.com/yegor256/requs-paper)

[Bringing Industry Back to Conferences, and Paying for Results](https://cacm.acm.org/magazines/2020/11/248192-bringing-industry-back-to-conferences-and-paying-for-results/fulltext),
Communications of the ACM, Volume 63, Number 11,
November 2020,
[PDF](/pdf/2020/cacm-oct.pdf)

The Impact of Object Immutability on Some Class Cohesion Metrics,
13th International Conference on Computer Science and Information Technology (ICCSIT),
Amsterdam, The Netherlands,
October 2020,
[PDF](/pdf/2020/iccsit20.pdf), [LaTeX](https://github.com/yegor256/immutability-vs-cohesion)

[The Impact of Object Immutability on the Java Class Size](https://www.sciencedirect.com/science/article/pii/S1877050920321281),
Knowledge-Based and Intelligent Information & Engineering Systems,
Verona, Italy,
September 2020,
[PDF](/pdf/2020/kes20.pdf), [LaTeX](https://github.com/yegor256/size-vs-immutability)

[The Impact of Constructors on the Validity of Class Cohesion Metrics](http://icsa-conferences.org/2020/index.html),
IEEE International Conference on Software Architecture (ICSA),
Salvador, Brazil,
March 2020,
[PDF](/pdf/2020/icsa20.pdf), [LaTeX](https://github.com/yegor256/ctors-vs-cohesion)

[The Benefits of Indolence](https://cacm.acm.org/magazines/2019/11/240379-the-benefits-of-indolence/fulltext),
Communications of the ACM, Volume 62, Number 11,
November 2019,
[PDF](/pdf/2019/indolence.pdf)

[Why Programmers Should Curb Their Enthusiasm, and Thinking About Computational Thinking](https://cacm.acm.org/magazines/2019/9/238957-why-programmers-should-curb-their-enthusiasm-and-thinking-about-computational-thinking/fulltext),
Communications of the ACM, Volume 62, Number 9,
September 2019,
[PDF](/pdf/2019/enthusiasm.pdf)

[Discovering Bugs, or Ensuring Success?](https://cacm.acm.org/magazines/2018/9/230562-discovering-bugs-or-ensuring-success/fulltext),
Communications of the ACM, Volume 61, Number 9,
August 2018,
[PDF](/pdf/2018/discovering-bugs.pdf)

[We are Done with 'Hacking'](https://cacm.acm.org/magazines/2018/7/229044-we-are-done-with-hacking/fulltext),
Communications of the ACM, Volume 61, Number 7,
July 2018,
[PDF](/pdf/2018/we-are-done-with-hacking.pdf)

[Method and Software of NetBout](https://www.google.com/patents/US20120117164),
US patent application 12/943,022,
November 2010

[How to Prevent SVN Conflicts in Distributed Agile PHP Projects](https://www.phparch.com/magazine/2010-2/august/),
php|Architect,
August 2010,
[PDF](/pdf/2010/phpArchitect-conflicts.pdf)

[Puzzle Driven Development (PDD) Method and Software](https://www.google.com/patents/US20120023476),
US patent application 12/840,306,
July 2010

[phpRack---Integration Testing Framework](https://www.phparch.com/magazine/2010-2/june/),
php|Architect,
June 2010,
[PDF](/pdf/2010/phpArchitect-phpRack.pdf)

[FaZend Object Relational Mapping](https://www.phparch.com/magazine/2010-2/february/),
php|Architect,
February 2010,
[PDF](/pdf/2010/phpArchitect-fazend-orm.pdf)

[Project Management Robot Method and Software](https://www.google.com/patents/US20110196798),
US patent application 12/703,202,
February 2010

[Quality of Process Control in Software Projects](http://www.iwsm-mensura.org/2009),
IWSM/Mensura, Amsterdam,
November 2009,
[PDF](/pdf/2009/IWSM09-article.pdf)

[Quality of Code Can be Planned and Controlled](http://www.iaria.org/conferences2009/ProgramVALID09.html),
The First International Conference on Advances in System Testing and Validation Lifecycle (VALID 2009),
Porto, Portugal,
September 2009,
[PDF](/pdf/2009/VALID09-article.pdf)

[Competitive Risk Identification Method for Distributed Teams](http://seafood.ethz.ch/2009/Files/flyer09.pdf),
3rd International Conference on Software Engineering Approaches For Offshore and Outsourced Development (SEAFOOD 2009),
ETH Zurich, Switzerland,
July 2009,
[PDF](/pdf/2009/SEAFOOD09-article.pdf)

[Method for Software Cost Estimating w/Scope Champions](http://www.springer.com/us/book/9783642021510),
10th International Conference, PROFES 2009,
Oulu, Finland,
June 2009

[Method and software for the measurement of quality of process](https://www.google.com/patents/US20100114638),
US patent application 12/264,370,
November 2008

[Method for software cost estimating using scope champions](https://www.google.com/patents/US20100042968),
US patent application 12/193,010,
August 2008

[The Interactive Databases Approach to the User Interface Modeling](http://dblp.uni-trier.de/db/conf/krdb/krdb98.html#Bugaenko98),
KRDB, Seattle,
May 1998,
[PDF](/pdf/1998/KRDB98-article.pdf)

I published something even earlier, but can't
find links... Maybe later.

-->