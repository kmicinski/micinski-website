---
layout: post
title:  "Writing tip: say the text back to you"
date:   2017-09-22
categories: writing
---

Here's the tip: have your computer read your writing back to
you. Listen to how it sounds. Then, iterate until it conveys what
you'd like to hear. On a mac, you can do this it like this:

    say -r words_per_minute "My speech goes here"

I do this to either:

- Read the text back to me quickly (`-r 240-270`). This helps follow
  along with a document in front of me and check it for flow. It also
  catches miswordings, (some) grammar errors, and typos.

- Close my eyes, sit back, and really try to absorb the text. I listen
  slowly, around 180-200 words per minute. This allows me to hear
  places where the text sounds awkward or redundant.

The book [BUGS in
Writing](https://www.amazon.com/BUGS-Writing-Revised-Guide-Debugging/dp/020137921X)
talks at length about developing an "ear" for good writing. While I
found the book's content useful, it's decidedly hard to be able to
objectively "hear" your own writing. I have a tough time divorcing the
process of reading from pondering over the endless ways I could
improve any given sentence.

I've found that listening to the text spoken back to you is a great
way to perform rapid prototyping on documents. For example, I wrote a
rough draft of this post, listened to it, and then restructured based
on what I heard. I don't think of myself as a naturally good
writer. Forcing myself to slow down and concentrate naturally shifts
my sentences towards being shorter and more concise.

Here's an example from the syllabus for my upcoming security course,
which I was editing today:

> To understand how attackers think, we will learn about the attacks
> they employ. But understanding a collection of attacks is not alone
> sufficient for helping us understand how to build secure systems. So
> alongside attacks, we will also cover the theory behind building
> defenses into our systems. We will dissect a number of real-world
> attacks (such as Heartbleed or WannaCry) and reflect upon what could
> have been done to prevent them. To complement these examples, will
> learn the theoretical underpinnings of security that apply across
> systems.

I spent some amount of time going over this text, but never really
"heard" it all together. When I did, I immediately identified the
problem: the paragraph was saying the same thing twice, breaking the
natural flow.

I then came up with this:

> To understand how attackers think, we will learn about the attacks
> they employ. We will dissect a number of real-world attacks (such as
> Heartbleed or WannaCry) and reflect upon what could have been done
> to prevent them. But understanding a collection of attacks is not
> alone sufficient for helping us understand how to build secure
> systems. So alongside attacks, we will also learn the theoretical
> underpinnings of security, and use it to build defenses into our
> systems.

Which sounds a lot better to me!

By the way, I learned this trick from Philip Guo:

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Do other people do this too? I often use text-to-speech to have my computer/phone read my own writing back to me to sense how it sounds</p>&mdash; Philip Guo (@pgbovine) <a href="https://twitter.com/pgbovine/status/910182577767514113">September 19, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

