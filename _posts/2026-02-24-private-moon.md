---
layout: post
title:  "Your Own Private Moon"
date:   2026-01-06
permalink: "/your-own-private-moon"
categories: "ai"
---

This week I finally caved and bought the $200/mo subscription to
Claude Code and spent the next 16 hours glued to the screen. In the
first day of using it, I got my own homelab set up, including backups,
the firewall, configuring ssh and etc. I was able to get Claude to
build a setup with a reverse proxy that uses Authelia to gate all of
my personal (family) apps. Claude Code was trivially able to integrate
these apps with Authelia via `docker compose`, and also set up various
scripts like status checks (and `glances` to allow authenticated
remote monitoring), and scripts to reload services as I push new
releases to Git. By the end of the day, I had a complete homelab that
hosts my research notes, our science scheduling app, and our recipes /
shopping list app. I noticed all of the side effects of LLM psychosis:
unimpeded focus, feelings of extreme energy boost, etc. I ended up
going to sleep at 3AM, after having made more progress (at least on
devops for my homelab) than I had in the last year.

I am truly not quite sure what to think. The conventional wisdom (at
least the one I believe in) says this: symbolic, constraint-based
domain knowledge will always demonstrate an exponential gap compared
to probabilistic approaches such as self attention. Unfortunately, I
worry about the following: in every circumstance where we apply
domain-specific, symbolic, algorithmic approaches to AI, we end up
losing to the next frontier model in a loop with relatively simple
verifiers. For folks like myself, we are wondering: is there still an
asymptotic gap in practice?

Of course, exact reasoning isn't going anywhere, because the material
reality is that we do live in a world with ground truth: student
records represent real-life grades, customer data is an extremely rich
source of information (we don't want to make that up!). So I think
it's fair to say that there will still be a demand for databases. But
even these applications can be handled relatively automatically now
with Claude, so that users can communicate to them in plain English.

At first I told myself something like: "well sure, the AI could make a
functionally-consistent app but it doesn't have _taste_, or: it will
get stuck in _non-functional_ aspects like security." Frankly, these
things are probably true right now. But I am increasingly convinced
that they will not be for long, since there will be a good amount of
demand for focusing on those workloads, and at this point (I'm sorry)
I really do expect AI is already writing more secure code than many
programmers (remember, lots of people proudly write in C, I love C but
come on, you can't use that language without serious fear). 




