---
layout: page
title: Basic Programming Concepts
subtitle:
comments: false
sharing: false
footer: false
sidebar: false 
---

<h3 id="first_steps" data-magellan-destination="first_steps">First Steps</h3>

This tutorial will teach you about the very basic concepts behind computer programming. If you know absolutely nothing about programming but you wanna make games,
this is the right place to start! Before we actually start, though, you have to download a few things:

**Text editor**: this is what you use to create files containing commands that the computer runs. You could use Notepad if you wanted to, since it can create files,
but there are text editors made just for programming that provide a lot of useful functionality. Two really good ones are: [Notepad++](http://notepad-plus-plus.org/) 
and [Sublime Text](http://www.sublimetext.com/).

**Lua**: Lua is a very beginner friendly language that is simple to understand, while being extremely powerful and expressible. 
If you use Windows, then you should install [Lua for Windows](http://code.google.com/p/luaforwindows/downloads/list). If you use OSX or Linux then you should already have Lua installed, 
and you can run its interpreter by typing <code>lua</code> in a terminal.

**LÖVE**: LÖVE is a 2D game making framework and it's what you use to draw things to the screen, receive input from a keyboard/mouse/gamepad, play sounds, and so on... It's also what Mogamett 
uses as the base for access to all of those functionalities. You can download it [here](http://love2d.org/).

This tutorial is divided in two parts. The first deals with basic programming concepts and uses only Lua. The second deals with applying those concepts into making a simple game, and uses
both Lua and LÖVE. By the end of reading this and following along on your own computer (**and also doing the exercises!!!**), you should have the skills to make simple games using LÖVE. 
Anyway, are you ready? Then let's go~!!!
<br>
<br>

<h3 id="program_structure" data-magellan-destination="program_structure">Program Structure</h3>

The structure of a program in any language usually follows the same set of rules:

<ul>
    <li> A file containing commands is given to the computer; </li>
    <li> The computer runs each command contained on the file, line by line, in a top down manner; </li>
    <li> The computer stops execution when it reaches the end of the file. </li> 
</ul>

So, to see that happening, let's first create a file. Open up your text editor and create a file named <code>numbers.lua</code>. In it, add the following commands
(the numbers to the left side are line number markers, they're not part of what you should add to the file):

~~~ lua
print(1)
print(2)
print(3)
~~~

To tell the computer to run the file, we're gonna use the Lua interpreter. You've installed it previously if you're on Windows (Lua for Windows). Open a terminal
(don't know how to do it? Google it) and change to the directory (Google it) where you created the <code>numbers.lua</code> file. After that, type <code>lua numbers.lua</code>, and
the numbers <code>1 2 3</code> should be printed to the screen, like in the image below:

{% img center /../../assets/numbers.png %}

What's happening here is exactly as the rules previously stated said. A file is given to the computer and the computer runs it line by line. In this case, each line's command is 
<code>print</code>, a function (I'll use function interchangeably with command from now on) which simply prints to the screen whatever you tell it to print. We're telling each print 
function to print one number, and so it does in the order we told it to. Each statement is independent of the other, such that if we remove <code>print(2)</code> then the output when 
you <code>lua numbers.lua</code> again will be <code>1 3</code>.

But we can tell the print function to print other types of things, like an addition, or a subtraction, or a string (google it)! Add these to your <code>numbers.lua</code> file, run it and see
the output. The <code>numbers.lua</code> file should look something like this:

~~~ lua
print(1)
print(2)
print(3)
print(2+2)
print(6-1)
print('Hello~!')
~~~

And the output something like this:

{% img center /../../assets/hello.png %}

Throughout all tutorials there will be exercises. Those exercises can be skipped if you feel like it, but you'll learn more processes and ways of behaving related to programming 
if you actually do them. The main goal behind doing them is making things stick in your head, as well as teaching you how to Google things. Googling is a big part of being a programmer and 
you should learn to look for answers on your own. You should be especially capable of creating a reasonable mental model of something by reading different explanations that you find on Google. 
All exercises have answers, but you should only look at those after you've actually tried answering them by means of Google or something else. **The answers, and to an extent, the questions, 
are not important. The process of coming to those answers is important. If you simply read the questions and read the answers, you will not have exercised what the exercise tries to exercise, 
and you will gain nothing out of it.** If you already know the answers, then just skip them until you start getting to exercises where you don't.


<dl class="accordion" data-accordion>
<dd>
<a href="#panel1">Exercises</a>
<div id="panel1" class="content">
<ol>
    <li> What's another way of running Lua programs? <br>
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel7">Answer</a>
        <div id="panel7" class="content answer">
            Using the interactive Lua interpreter.
        </div>
        </dd>
        </dl>
    </li>
    <li> What's a string and why does it have to be enclosed in quotes? <br>
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel8">Answer</a>
        <div id="panel8" class="content answer">
            A string is a sequence of characters (text data) and it has to be 
            enclosed in some way so that the computer (more specifically the compiler) can tell that it is text data instead of being a program command. 
        </div>
        </dd>
        </dl>
    </li>
    <li> What's the command line and how do you change directories using it? 
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel9">Answer</a>
        <div id="panel9" class="content answer">
            Command line interpreters are programs that take commands
            and act on them, much like normal programs. The normal terminals that you have on Windows, OSX and Linux simply implement a bunch of useful functions related
            to the operating system at hand. Such a function is cd, which changes the current directory to the directory provided as an argument to it. 
        </div>
        </dd>
        </dl>
    </li>
</ol>
</div>
</dd>
</dl>
<br>

<h3 id="variables" data-magellan-destination="variables">Variables</h3>

Computers are uncanilly good at remembering things. Unlike our mind's memory, which works in a fuzzy associative way, a computer's memory works more like a storage.
Except that it's a storage with perfect cataloging, cloning and teleporting powers: you know exactly where each package is and you can type in its address and press a button; the package is then
cloned and the copy is instantly teleported to you. Addresses for this storage usually look something like this: <code>0x3A28213A</code>, <code>0x6339392C</code>, <code>0x7363682E</code>, which 
are numbers using the hexadecimal numeral system. 

{% img center /../../assets/pointers.png %}

Remembering those numbers every time you want to get a package from the storage is extremely tiresome and difficult, though. So what early storage 
people did was add the ability to refer to a certain address by a name that they picked: this is called a <code>variable</code>.

~~~ lua
local a
a = 1
print(a)
~~~

Here <code>a</code> is a variable. The output of this piece of code, if you run it, is <code>1</code>, and to understand why that is I'll define two operations: 
<code>load</code> and <code>store</code>. Using the storage analogy, the <code>load</code> operation does the following: receive a handle/name, translate that handle into a storage address, 
clone the package contained in that address and teleport the copied package to a temporary location. The <code>store</code> operation does the following: receive a handle and a package, 
translate that handle into a storage address, teleport the package into the address, overwriting whatever other package was there.

So now we can understand, in terms of <code>load</code> and <code>store</code>, what's going on with the code sample up there.

~~~ lua
local a
~~~

The first line simply defines the <code>a</code> handle. This allocates a memory address that corresponds to this variable.

~~~ lua
a = 1
~~~

The second line is a <code>store</code> operation. In programming, <code>store</code> operations use a single <code>=</code> sign. So <code>a = 1</code> really means *a receives 1*
or *1 is stored in a*. The proper way of expressing this operation in terms of <code>store</code> would be: <code>store a, 1</code>.

~~~ lua
print(a)
~~~

The third line is the most complicated one. It does two things: a <code>load</code> operation and a function call.
The computer (more specifically the compiler) knows that <code>a</code> is a programmer defined handle and that it corresponds to a certain address in memory, and it also knows 
that the <code>print</code> function wants the value contained in that address. So what it does is: <code>load temp, a</code>. Here <code>temp</code> is a temporary location in which the value 
<code>1</code> (the value contained in the address of the handle <code>a</code>) will be held - there are many temporary locations available and we can use them freely. After that, when the 
<code>print</code> function does its job, it will use <code>temp</code> to fetch the value of <code>a</code>. And so then the value <code>1</code> is printed to the screen.

<dl class="accordion" data-accordion>
<dd>
<a href="#panel2">Exercises</a>
<div id="panel2" class="content">
<ol>
    <li> What's the output from the following commands? (do it yourself by hand first, run it after)<br><br>
<div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
<a href="#n2" name="n2">2</a>
<a href="#n3" name="n3">3</a>
<a href="#n4" name="n4">4</a>
<a href="#n5" name="n5">5</a>
</pre></td>
  <td class="code"><pre><span class="keyword">local</span> <span class="local-variable">a</span>
<span class="keyword">local</span> <span class="local-variable">b</span>
a = <span class="integer">1</span>
b = <span class="integer">2</span>
<span class="predefined">print</span>(a+b)
</pre></td>
</tr></table>
</div>
    <dl class="accordion" data-accordion>
    <dd>
    <a href="#panel3">Answer</a>
    <div id="panel3" class="content answer-code">
        local a; <br>
        local b; <br>
        store a, 1 (a is 1); <br>
        store b, 2 (b is 2); <br>
        load temp1, a (temp1 is 1); <br>
        load temp2, b (temp2 is 2); <br>
        print(temp1+temp2) (output is 3) <br>
    </div>
    </dd>
    </dl>
    </li>
    <br>
    <li> What's the output from the following commands?<br><br>
<div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
<a href="#n2" name="n2">2</a>
<a href="#n3" name="n3">3</a>
<a href="#n4" name="n4">4</a>
<a href="#n5" name="n5">5</a>
</pre></td>
  <td class="code"><pre><span class="keyword">local</span> <span class="local-variable">a</span>
<span class="keyword">local</span> <span class="local-variable">b</span>
a = <span class="integer">1</span>
b = a
<span class="predefined">print</span>(a+b)
</pre></td>
</tr></table>
</div>
    <dl class="accordion" data-accordion>
    <dd>
    <a href="#panel4">Answer</a>
    <div id="panel4" class="content answer-code">
        local a; <br>
        local b; <br>
        store a, 1 (a is 1); <br>
        load temp1, a (temp1 is 1); <br>
        store b, temp1 (b is 1); <br>
        load temp1, a (temp1 is 1); <br>
        load temp2, b (temp2 is 1); <br>
        print(temp1+temp2) (output is 2) <br>
    </div>
    </dd>
    </dl>
    </li>
    <br>
    <li> What's the output from the following commands?<br><br>
<div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
<a href="#n2" name="n2">2</a>
<a href="#n3" name="n3">3</a>
<a href="#n4" name="n4">4</a>
<a href="#n5" name="n5">5</a>
<a href="#n6" name="n6">6</a>
<a href="#n7" name="n7">7</a>
<a href="#n8" name="n8">8</a>
</pre></td>
  <td class="code"><pre><span class="keyword">local</span> <span class="local-variable">a</span>
<span class="keyword">local</span> <span class="local-variable">b</span>
<span class="keyword">local</span> <span class="local-variable">c</span>
a = <span class="integer">1</span>
b = a
c = a
a = <span class="integer">2</span>
<span class="predefined">print</span>(a+b-c)
</pre></td>
</tr></table>
</div>
    <dl class="accordion" data-accordion>
    <dd>
    <a href="#panel5">Answer</a>
    <div id="panel5" class="content answer-code">
        local a; <br>
        local b; <br>
        local c; <br>
        store a, 1 (a is 1); <br>
        load temp1, a (temp1 is 1); <br>
        store b, temp1 (b is 1); <br>
        store c, temp1 (c is 1); <br>
        store a, 2 (a is 2); <br>
        load temp1, a (temp1 is 2); <br>
        load temp2, b (temp2 is 1); <br>
        load temp3, c (temp3 is 1); <br>
        print(temp1+temp2-temp3) (output is 2) <br>
    </div>
    </dd>
    </dl>
    </li>
    <br>
    <li> What's the output from the following commands?<br><br>
<div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
<a href="#n2" name="n2">2</a>
<a href="#n3" name="n3">3</a>
<a href="#n4" name="n4">4</a>
<a href="#n5" name="n5">5</a>
<a href="#n6" name="n6">6</a>
<a href="#n7" name="n7">7</a>
<a href="#n8" name="n8">8</a>
<a href="#n9" name="n9">9</a>
<strong><a href="#n10" name="n10">10</a></strong>
<a href="#n11" name="n11">11</a>
</pre></td>
  <td class="code"><pre><span class="keyword">local</span> <span class="local-variable">a</span>
<span class="keyword">local</span> <span class="local-variable">b</span>
<span class="keyword">local</span> <span class="local-variable">c</span>
a = <span class="integer">3</span>
b = <span class="integer">2</span>
<span class="predefined">print</span>(a*b)
c = b
a = c
b = a
a = b
<span class="predefined">print</span>(a+b*c)
</pre></td>
</tr></table>
</div>
    <dl class="accordion" data-accordion>
    <dd>
    <a href="#panel6">Answer</a>
    <div id="panel6" class="content answer-code">
        local a; <br>
        local b; <br>
        local c; <br>
        store a, 3 (a is 3); <br>
        store b, 2 (b is 2); <br>
        load temp1, a (temp1 is 3); <br>
        load temp2, b (temp2 is 2); <br>
        print(temp1*temp2) (output is 6); <br>
        load temp1, c (temp1 is 2); <br>
        store c, temp1 (c is 2); <br>
        load temp1, c (temp1 is 2); <br>
        store a, temp1 (a is 2); <br>
        load temp1, a (temp1 is 2); <br>
        store b, temp1 (b is 2); <br>
        load temp1, b (temp1 is 2); <br>
        store a, temp1 (a is 2); <br>
        print(temp1+temp2*temp3) (output is 6, PEMDAS applies to programming as well)
    </div>
    </dd>
    </dl>
    </li>
    <br>

    <li> When a variable is not initialized, it contains garbage. Garbage means random values that polluted the memory address before the variable started pointing to it.
    In a language like C, when you create variable but don't assign any values to it right away, your variable will point to this garbage. In Lua, though, garbage is <code>nil</code>,
    a value that represents useless information. The <code>print</code> function prints <code>nil</code> with no problems. Mathematical operations fail and halt the program's
    execution if one of the values being operated upon is <code>nil</code>. With that in mind, what's the output of the following commands?<br><br>
<div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
<a href="#n2" name="n2">2</a>
<a href="#n3" name="n3">3</a>
<a href="#n4" name="n4">4</a>
<a href="#n5" name="n5">5</a>
<a href="#n6" name="n6">6</a>
<a href="#n7" name="n7">7</a>
<a href="#n8" name="n8">8</a>
</pre></td>
  <td class="code"><pre><span class="keyword">local</span> <span class="local-variable">a</span>
<span class="keyword">local</span> <span class="local-variable">b</span>
a = <span class="integer">2</span>
<span class="predefined">print</span>(b)
<span class="predefined">print</span>(a)
a = b
b = <span class="integer">4</span>
<span class="predefined">print</span>(a+b)
</pre></td>
</tr></table>
</div>
    <dl class="accordion" data-accordion>
    <dd>
    <a href="#panel10">Answer</a>
    <div id="panel10" class="content answer-code">
        local a; <br>
        local b; <br>
        store a, 2 (a is 2); <br>
        load temp1, b (temp1 is nil); <br>
        print(temp1) (output is nil); <br>
        load temp1, a (temp1 is 2); <br>
        print(temp1) (output is 2); <br>
        load temp1, b (temp1 is nil); <br>
        store a, temp1 (a is nil); <br>
        store b, 4 (b is 4); <br>
        load temp1, a (temp1 is nil); <br>
        load temp2, b (temp2 is 4); <br>
        print(temp1+temp2) (error, addition with nil breaks program execution)
    </div>
    </dd>
    </dl>
    </li>
    <br>

    <li>Assume that <code>print</code> and <code>local</code> are <code>operations</code>. Using only <code>load</code>, <code>store</code> and <code>operation</code>, what's the order 
    of execution of the following programs? (i.e. <code>operation</code>, <code>operation</code>, <code>load</code>, <code>store</code>, <code>operation</code>)  Additionally, what are the final
    values of <code>a</code>, <code>b</code> and <code>c</code>?<br><br>
<div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
<a href="#n2" name="n2">2</a>
<a href="#n3" name="n3">3</a>
<a href="#n4" name="n4">4</a>
<a href="#n5" name="n5">5</a>
<a href="#n6" name="n6">6</a>
<a href="#n7" name="n7">7</a>
<a href="#n8" name="n8">8</a>
<a href="#n9" name="n9">9</a>
<strong><a href="#n10" name="n10">10</a></strong>
<a href="#n11" name="n11">11</a>
<a href="#n12" name="n12">12</a>
<a href="#n13" name="n13">13</a>
</pre></td>
  <td class="code"><pre><span class="keyword">local</span> <span class="local-variable">a</span>
<span class="keyword">local</span> <span class="local-variable">b</span>
<span class="keyword">local</span> <span class="local-variable">c</span>
a = <span class="integer">1</span>
b = <span class="integer">2</span>
c = <span class="integer">3</span>
<span class="predefined">print</span>(a+b+c)
a = b+c*a
a = a+a
c = <span class="integer">2</span>*c
b = a+c
b = b+b
<span class="predefined">print</span>(a+b+c)
</pre></td>
</tr></table>
</div>
    <dl class="accordion" data-accordion>
    <dd>
    <a href="#panel11">Answer</a>
    <div id="panel11" class="content answer-code">
        operation <br>
        operation <br>
        operation <br>
        store <br>
        store <br>
        store <br>
        load <br>
        load <br>
        load <br>
        operation <br>
        load <br>
        load <br>
        load <br>
        store (in reality you can't do b+c*a in one instruction, like, store a, tempb+tempc*tempa, but since this is not what I'm covering here it's okay (albeit hand-wavey), if you're
        more interested look up how add, sub, mul and div assembly instructions work)
        load <br>
        store (can save one instruction since it's a+a) <br>
        load <br>
        store (2 is a value, doesn't need a load) <br>
        load <br>
        load <br>
        store <br>
        load (can save one instruction again since it's b+b) <br>
        store <br>
        load <br>
        load <br>
        load <br>
        operation <br>
        And the final values are: a = 10, b = 32 and c = 6
    </div>
    </dd>
    </dl>
    
    </li>
</ol>
</div>
</dd>
</dl>
<br>

<h3 id="types" data-magellan-destination="types">Types</h3>
