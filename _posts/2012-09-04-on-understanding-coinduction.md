---
layout: post
title:  "On Understanding Coinduction"
date:   2012-09-04
categories: coinduction functional-programming
---

Here’s the basic story:

> Induction is about finite data, co-induction is about infinite data.

The typical example of infinite data is the type of a lazy list (a
stream). For example, lets say that we have the following object in
memory:

    let (pi : int list) = (* some function which computes the digits of pi. *)

The computer can’t hold all of pi, because it only has a finite amount
of memory! But what it can do is hold a finite program, which will
produce any arbitrarily long expansion of pi that you desire. As long
as you only use finite pieces of the list, you can compute with that
infinite list as much as you need. However, consider the following
program:

    let print_third_element (k : int list) =
      match k with
        | _ :: _ :: thd :: tl -> print thd

    print_third_element pi

What does this program do? Intuitively, this program should print the
third digit of `pi`. In reality, the behavior differs between
languages. In OCaml, any argument to a function is evaluated before
being passed into a function (so called strict evaluation). If we use
this reduction order, then our above program will run forever
computing the digits of `pi` before it can be passed to our printer
function (which never happens). Since the machine does not have
infinite memory, the program will eventually run out of memory and
crash. However, morally this might not be the best evaluation
order. Our program does not use all of the sequence `pi`, it uses only
the third element. Other languages (most notably, Haskell) use a lazy
evaluation order, in which functions are evaluated only as much as
they need be so that further computation can be done.

There are other examples of infinite structures in computing as well: any program which runs forever (a so called, process) is typically defined in a similar manner. Operating systems, web servers, text editors, and most other interesting programs. The basic idea behind these processes is closely tied to the example given above: rather than being specified by recursive calls, these processes are modeled as co-recursive calls (with their associated co inductive types).

I’m not prepared to explain coinduction in it’s full generality, but I wanted to give some pointers to literature that introduces it. One basic story is clear:

> Inductive structures form least fixed points, and coinductive structures form greatest fixed points.

While this tag line is used all over the place, it’s not really clear
in what sense (co)inductive form fixed points, and it’s really not
clear how one fixed point would be “larger” than another. The answer,
as it turns out, is somewhat involved and deals with a bit of algebra:
specifically, treating inductive and coinductive types as forming
algebras (sets with operations on those sets) with certain properties
that you use to define recursive functions and inductive proof
principles.

I’ll assume that you’re familiar with regular old induction, and
recursive definitions of functions. The following definition suffices
to think about corecursive functions:

> Recursive functions break apart finite data, co-recursive functions build infinite data.

I think this seems strange to people who haven’t seen it before (it still seems strange to me):

- The need for infinite data is not clear to those who have never used it. We wrote programs without using infinite data, why use it?

- We can’t physically hold infinite objects in memory. By contrast, we can hold finite data in memory. It seems kind of crazy that we should be able to hold an infinite object in memory. Here’s something to alleviate your understandable discomfort: let’s say we have an infinite loop in a program which outputs a long sequence of (unknown) digits (say, pi). Can we keep the output of this program in memory? Not all of it. So what do we do instead? We keep the (finite) program (the code of the loop) which generates the object in memory.

- We don’t ever use all of the infinite object in our programs, we only ever use a finite prefix of an infinite object.

Coinduction is cool, however, because it opens the gateway to a whole different side of viewing datatypes and computation. Most datatypes that we work with also have an analogue that can be thought of as a “lazy” type, sometimes the silver bullet in implementing elegant algorithms, amortized bounds, or cute programming tricks (as in Chris Okasaki’s [Purely Functional Data Structures](http://www.amazon.com/Purely-Functional-Structures-Chris-Okasaki/dp/0521663504)).

Another thing which I’ve always been fascinated is the idea that we can represent computation over arbitrarily sized things with finite space. This is the whole notion underpinning loops, which desugar to fixed points, which desugar to similar interpretations to what I’ve been describing here. When the computation is meantf to terminate, these loops take finite data, do some computation over it in some computation time (complexity) parameterized by (typically) the size of the input. This is the idea of how we give semantics to loops, though in reality loops do not always terminate, and in reality many programming languages are given “big step” (coinductive) semantics! Here we can see a cute connection between a desugaring of a programming language’s semantics and the data structures that can live inside languages.

In what follows, I discuss various techniques that you might use to learn about coinduction. I would suggest that you take the following approach:

- Learn a few common lazy data structures in different languages (say, Haskell, OCaml, and JavaScript). Enough to get the idea.

- Spend some time thinking about what infinite data structures are, and then puzzle over what an infinite proof might look like and why you would use one.

- Pull out a theorem prover and work through some exercises in Coq that deal with coinduction. Read the CPDT or the Coq’Art book and work the examples aside the text.

- After spending some time thinking over those, read the total functional programming paper.

- To go even lower level, sit down at a coffeeshop and transcribe the tutorial paper on coalgebras and coinduction.

- Go back to the examples in Coq, rework all of them, and spend a while thinking about and implementing your own (I’m on this step :-).

# The data structures approach

To actually learn about coinduction by analogy to familiar programming structures, you might learn about lazy data structures, or lazy languages:

- Chris Okasaki’s Purely Functional Data Structures book contains a number of interesting data structures that rely heavily on the use of laziness to guarantee their amortized bounds.

- The [Haskell wiki book](http://en.wikibooks.org/wiki/Haskell) always has interesting things to say about the language, as well as the archives of the actual Haskell wiki and mailing list.

- Any other Haskell book or reference will surely have a lot to say..

- The implementation of the [Spineless Tagless G-machine](http://research.microsoft.com/apps/pubs/default.aspx?id=67083) gives a good perspective on how thunks are used to implement lazy evaluation within Haskell. (I have not read all of that, yet..)

# Learning with a theorem prover

The first time I encountered coinduction was some time ago in Adam Chlipala’s book [Certified Programming with Dependent Types](http://adam.chlipala.net/cpdt/). It was introduced within the context of infite data and proofs:

- The CPDT’s [Coinductive.v](http://adam.chlipala.net/cpdt/html/Coinductive.html) chapter contains a number of good pragmatic examples of coinduction. I find it invaluable to actually play with examples of things before thinking about them more. (I would suspect this is the case with most others as well..)

- [Coq’Art](http://www.labri.fr/perso/casteran/CoqArt/index.html) has an excellent chapter (chapter 13) on coinduction, which complements the CPDT quite well! I would recommend reading it multiple times. In general Coq’Art is an excellent book on not only Coq, but also serves as a great introduction to constructive logic as well!

- Play around with the examples, rinse and repeat.

# The Total Functional Programming paper

Turner has a great paper:

> Total Functional Programming, D.A.Turner. Journal of Universal
> Computer Science, vol. 10, no 7 (2004), 751-768.

I would *really, really* recommend reading this paper. It’s quite easy to read, and gives some good perspective on why induction, coinduction, and totality matter. The paper also highlights some of the finer points dealing with termination of functional programming that might not have been immediately obvious to you.

# Reasoning about structure

Undergrads in math typically take courses in abstract algebra: the study of the structure of mathematical objects. For example, we look at groups (structures where we can multiply things), rings (structures where we can multiply things and add things), etc… It turns out that this mirrors a very similar concept in programming languages:

    data Tree a =
      | Leaf of a
      | Node of Tree a * a * Tree a

In this case, we define two constructors for the type (Leaf and `Node), which naturally generate two destructors:

    let get_leaf = function
      | Leaf a -> a

    let get_node = function
      | Node n -> n

There’s one intricacy to note here: we have to be sure that we never try to use `get_leaf` with something of the form `Node (...) 32 (...)` (assuming we bind `a` to `int`, for example).

So let’s take a step back here: when you define algebras in your abstract algebra class, you define a carrier set along with the operations on that set. (Perhaps more importantly, you also define certain laws those operations satisfy, but that’s a part of the story that’s not encoded in the simple structure, and another story.) This is the same thing we do in this case: defining a type by means of it’s constructors and destructors. This motivates the algebraic interpretation of the “regular types:” types formed from sums and products of other regular types. (I’m not sure on the terminology, it comes from one of [Conor Mcbride’s](http://strictlypositive.org/) papers though surely elsewhere.) These structures actually form algebras: with a carrier set and collection of operations over that set. All of this reason comes from a categorical interpretation of datatypes, but the following paper explains it quite nicely:

> A Tutorial on (Co)Algebras and (Co)Induction, Bart Jacobs and Jan
> Rutten, EATCS Bulletin, v62, p62--222, 1997.

The paper presents the following:

- Coinduction at a high level

- Examples of processes and coinductive data structures.

- The categorial interpretation of regular data types as functors and their associated algebras.

- Use of these to establish recursive definitions of functions.

- Use of these to do inductive proofs of propositions about data of that type.

- Using this to do that same stuff with coinductive and inductive types.

The thing I like most about the paper is that while the concepts it touches deal with slightly nontrivial category theory, they explain the concepts within the category of sets (the category of sets form one of the simpler examples of a [category](http://en.wikipedia.org/wiki/Category_(mathematics))). This is great for actually understanding stuff, and if you want to jump up to more category theory later you always can.

# About Bisimulation

One thing that you’ll see no matter what in your studies on coinductive types is the notion of a bisimulation. I won’t say exactly what this is, but I will offer a simple explanation of why we need it. Look at the definition of equality in Coq, it’s an `Inductive` type `eq` that (when instantiated properly) forms something in `Prop` (a proof). It should make sense that, using only the standard rules of convertability within Coq, we cannot demonstrate two infinite objects are equal. To deal with this, we define a new (relaxed) notion of equality: the bisimulation. The basic story about a bisimulation is:

> If two (potentially infinite) objects are bisimilar, any two arbitrarily sized finite expansins of those objects will be identical.

This mirrors the use of lazy datatypes. We can’t really speak about
equality, because the objects are infintie in size, but we can say
that, “well, for all intents and purposes, whenever we need to compute
with this infinitely sized thing, it’s going to be all right.”

# Conclusion

This is a somewhat shoddy write up on my thoughts on learning coinduction. It’s something I’ve wanted to share for a while, but also something I think may be helpful for others trying to learn about the couniverse. It’s an interesting area, and has applications to speeding up your data structures, cleaning up your implementation, understanding process calculi, defining programming language semantics, and so much more. For me, I tried most of these steps over and over, peeling back another onion layer, and still haven’t made it to the core yet. I suppose, as long as it happens inside the constructor of the peel, that may just (perhaps ironically) be the sate of things.

