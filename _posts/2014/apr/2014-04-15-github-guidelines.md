---
layout: post
title: GitHub Guidelines
date: 2014-04-15
tags: github xdsd
description: |
  This step-by-step manual helps you to start working
  with a GitHub-hosted project in the spirit of XDSD.
keywords:
  - github
  - XDSD in GitHub
  - github programming
  - fork in github
  - how to contribute github
  - github team work
---

This manual explains the workflow used when working with a [XDSD](https://www.xdsd.org)
project hosted
on [GitHub](https://www.github.com). You start when a GitHub issue is
assigned to you. Next, you will receive a message from a
[project manager]({% pst 2016/may/2016-05-24-who-is-project-manager %})
containing the issue number, title, description and its budget in hours (usually
30 minutes).

If you don't agree with the budget allotment, don't hesitate to ask for an
increase. As soon as you are comfortable with the budget and understand the
scope of the work, say so in a reply to the ticket and start working. Be aware
that you won't be paid for time spent above and beyond the allotted time budget.

<!--more-->

## 1. Fork

Even though you're part of the development team, you don't have write access to
the repository in GitHub. Consequently, to contribute changes, you should fork
the repository to your own GitHub account (create a private copy of it), make
needed changes and then submit them for review using "a pull request."

After you submit a pull request review, the repository owner approves your
changes by merging them into the main repository. This is how we protect the
main development stream against accidental damage.

This article explains how to fork a repository:
[fork-a-repo](https://help.github.com/articles/fork-a-repo)

This one explains how to download and install GitHub on your computer:
[set-up-git](https://help.github.com/articles/set-up-git)

Finally, don't forget to add your private SSH key to GitHub:
[generating-ssh-keys](https://help.github.com/articles/generating-ssh-keys)

## 2. Branch

Once you have a forked our repository to your account, clone it to your
computer, and then check out the `master` branch. For example:

```bash
git clone git@github.com:yegor256/xembly.git
git checkout master
```

Now, it's time to branch (`123` is the number of the GitHub issue you're going
to work with, and the name of the branch):

```bash
git checkout -b 123
```

By convention, we use the same names for the branch and issue you're working
with.

## 3. Changes

All task-related questions should be discussed in the GitHub issue. For GitHub
issues, we [don't use]({% pst 2014/oct/2014-10-07-stop-chatting-start-coding %})
emails, Skype, phone calls or meetings. All questions
should be asked directly in the GitHub issues.

Don't hesitate to submit new issues if something is not clear or you need help.
It's a very common to receive a task that you may not be able to implement.
[Don't panic]({% pst 2015/jan/2015-01-15-how-to-cut-corners %}).
This usually happens when you first just join a project and don't
yet have enough information. If this happens, don't try to figure out a problem
or issue by yourself.

The rule of thumb for this type of situation is: "If something is not clear, it
is our fault, not yours." Therefore, if you don’t understand the project design,
it is the fault of the project designer.

Submit a [bug report]({% pst 2018/apr/2018-04-24-right-way-to-report-bugs %})
requesting an explanation of a design concept. You will be
paid for this report, and the information you receive in the reply will be
shared between all other developers.

Read this article: [Bugs Are Welcome]({% pst 2014/apr/2014-04-13-bugs-are-welcome %}).

[Don't expect]({% pst 2015/feb/2015-02-16-it-is-not-a-school %})
anyone to help you. Your only source of help is the source code
itself. If the code doesn't explain everything  you need to know---it is a
bug, which must be reported.

## 4. Commit and Push

Make any needed changes using a text editor or IDE. It's a good practice to
commit changes as soon as you make them. Don't accumulate large numbers of
changes too long before committing them.

```bash
git commit -am '#123: the description of the changes'
git push origin 123
```

If you have questions about the scope of work, post them in the GitHub issue and
[wait]({% pst 2016/mar/2016-03-15-wring-dispatcher-github-notifications %})
for an answer. If you think that the existing code needs improvements,
don't hesitate to submit a new issue to GitHub.

Don't try to fix all problems in one branch; let other programmers take care of
them.

## 5. Pull Request

Create a pull request in GitHub using the process in the following article:
[using-pull-requests](https://help.github.com/articles/using-pull-requests)

Post its number in the original issue and wait for feedback.

## 6. Code Review

After a while, your pull request will be reviewed by someone from the project
team. In many cases, you may receive a few negative comments, and you will have
to fix any and all issues associated with them. Your pull request won't be
merged into `master branch`, until your changes satisfy the reviewer.

Be patient with the reviewer, and listen to him carefully. However, don't think
that your reviewer is always right. If you think that your changes are valid,
insist that someone else review them.

After you make the required changes to the branch, don't forget
to notify the reviewer in the issue by posting a message addressed to him/her.
On every round of the review-fix cycle do the same: ask the reviewer to
take a look at your code again. Without such notifications your pull request
may stay much longer in silence.

## 7. Merge

When everything looks good to the reviewer, he will inform our automated
[merge bot]({% pst 2015/nov/2015-11-03-chatbot-better-than-ui-for-microservice %}).
The automated merge bot will then select your pull request and try to merge
it into `master` branch. For various reasons, this operation fails often. If the
merge fails, regardless of the reason, it is your responsibility to make sure
that your branch is merged successfully.

If you can't merge a branch because of failures in tests not associated with
your task, don't try to fix them yourself. Instead, report a problem as a new
bug and wait for its resolution.

Remember, until your branch is merged, you are not paid.

## 8. Payment

Once your changes are merged, return to the GitHub issue and ask the author to
close it. Once the issue is closed by a project manager, you will receive your
payment within a few hours.
