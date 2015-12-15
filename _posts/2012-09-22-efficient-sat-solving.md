---
layout: post
title:  "Efficient SAT Solving"
date:   2012-09-22
categories: algorithms sat
---

The [Boolean satisfiability problem](http://en.wikipedia.org/wiki/Boolean_satisfiability_problem) is simply stated:

> Given a set of propositional formulas, decide whether or not there is an assignment to the variables in the formula such that the formula is satisfied (true).

This basically says: given a large set of constraints with AND and ORs, can you find a solution to the set of constraints. Interestingly, this was the first example of a problem known to be NP complete. As such, many classic problems can be reduced to SAT. The common stigma among computer science students is that if a problem is [NP complete](http://en.wikipedia.org/wiki/NP-complete), you’re basically out of luck, and shouldn’t bother trying to find a better solution. However, this is far from the case, as demonstrated by the amazing advances made in industrial strength SAT solvers! There will always be evil instances of the SAT problem, but in reality, we can solve the SAT problem relatively efficiently.

So, SAT serves a number of purposes:

- In some theoretical sense, it’s nice to know that we can reduce many other problems to SAT, it gives the problem a sort of mathematical relevance. (There are problems we can’t reduce to SAT, problems harder than NP complete, [co-NP compete](http://en.wikipedia.org/wiki/Co-NP-complete) problems and the [Polynomial hierarchy](http://en.wikipedia.org/wiki/Polynomial_hierarchy) are examples!)

- We can use this reducibility in our proofs about NP complete problems, encoding other problems in the form of SAT.

- Going beyond this, there is a real use of SAT in the real world! We can encode other problems in SAT, and then use a SAT solver to find a solution to these problems!

For a long time, the reducibility of SAT was merely of theoretical interest: even if we were able to reduce other problems to SAT, the SAT instances were still relatively huge, containing a great number of clauses and variables. The could not be realistically solved. And then something changed: computers started getting faster, people started caring about using SAT to encode their problem and then solving it with an efficient solver. Along with the development of faster hardware came better techniques for solving SAT, and I wanted to point out a few of them here.

There’s an obvious algorithm for solving SAT: try all the possible assignments of the variables until you find one that works, if you don’t then it’s not satisfiable. Improving on this, there’s a slightly smarter algorithm, known as the [DPLL algorithm](http://en.wikipedia.org/wiki/DPLL_algorithm). You can read the wikipedia page to find more information about this one, but I can give the basic overview.

- Start with a large list of clauses, these are sets of literals that are connected with ORs, the formula is taken as the conjunction of all of these clauses. So for example:

    [x1, ~x2][x2, ~x3, x1] [~x3, ~x1]

That formula says, “x1 or NOT x2,” AND “x2, or NOT x3, or x1,” AND “NOT x3 or NOT x1.” This formula has multiple satisfying assignments, one of them being [x1=T,x3=F,x2=F].

- Construct a partial assignment. Initially this will have no variables assigned. For example, the assignment {} means that no variables have been assigned. Call this assignment set A. Start with A={}.

- Check to see if the formula is satisfied by A.

- Check to see there are any empty disjunctions, if so return false and go back to try again.

- Choose a random variable in the formula but not in A. Chose a value for it.

- Do *unit propagation*. This is best shown by an example. Let’s say that we have the partial assignment {x1=F}. Now look at the first clause in our formula. Eventually it has to be true. This means that x2 must be false. Why? Consider it weren’t, then we know there would be no way to satisfy all of the clauses in our formula.

- After doing unit propagation, go back to step 3 again and again, and backtrack until you either try all the combinations of variables, or you find a satisfying assignment.

Let’s try an example:

- We set A={}.

- We see if the formula is satisfied by A. Is it? Well, no, because A doesn’t assign any variables.

- Randomly pick x1, randomly assign it to be false. Now A={x1=F}.

- Do unit propagation. Look at the first formula. Oh no! We find that now x2 has to be F or there is no way our assignment will work! So now A={x1=F,x2=F}.

- Let’s look at the other formulas: Oh no!, we now find that x3 must also be false, otherwise the second clause won’t work! So now A={x1=F,x2=F,x3=F}. Now we have no other variables to pick.

- We check to see if that assignment works on our last clause, it does! So now we have a satisfying assignment.

But let’s say that it hadn’t worked. Let’s say that our last clause had been something like [x3, ~x1]. We would have backtracked and kept trying assignments.

This algorithm lets you kind of gradually fill out a partial assignment, and the same technique can be used in many other problems within complexity (browse any complexity book, we used [Aorara and Barak’s](http://www.cs.princeton.edu/theory/complexity/) book in my class.

Although DPLL does pretty well, it still didn’t work well enough (when implemented naively) to solve real problems quickly enough, which is why I’ll focus now on how you can beef it up to really make it kick so serious ass. First, why do you want to do this?

- You can use SAT to encode [bounded model checking](http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.19.6391), which asks questions about stateful software systems. This has seen much use in the hardware verification industry, for example!

- SAT forms the basis for [SMT solving](http://en.wikipedia.org/wiki/Satisfiability_Modulo_Theories). These are theories that combine SAT with more expressive theories, such as linear arithmetic or models of pointer logics. SMT solvers are the underlying technology behind many static analysis engines, so they

- You can encode many other SAT problems, such as graph isomorphism, maximum cut, etc…, in the form of SAT. While many of these problems have more specialized decision procedures for their domain specific applications, SAT is still a favorite way to solve hard problems, as long as you can find a suitable encoding. (Last semester my advisor and some other students considered using a SAT encoding to solve a type checking problem, I believe…?)

For these wide range of applications, SAT has gained a reputation as the “assembly language of hard problems.” However, it wasn’t until rather recently that the really killer SAT techniques came along. Before that, classic problems such as [symbolic execution](http://en.wikipedia.org/wiki/Symbolic_execution) were infeasible.

The real breakthrough in SAT solving technology came in a few forms:

- *clause learning* really helped out efficiency: when you got to an assignment which didn’t work, you would add it as a clause in your database. This helps prune part of the search space very quickly. The question (or optimization) then becomes which clauses to learn. Some clauses are more helpful than others, some portions of the search space are pushed on much harder, you really want to include clauses which help you prune as much of the search space as possible, without including a bunch of useless clauses. (Adding a new clause can hurt you, because you will forevermore have to do unit propagation on that clause, slowing down your procedure.) The best techniques use elaborate heuristics to determine which clauses should be learned, and forget various learned clauses if they seem to not be very helpful in pruning the space.

- At the same time, non chronological backtracking became a huge deal within the SAT solving community. This was the idea that: hey, don’t just jump back to the most recent assignment, go back a bunch of assignments. What’s the intuition here? Some variables matter a lot more than others, if you choose one variable badly, they can really start hurting your search, don’t waste time in a bad portion of the search space when you’re already hosed because you made a bad decision a long time ago!

- Variable selection heuristics also really help. This basically gives some method to our madness in my step 5. Instead of choosing a variable to select at random, you can make a very well reasoned and well informed decision by using some good information. There are few of these heuristics, but off the top of my head I can think of VSIDS, which is used in the Chaff algorithm (implemented in the zChaff solver). zChaff was one of the first real killers in the new SAT solvers, and really worth looking into.

- There are some very smart tricks that you can play with the data structures representing SAT formulas within a solver, making it much quicker to do unit clause propagation. For example the “two watched literals” approach allows unit propagation to be quite speedy!

These breakthroughs have actually made SAT solving quite quick, such that we can now solve formulas with hundreds of thousands of variables (and millions of clauses!) in them! All of these techniques tweak the DPLL algorithm with various improvements: at the core it’s still the same basic procedure, with a few optimizations on the selection heuristics, clause database, etc… It’s also worth noting that there are hill climbing heuristics (notably WalkSAT and its variants), these are not sound: if a satisfying assignment does not exist, these solvers cannot determine so. For this reason (and the fact that SAT has seen some real speedups in the last twenty years!), these non DPLL based algorithms kind of fell by the wayside, however, these procedures do present promise for the case of MAX SAT, where you want to find (an approximation to) the assignment that satisfies the most clauses. However, the class of real world problems which MAXSAT solves is smaller than SAT, so I haven’t seen as much attention on it lately..

If you want to learn more about SAT, I’d recommend the following:

There is a [Decision Procedures](http://www.springer.com/computer/theoretical+computer+science/book/978-3-540-74104-6) book that you can read! Honestly, I own this, and it’s not really all that great. It does, however, contain a relatively readable explanation of how SAT works, along with the techniques for solving it rather quickly.

There is an international [SAT competition](http://www.satcompetition.org/)! This competition has been instrumental in advancing the state of the art for high performance industrial strength SAT solvers. It’s worth browsing through the improvements over the years to the various solvers, along with the problem sets that are used to test various SAT solvers. (For example, some problems come from constraints generated by bounded model checkers, some come from graph algorithms, etc…)

A real transformational read for me was the paper that describes the implementation of the [MiniSat](http://www.cs.umd.edu/~micinski/posts/minisat.se) solver. This is a high powered solver (it took the world cup a few times!) that a simple (and small!) implementation. I would recommend reading the solver’s source (written in simple C++) next to the [paper that describes MiniSat’s implemenation](http://minisat.se/downloads/MiniSat.pdf)!

SAT solving is a fun passtime, there are lots of small simple tricks you can play, and becoming well versed in the developments isn’t all that hard. Perhaps more enticing is the knowledge that you can take a difficult problem and model it in SAT, and then farm it out to one of these quite excellent tools and get your problem solved for you!

