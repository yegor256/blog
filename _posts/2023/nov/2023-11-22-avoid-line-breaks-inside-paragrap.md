---
layout: post
title: "Avoid Soft Line Breaks Inside a Paragraph"
date: 2023-11-22
place: Moscow, Russia
tags: mood
description: |
  Explicit line breaks inside a paragraph is a very 
  annoying typography mistake, which I strongly recommend to avoid.
keywords:
  - line breaks
  - explicit line break
  - soft return
  - newline inside paragraph
  - force line break
image: /images/2023/11/pret-a-porter.jpg
jb_picture:
  caption: Prêt-à-Porter (1994) by Robert Altman
---

An email, a document, a research paper, a presentation, and even a JavaDoc code block consist of
_paragraphs_, [which are](https://en.wikipedia.org/wiki/Paragraph) 
"self-contained units of discourse in writing dealing with a particular point or idea."
Visually, paragraphs are supposed to be separated by a vertical space that is a bit larger
than a vertical spacing between lines. To achieve this, for example, in HTML, we wrap paragraphs in the 
`<p>` tag, while in LaTeX, we use `\par` or just an empty line between them. However, some people insert
what [are called](https://en.wikipedia.org/wiki/Line_wrap_and_word_wrap) 
"_soft line breaks_" inside paragraphs---this is a bad practice that I suggest you stay away from.

<!--more-->

{% jb_picture_body %}

This is how a paragraph should look, in HTML (no soft breaks, just `<p>` and `</p>`):

<p style="color: green; width: 80%; font-family: monospace; font-size: 80%; line-height: 1.2em;">
&lt;p&gt;Tyler gets me a job as a waiter, after<br/> 
that Tyler's pushing a gun in my mouth and <br/>
saying, the first step to eternal life is you <br/>
have to die. For a long time though, Tyler <br/>
and I were best friends. People are always <br/>
asking, did I know about Tyler Durden.&lt;/p&gt;
</p>

This is how it would look with soft breaks (`<br/>`) after each sentence:

<p style="color: red; width: 80%; font-family: monospace; font-size: 80%; line-height: 1.2em;">
&lt;p&gt;Tyler gets me a job as a waiter, after <br/>
that Tyler's pushing a gun in my mouth and <br/>
saying, the first step to eternal life is you <br/>
have to die.<b>&lt;br/&gt;</b> <br/>
For a long time though, Tyler and I were best <br/>
friends.<b>&lt;br/&gt;</b><br/>
People are always asking, did I know about <br/>
Tyler Durden.&lt;/p&gt;
</p>

Don't do this.

Let the software format paragraphs for you, deciding where their lines
must break to form new lines. By injecting linebreaks into the body of
a paragraph, you express distrust in the document formatting software,
be it an HTML browser, a LaTeX compiler, or a Javadoc generator. In the end,
it looks ugly, because we are [much worse designers]({% pst 2019/may/2019-05-21-dont-improvise %}) 
than the creators of LaTeX or browsers.

