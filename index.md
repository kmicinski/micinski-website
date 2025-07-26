---
layout: mainpage
---

## Research

My current goal is to help enable the next generation of scalable
logical and deductive frameworks that power static analyses, type
systems, and binary reverse engineering tools. We achieve this via a
combination of algorithmic innovations (including a semantic extension
of datalog to support hash-distributed structured data) and
fundamentally-new infrastructure at the systems level ([HPDC
'22](https://kmicinski.com/assets/optimizing-bruck.pdf), [Cluster
'23](https://kmicinski.com/assets/cluster23.pdf), and [USENIX ATC
'23](https://kmicinski.com/assets/atc23-shovon.pdf)).  My recent
interests have focused on high-performance implementations of
declarative languages to achieve these goals, specifically Datalog,
where I have supervised the construction of state-of-the-art engines
in both single-node ([CC '22](https://github.com/s-arash/ascent),
[OOPSLA '23](https://kmicinski.com/assets/byods.pdf)) and
[massively-parallel (CC
'21)](https://dl.acm.org/doi/10.1145/3446804.3446855) backends. As
concrete examples, our recent efforts have (a) scaled the performance
of control-flow analyses by orders-of-magnitude (seconds in our system
versus hours in Soufflé, a best-in-class Datalog engine), (b) built
all Windows C++ binaries on GitHub to train malware classification
tools (see [Assemblage](https://github.com/harp-lab/Assemblage)), and
(c) compiled lattice-oriented Datalog programs to achieve a 50x
runtime gain (vs. [Flix](https://flix.dev/)) using a [macro-based
approach in Rust](https://dl.acm.org/doi/abs/10.1145/3497776.3517779).

My [Google Scholar](https://scholar.google.com/citations?user=HpJLJWUAAAAJ&hl=en)
profile tracks my most up-to-date submissions.

<table id="mainpgvenn">
  <tr id="areastr">
    <td width="50%">
    <svg width="350" height="300" xmlns="http://www.w3.org/2000/svg">
        <circle fill-opacity=".4" r="100" cx="100" cy="100" fill="red" 
            id="circle1" />
    <text font-weight="bold" xml:space="preserve" 
        text-anchor="start" 
            font-family="Helvetica, Arial, sans-serif"
            font-size="24" 
            y="100" x="30" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#000000">Security</text>
    <circle fill-opacity=".4" r="100" cx="250" cy="100" fill="green" 
            id="circle2" />
    <text font-weight="bold" xml:space="preserve" 
        text-anchor="start" 
            font-family="Helvetica, Arial, sans-serif"
            font-size="24" 
            y="100" x="250" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#000000">PL</text>
    <circle fill-opacity=".4" r="100" cx="175" cy="200" fill="blue" 
            id="circle3" />
    <text font-weight="bold" xml:space="preserve" 
        text-anchor="start" 
            font-family="Helvetica, Arial, sans-serif"
            font-size="24" 
            y="235" x="125" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#000000">Systems</text>
   </svg>
   </td>
   <td id="areadesc">
       <div><h2 style="text-align:center">Areas I work in</h2><br />
           <h4 style="text-align:center">(mouse over)</h4>
      </div>
   </td>
   <td id="secdesc" class="areadescleft" style="display:none">
      <h3>Security</h3>
      <hr />
		  <p>I work on both <a href="https://www.react.uni-saarland.de/publications/post14.pdf">logics for security</a> and <a href="https://ieeexplore.ieee.org/document/9155136">formal methods to reason about a program's (in)security.</a>
</p>
   </td>
   <td id="pldesc" class="areadescleft" style="display:none">
      <h3>Programming Languages</h3>
      <hr />
      <p>I often work on programming language semantics and analysis thereof, 
	  often using techniques such as symbolic execution and abstract interpretation.</p>

      </td>
   <td id="hcidesc" class="areadescleft" style="display:none">
      <h3>Systems</h3>
      <hr />

      <p>A key part of our methodology is that we implement our techniques at the higest-possible scale (all of GitHub, production Android apps, stripped binaries). This often requires <a href="https://dl.acm.org/doi/10.1145/3502181.3531468">novel</a> systems-level innovation </p>

  </td>
  </tr>

</table>

## Sponsored Projects

- [NSF PPoSS Large: A Full-stack Approach to Declarative Analytics at Scale](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2316159&HistoricalAwards=false). National Science Foundation. Total: $1,000,037 (5 years)
- [NSF PPoSS Planning: A Full-stack Approach to Declarative Analytics at Scale](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2217037&HistoricalAwards=false). National Science Foundation. Total: $83,761 (1 year)
- [DARPA V-SPELLS: Verified Security and Performance Enhancement of Large Legacy Software](https://www.darpa.mil/news-events/2020-07-30). Defense Advance Research Projects Agency. Total: $400,000 (4 years)
- [Assemblage: Scaling Malware Analysis Pipelines](https://github.com/harp-lab/Assemblage). US Department of Defense. Total: $350,000 (3 years)

## PhD Students

- Arash Sahebolamri (graduated PhD, May 2023)
  - Dissertation: "Improving Logic Programming for Program Analysis."
- Yihao Sun (started PhD 2020)
- Chang Liu (started PhD 2023)
- Neda Abdolrahimi (started PhD 2023)

## Teaching

I teach CIS352, the undergraduate programming languages at Syracuse,
every Fall and Spring. The course lectures from Spring 2022's
iteration are available <a
href="https://www.youtube.com/playlist?list=PLXaqTeMx01E_eK1ZEpKvKL5KwSaj7cJW9">for
free on YouTube</a>.

- [Fall 2023](https://kmicinski.com/cis352-f23/)
- [Spring 2023](https://kmicinski.com/cis352-s23/)
- [Fall 2022](https://kmicinski.com/cis352-f22/)
- [Spring 2022](https://kmicinski.com/cis352-s22/)
- [Spring 2021](http://kmicinski.com/cis352-s21/)
- [Spring 2020](http://kmicinski.com/cis352-s20/)

Each fall I also teach a special topics seminar (CIS700 at Syracuse).
During Fall 2023, I'm teaching a course on [formal methods and modern symbolic AI](https://kmicinski.com/cis700-f23).

## Undergraduate Research and Theses

Note that I am particularly excited to collaborate with Syracuse
students. As you can likely tell from this page, my research is
generally in programming languages, but related areas (especially
computer security) also appeal to me. If you would like to pursue
undergraduate research, please drop me a line so we can discuss!

You should also read my thoughts on [goals and expectations for
undergraduate research](/undergrad-research-goals).

