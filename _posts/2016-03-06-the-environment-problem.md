---
layout: post
title:  "The Environment Problem and Abstract Counting"
date:   2016-03-06
categories: program-analysis
---

Over the weekend I attempted to read a paper by Matt Might called
[Logic Flow Analysis](http://matt.might.net/papers/might2007lfa.pdf). Logic
Flow Analysis promises to marry constraint solvers and abstract
interpretation so that they play off each other to produce better
analysis results. Unfortunately, I fell somewhat flat on this, as the
amount of technical detail in the paper is fairly overwhelming. So,
instead, I switched to a simplified version of the paper Matt
recommended I read instead: ["Shape Analysis in the Absence of Pointers
and Structure"](http://matt.might.net/papers/might2010shape.pdf). The
paper describes an important problem in program analysis I hadn't
realized before, and manages to do so in a fairly approachable manner
(meaning people like myself can read it). Or at least, as approachable
as a paper can be whilst still including lines like the following:

> Under anodization, bindings are not golden, but may be temporarily
> gold-plated.

Keep in mind, this is a (nominally, at least) a paper on programming
language theory, and not battery design.

# What's the paper about?

The paper is about showing that control flow analyses for functional
languages are insufficient to reason about properties we really might
want to know about because they neglect to take the structure of
environments into account. If you read traditional accounts of control
flow analysis, you'll see things like "function f flows to label 2"
and the like. One key point that Matt makes is that talking about
functions is insufficient, because it neglects to account for the fact
that it is *closures*, and not simply functions, that account for the
runtime behavior of the program. Control flow analysis is really good
about reasoning about how *functions* flow through programs, but
talking about environments is a separate issue.

As always, let's start with an example:

    (let ((f (lambda (x h)
      (if x
        (h)                ; Line 3
        (lambda () x)))))
      (f #t (f #f nil)))

Let's say that we want to optimize the program. We're going to do it
as follows: we're going to run a CFA and, if we see that there's only
one possible callee for a given call site (like `h` in line 3), we'll
replace it by the actual function that's called. We run CFA and
compute the set of functions that reach that point. What functions can
`h` be? `f` is called once with `nil`, so `h` could be `nil`, and then
`f` is called with the result of `(f #f nil)`, which is `(lambda ()
x)`. So if `h` is invoked, it will only ever be `(lambda () x)`,
meaning that we could inline that function in place of `h` in line 3. 

The problem is that doing this changes the meaning of the program:

    (let ((f (lambda (x h)
      (if x
        (lambda () x)
        (lambda () x)))))
      (f #t (f #f nil)))
     --> #t
    
The problem with the previous line of thought is that we didn't take
into account that the *first* invocation of `f` produces the closure
`<(lambda () x), {x |-> #f}>`, which is then subsequently fed in for
`h` in the second use of `f`.  When executed, the closure looks up x
from its environment and gets the value `#f` out.

Control flow analyses don't usually take the closure structure into
account. The paper makes the argument that we should think of this
so-called environment analysis as analogous to shape analysis.

# Stating the problem

The paper defines the semantics of a CPS-style lambda calculus using a
variant of the standard
[CESK](http://matt.might.net/articles/cesk-machines/) machine (leaving
off the K). The machine employs the standard
[AAM](http://matt.might.net/papers/vanhorn2010abstract.pdf)
abstraction, indirecting values through the store: environments map
variables to addresses, and the store maps addresses to values.  AAM
also adds some auxiliary information (called the *time*) to help the
analysis designer control which things in the program get "smushed
together:" e.g., calls with the same calling context (up to some
finite bound that represents sensitivity).

Unfortunately, when you play this trick of finitizing the store to get
a decidable analysis, you *lose* the ability to reason about how many
things have been "smushed together."

# Solving the problem: abstract counting

When we run our abstract interpretation, we end up with an abstract
environment `ρ^ : Var → Addr^`, that maps variables to *abstract*
addresses. The (abstract) store maps abstract addresses to abstract
values.  We want to determine, for `ρ` and `ρ'`, and some variable `x
∈ dom(ρ)`, if `σ(ρ(x)) = σ(ρ'(x))`. If we can successfully decide this
is true for all of the free variables (`x` in our example) in the term
(`(lambda () x)` in our example), then we can safely inline the
function. Unfortunately, in general, because `ρ(x)` represents to a
*set* of concrete values, we would have to decide that `∀ x, x'. x ∈ X
= x' ∈ X'`, where `X = α (σ(ρ(x)))`, the concretization of `σ(ρ(x))`,
and `X' = α (σ(ρ'(x)))`. Obviously this is false when the cardinality
of `X` or `X'` is greater than one.

The key insight is that we instrument the analysis to keep track of
"how many things have been smushed together" for a given location in
the store. In other words, we will add a bit of information to the
analysis to say that -- even though `|α(σ(ρ(x)))| > 1` in general, we
really know that it actually represents *only one* concrete
instantiation. We can do this by keeping a separate map, called the
`count`, that tracks how many things have been merged into the heap at
a given point. When we put something into the abstract store, we also
record its `count` as `1`, when we merge another thing at that
location, we increment the count. It turns out that our argument
really only works for singletons, so in general it really only helps
to know that a location's count is either one or greater than one.

This idea is what Matt calls abstract counting. In his paper he some
machinery to do what he calls *anodization* (remembering something has
a count of 1) and *deanodizing* (incrementing its count *past* one) a
value. I don't think this is very intuitive to me: instead I think
it's more clear to have an explicit count that tells us how many times
something has been abstracted.

This is a neat little trick that helps get past the problem: when
you're dealing with functions involving free variables, it's useful to
know how many different possible instances of things could be closed
over for a given variable. Knowing the answer seems generally useful
to designing analyses in the AAM style.

