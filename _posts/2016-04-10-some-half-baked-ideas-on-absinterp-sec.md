---
layout: post
title:  "Half-Baked Ideas on The Future of Static Analysis and Security"
date:   2016-03-10
categories: security
---

It is well known that security policies for programs (such as
[noninterference]) are not properties of a single run, but rather of
properties about sets of runs. For example, the following program uses
a so-called *implicit* flow to exfiltrate the value of its secret
input:

    input(secret)
    if (secret == 0) then
        output(1)
    else
        output(0)

This program is bad because it leaks something (one bit of knowledge)
about its input: whether or not it is zero. Informally, a program that
consumes a secret output and produces a publicly observable output is
only secure if that ouput is a constant. Because most programs that
produce constant outputs are not useful, this definition is often
upgraded to a program that takes a public and private input. The
program is then secure if &mdash; for any *fixed* public input iᵖ
&mdash; and all secret inputs iˢ, the program produces a fixed output
o. Simple batch programs are boring and unrealistic, so there are a
number of ways in which we can upgrade these definitions to more
realistic programs. This is called noninterference, and it is not a
property of single executions, but rather a property of a *set* of
executions.

My intention with this post is to make the argument that we are not
being as systematic as we could be about constructing program analyses
based on our security definitions.

[Hyperproperties] offer a general framework for discussing these
properties on sets of program exectuions.  But hyperproperties only
give us the means to define what it means for a program to be secure,
they don't give us a tractable mechanism for checking program
security. It's also worth noting that hyperproperties do have some
applications beyond merely security properties. They can reason about,
e.g., properties of concurrent executions or program
refinement. Clearly, the idea of checking sets of program executions
is not radical, but doing so has proved difficult and impractical.

To check programs for security definitions like noninterference, a
variety of mechanisms have been proposed. Perhaps the most popular in
the literature has been security-typed languages, where types encode
which information can flow to which sources and whose type systems
enforce the security gaurentee. [Jif] and [lio] are notable examples
that fall into this category.

Checking properties about programs has a rich history in programming
languages, that have established a variety of fields: static analysis,
type theory, and model checking to name a few. Most of these
techniques were originally developed with the intention of checking
facts about single-run program properties (e.g., pointer analysis,
taint analysis, etc..). Applying them to security is often nonobvious,
because they have to be adapted to talk about *sets* of program runs.

Figuring out how to upgrade our single-run techniques to reason about
sets of runs has been the theme of a lot of security research:

- Security type systems (like the ones in Jif) use type-based
techniques to give a composable way to reason about security of a
program from smaller components, just as type systems have done for
traditional properties like type correctness and resource usage
(linear logic).

- [Faceted execution](https://users.soe.ucsc.edu/~cormac/papers/popl12b.pdf)
(as seen in languages like
[Jeeves](https://projects.csail.mit.edu/jeeves/)) is a method of
enforcing program security dynamically. It uses an upgraded form of
taint tracking to reason about what information has influenced
computation of variables. Then it uses this to show observers a view
of the computation that ensures they don't learn secret inputs. This
is analogous to inline reference monitors for policies like "the
network can never be accessed after the file is read."

- Relational program verifiection reasons about pairs of program
components (like functions that manipulate heaps) in isolation and
glues them together using composition. An example of this is
[Relational F*](http://research.microsoft.com/apps/pubs/default.aspx?id=204802),
which uses dependent types to specify program behavior on pairs of
input states and relates their output states.

- [Hyper temporal logics](http://www.cs.cornell.edu/~clarkson/papers/clarkson_hyper_tl.pdf)
  levels up standard notions of model checking to apply them to
  checking temporal logic hyperproperties. That work includes a notion
  of model checking that begins by taking the program and modeling it
  as a state space of a single execution, and then runs a product
  semantics for it, showing how to systematically use this semantics
  to check hyper properties about temporal assertions on state
  sets. This allows a rich encoding for many trace-based
  hyperoproperties such as generalized noninterference and
  observational determinism.

## The Future: Push Button Security Checking

One thing that I think is lacking in security currently is that our
analyses are only tenuously tied to the properties we want to
check. There's no systematic way to go from a semantics and fact to a
way to check facts about those properties for programs. Instead, we
see lots of one-off security definitions, and lots of tools for
checking definitions, but we rarely see security statements along with
a systematically derived mechanism to check facts about those
programs. This is an area I think we as a field could improve on.

Within PL, the
[abstracting abstracting machines](http://matt.might.net/papers/vanhorn2010abstract.pdf)
technique to deriving abstract interpreters has this flavor. You find
the semantics you want to check, bake in the facts you want to check,
and then systematically derive an abstract interpreter in a cookbook
style. But we have no such bushbutton methodology for checking
security properties of programs. As a designer of a system for
security today, you have to read the vast literature on the set of
security properties you might want to check, find one that suits you,
and *then* dream up an enforcement technique for whatever language you
want to work with.

I'm not sure exactly what this would look like. But I think it's going
to be something like this: write down the semantics for the program
you want, and then manipulate the semantics in some way to get a state
space representing what you want. Then, perform a simple abstraction
over that state space to get the properties you want to check.

Here's how I think this might work. First, you could imagine taking
your semantics and simply running it in parallel with another version
of the program, so that the concrete state space is now a product
space. Hyperproperties that rely on program pairs can be specified
using sets of concrete runs. Now abstract the program using our AAM
trick and get an abstract state space that is lifted to each component
of the pair. Abstract states concretize to pairs of concrete runs, and
now checking properties of executions means extending these properties
to work on our abstract domain, however they are represented. E.g., if
they are represented as symbolic states in a symbolic executor, you
would write symbolic formulas asserting noninterference, though
certainly other forms are possible. It's also worth noting that this
works for more than just pairs, you could also imagine doing it for
triples to check properties like generalized noninterference.

The abstraction technique I proposed is running a product program and
then doing the abstraction pointwise over each pair component. I think
this is a good first cut because it is easier to see how it relates to
the extensional property we want to check: simply check the property
by concretizing each point in the abstract state product and running
it through the formula. I'm not sure whether or not this technique
will scale to larger programs.

One thing that's missing from this technique is that the abstraction
doesn't know anything about the property we want to check, the
abstraction is simply pointwise and the abstract domain hasn't been
efficiently engineered to be tailored to semantic knowlege about the
program. But I think this is the right place to start, because it
gives us an intuitive baseline for our abstraction.

Let's say that we want to level this technique up. We would want an
abstraction that *does* know things about how the program is
operating. Here's how I think we might do that for the specific case
of noninterference checking: run the original program under a faceted
execution semantics with faceted values for the inputs we care
about. The faceted semantics is implicitly unrolling this product
program when it needs to to gaurentee that our security needs are
met. If we want to check whether the program is secure, we simply need
to look at the output and ask whether or not it is a faceted value. If
it is, we still might be able to do something. Let's say, for example,
that we can prove the faceted value produces the same result no matter
what the principle. If we can do this, we can still gaurentee the
program doesn't leak any information. 

I'm not sure why this intuition holds, but I have a feeling that it's
because the facet refines the "dumb" product semantics so that it does
the product behavior only when necessary. Frankly, I'm not sure if
this single case generalizes to the intuition about other sorts of
hyperproperties. But I this story of systematically deriving abstract
interpreters for security properties is very appealing, and one that
we should continue to push on.

[noninterference]:https://en.wikipedia.org/wiki/Non-interference_(security)
[hyperproperties]:https://www.cs.cornell.edu/fbs/publications/Hyperproperties.pdf
[Jif]:http://www.cs.cornell.edu/jif/
[lio]:https://hackage.haskell.org/package/lio
