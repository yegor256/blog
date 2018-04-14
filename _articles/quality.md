Blame-Free Software Quality Control

How responsible are programmers for the quality of code they write? This
question may sound strange. Who else should be responsible for the code's
quality aside from its programmers? However, there is an alternative philosophy
that exists suggesting that programmers are only responsible for the speedy
delivery of the code while the quality of the code must be the concern of
the project.

Programmers write software, software designed to work with its source code for
an intended purpose. Any "bugs" or defective code created along the way is a
result of this process. One of the main goals of any software project is to
reduce the amount of bugs and therefore increase the so-called quality of the
code as Assistant Professor of VIT University, Vishal Anand notes in his
[piece](https://arxiv.org/pdf/1405.0786.pdf), "Fault identification and testing
has always been the most specific concern in the field of software development."

There are many well-known methods for finding bugs in the code, including manual
testing and peer reviews. However, these methods are rather reactive—they find
bugs already contained in the code, possibly after the product has already has
been shipped to its users. These bugs can go mostly unnoticed, costing companies
substantial profits, or they can lead to massive, headline causing failures, as
David Pogue [points to](https://www.scientificamerican.com/article/pogue-5-most-embarrassing-software-bugs-in-history/)
in Scientific American.

Preventive methods for increasing the quality of the code are more desirable,
mostly because they are cheaper.
[Exponentially so](https://www.isixsigma.com/industries/software-it/defect-prevention-reducing-costs-and-enhancing-quality/) according to Mukesh Soni who cites a Systems
Sciences Institute at IBM report, "The cost to fix an error found after product
release was four to five times as much as one uncovered during design, and up to
100 times more than one identified in the maintenance phase." One of the more
popular techniques, and at the same time the least obvious, is to hire "better
programmers." It is a very common misconception that more professional,
expensive, and talented programmers create less bugs. In reality, the
correlation [seems to be](http://www.yegor256.com/2015/06/18/good-programmers-bug-free.html)
the opposite. Regardless of talent or training,
[the proliferation of software bugs](https://www.csoonline.com/article/2608330/security/5-reasons-why-software-bugs-still-plague-us.html)
rests on the fact that programmers are "still human
and we make mistakes" as columnist Roger A. Grimes reiterates.

The next equally questionable method of increasing the quality of the code is to
blame programmers for the bugs they create. The negative effect of this
approach, also known as [Fear Driven Development](https://jvns.ca/blog/2014/12/21/fear-makes-you-a-worse-programmer/),
outweighs its benefits:
programmers become stressed, work much slower, and discard a great deal of code
in the process as Android/iOS developer Nilesh Jarad
[highlights](https://medium.com/mobility/why-developers-scared-to-refactor-code-47efd1b854e7)
stating that "Fear makes you tentative. Fear makes you want to
communicate less. Fear makes you shy away from feedback. Fear makes you grumpy."
Effects that are inherently counterproductive to software development.

Instead of placing the blame for the code's quality on the shoulders of its
programmers, it would be much more effective to allow the project to focus on
that aspect while directing programmers to fearlessly contribute to the overall
project at full-speed. To make this possible, the project must build a strong
"quality control wall" between its codebase and its programmers. The stronger
the wall, the safer programmers will feel.

A number of technical and organizational measures can be utilized by a software
project to build such a wall and protect its quality from its own programmers.
Here are some examples listed according to complexity and importance:

  * Mandatory _coverage threshold_, which is a set of numbers a tool like [Jacoco](http://www.eclemma.org/jacoco/) or [Cobertura](http://cobertura.github.io/cobertura/) uses right after running automated tests. If the actual amount of code covered by tests is lower than the pre-configured threshold, the build fails. It is expected that a higher threshold illustrates a code's stronger protection from automated tests. Even though this assumption has been [criticized](https://www.thoughtworks.com/insights/blog/are-test-coverage-metrics-overrated) many times, the absence of coverage control is definitely worse than wrongly covered code.

  * Mandatory _static analysis_ with a number of pre-configured analyzers, like [Checkstyle](http://checkstyle.sourceforge.net/) or [Rubocop](https://github.com/bbatsov/rubocop), that  go through the entire code base and find potentially problematic code blocks. They do not compile or execute the code. Instead, they find where the code violates the rules and conventions of coding. For example, [Qulice](http://www.qulice.com), an aggregator of [Checkstyle](http://checkstyle.sourceforge.net/), [PMD](http://pmd.sourceforge.net/), and [FindBugs](http://findbugs.sourceforge.net/), contains over 900 rules used for testing the code.

  * Mandatory multi-step _code reviews_ for each and every set of changes programmers introduce. Not every defect can be caught by automated tests or static analyzers. Multiple reviewers will only increase the code's quality and protect the project source code even more.

  * Automated _pre-flight builds_, which an independent server like [Jenkins](https://jenkins.io/), or a service like [Rultor](http://wwww.rultor.com), runs before merging any changes to the main development stream. No matter how much potential damage a programmer makes in his or her own branch, those changes will not progress into the project repository unless the build is clean. Of course, if the build is not automated or the test coverage is low, then the pre-flight builds will not be of much use.

  * _Read-only master_ branch, that [nobody can push to](http://www.yegor256.com/2014/07/21/read-only-master-branch.html), except the pre-flight build server. All changes coming from programmers must be validated and only then merged into the master. The restriction must be technical, not organizational—it must be impossible to push to the master due to pre-configured permission rules in the code repository.

How can a programmer deliver faster if there are so many restrictions in the
process and the code repository? There are a number of tricks, many that will
only appear suspicious if the project is "weak" and cannot protect itself.
However, if the project is fully protected, then methods will benefit both
programmers and the project.

  * _Make changes smaller_. Thanks to extensive barriers, the risk of pull request rejection is very high. A smart programmer will attempt to make a few small pull requests, which will have higher changes of merging, instead of aiming for perfection and trying to solve and deliver the entire scope in one attempt.

  * _Push back_. When a problem is too complex and depends on other legacy code blocks, a smart programmer would not try to fix them all inside one pull request. Instead, reporting bugs and asking the project to fix the dependencies first would be a wiser move.

  * _Break things_. The codebase that is properly protected encourages programmers not to fear breaking it. The less they care about the overall stability of the entire codebase (this is what the architect should focus on), the faster they move forward and the more the project will benefit.

  * _Isolate changes_. Trying to see the codebase as a whole, studying the "big picture" and thinking about consequences only slows the programming process. Smart programmers try to isolate their efforts and focus on particular issues and features, letting the project and its architect worry about the overall result.

In other words, there must be a permanent conflict between a project and its
programmers: 1) the project must be configured to reject anything that lowers
the quality of its artifacts and 2) programmers must be interested in making
changes to those artifacts. The project should focus on the quality, and the
programmers should focus on rapidly delivering modifications.

If we merge these two interests into conflict, we will get a high-quality
product that rapidly grows. The project will enforce quality. Programmers will
push the code forward, making expeditious and frequent changes.

Unfortunately, most projects have very different philosophies. They delegate
quality control to programmers, hoping that they will not "do evil." This leads
to frustration, distress, constant fear of mistakes, long delays, blaming, and
shaming. Ultimately, this method leads to both the project and its programmers
losing in the end.

Of course, not every project will be able to configure itself in the most
effective way. Most projects do not even know how to go about accomplishing
this. And in those projects, if developers step on the gas, the end result will
be most likely ruining the codebase in only a few days.
