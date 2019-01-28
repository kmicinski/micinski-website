---
layout: mainpage
---

## Research

My goal is to keep users secure as they use modern systems. This is a
challenging problem. Writing secure code is hard. Checking untrusted
code is even harder. Developers are not always incentivized towards
security. In some cases it is not always clear what security even
means.

For example, consider an app that shows users nearby coffee shops
frequented by their friends. Such an app may leak or store the user's
location (e.g., to an ad provider) in a way they do not
intend. Sometimes, the developer is not even aware they are violating
the user's privacy (for example, if the developer uses an ad library
and they are unaware it collects location data). Even if the developer
is aware of how location is being collected, users may not assume that
it is being stored permanently. My [research](/research) page outlines
some of the projects I'm currently involved in to address these
problems.

To help achieve this goal, I use techniques from the following areas:

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
      <p>Security is a broad area, but unified by a common challenge:
      identifying gaps between abstractions that allow potential
      attackers to exploit systems. I frequently use definitions from
      security such as <a
      href="https://en.wikipedia.org/wiki/Non-interference_(security)">noninterference</a>
      and techniques such as <a
      href="https://en.wikipedia.org/wiki/Process_isolation">process
      isolation</a>. My current work addresses key challenges in <a
      href="https://en.wikipedia.org/wiki/Reverse_engineering">reverse
      engineering</a></p>
   </td>
   <td id="pldesc" class="areadescleft" style="display:none">
      <h3>Programming Languages</h3>
      <hr />
      <p>Reasoning about a program's security requires being able to
      precisely define its
      behavior. <a href="https://en.wikipedia.org/wiki/Programming_language_theory">Programming language theory</a>
      allows us to treat programs as artifacts. I frequently use
      techniques from PL to define and reason about programs. Some of
      these techniques include
      <a href="https://en.wikipedia.org/wiki/Static_program_analysis">static analysis</a>
      <a href="https://en.wikipedia.org/wiki/Abstract_interpretation">abstract interpretation</a>
      and
      <a href="https://en.wikipedia.org/wiki/Symbolic_execution">symbolic execution</a>.</p>
      </td>
   <td id="hcidesc" class="areadescleft" style="display:none">
      <h3>Systems</h3>
      <hr />
      <p>Theory is useful for formally arguing about what security
      means and how to enforce it. But ultimately we want to <i>implement</i> our
      ideas in real systems. A core focus of my work is to build systems that solve
      challenging problems and scale their implementation to production systems.</p>
  </td>
  </tr>

</table>

I am lucky to have a great set of collaborators, many from the
[PLUM lab](https://github.com/plum-umd) at the University of
Maryland. You can find a list of my publications [here](/publications)
(and also on my
[Google Scholar](https://scholar.google.com/citations?user=HpJLJWUAAAAJ&hl=en)
profile).

### Undergraduate Research and Theses

Note that I am particularly excited to collaborate with Haverford
students. As you can likely tell from this page, my research is
generally in computer security, but related areas (or problems that
use techniques from these areas) might also appeal to me. If you are
planning to do a thesis (or simply generally interested in research),
please drop me a line so we can discuss!

You may be interested in browsing some of my
[undergraduate research ideas](/undergrad-research-ideas). I also have
a page on my
[goals and expectations for undergraduate research](/undergrad-research-goals),
which you might want to read.

## Teaching

- Fall 2018: [CMSC395: Mobile Apps for Social Change](http://kmicinski.com/mobile-apps/)
- Fall 2018: [CMSC107: Introduction to Computer Science and Data Structures](http://kmicinski.com/cs107/)
- Spring 2018: [CMSC311: Computer Security](http://www.kmicinski.com/cybersecurity-course)
- Fall 2017: [CMSC245: Principles of Programming Languages](http://www.kmicinski.com/cmsc245)
