---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Key Roles in a Software Project"
date: 2016-07-10
place: Palo Alto, CA
tags: management
description: |
  Here is a full list of roles that must exist
  in any software project, doesn't matter of
  what size it is.
keywords:
  - roles and responsibilities
  - software project roles
  - roles in software project
  - software project
  - roles in software
image: /images/2016/07/12-angry-men.jpg
jb_picture:
  caption: 12 Angry Men (1957) by Sidney Lumet
---

I believe that several roles should be present in a majority of
software projects. Managed by
[Zerocracy](https://www.zerocracy.com) according to the principles of
[XDSD](https://www.xdsd.org), we've got all of them in our projects. However, beware that in other management
methodologies, these roles may have different meanings. This blog post
is mostly for people who work with us, either as clients or freelancers.

<!--more-->

{% jb_picture_body %}

There are just a few roles:

  * **Project Manager** (`PM`)
    is responsible for keeping the project [under control]({% pst 2016/may/2016-05-24-who-is-project-manager %}).
    The PM reports to the head of our [PMO](https://en.wikipedia.org/wiki/Project_management_office).

  * **Product Owner** (`PO`)
    is a representative of the sponsor.
    The PO provides product requirements.
    The PO submits bugs and expresses any concerns or questions relating to them.
    Usually, the PO is a very technical person
    who knows how the product works and is capable of understanding the source code.

  * **Software Architect** (`ARC`)
    is responsible for the entire technical solution.
    The ARC is [blamed]({% pst 2014/oct/2014-10-12-who-is-software-architect %}) for all technical problems.
    The ARC approves all pull requests before we [can merge]({% pst 2014/jul/2014-07-21-read-only-master-branch %}) them.
    The ARC is the main point of contact in the project for the PO.
    The ARC makes all technical [decisions]({% pst 2015/jun/2015-06-29-simple-diagrams %}).
    The ARC [reports]({% pst 2015/may/2015-05-11-software-architect-responsibilities %}) to the PM.

  * **Developer** (`DEV`)
    is a programmer and is [responsible]({% pst 2014/apr/2014-04-13-no-obligations-principle %})
    for [closing bugs]({% pst 2014/nov/2014-11-24-principles-of-bug-tracking %}).
    The DEV reports to the PM.

  * **Requirements Analyst** (`REQ`)
    is responsible for the validation of the product.
    The REQ solicits [requirements]({% pst 2015/nov/2015-11-10-ten-mistakes-in-specs %}) from the PO.
    The REQ demonstrates the product to the PO.
    The REQ submits new bugs when validation fails and the product needs changes.
    The REQ reports to the PM.

  * **Quality Assurance** (`QA`)
    oversees the correctness of our process.
    The QA approves each closed task before it's officially closed by the PM.
    The QA ensures that our process complies to [our policy](https://www.zerocracy.com/policy.html).
    The QA reports to the PM.

  * **Tester** (`TST`)
    manually tests the product, finds bugs, and reports them.

Besides all that, any role is [encouraged]({% pst 2014/apr/2014-04-13-bugs-are-welcome %})
to submit bugs when they find them.
