---
layout: page
title: Text 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

<h3 id="example" data-magellan-destination="example">Example</h3>
~~~ lua
-- create a table holding text settings
TextConfig = {
    font = love.graphics.newFont('Moon Flower Bold.ttf', 72)
    increasingRed = function(dt, c) love.graphics.setColor(c.position*10, 128, 128) end
    wavyInit = function(c) c.t = 0 end,
    wavy = function(dt, c)
        c.t = c.t + dt
        c.y = c.y + 100*math.cos(c.position/4 + 4*c.t)*dt
    end
}

-- create the text
text = mg.Text('[BLUE BLUE RED RED RED](wavy; increasingRed)', TextConfig)

-- update the text
text:update(dt)

-- draw the text
text:draw(x, y)
-- the below image is the result
~~~

{% img center /assets/blueblueredred.gif %}

<h3 id="description" data-magellan-destination="description">Description</h3>

The <code class="text">mg.Text</code> class handles the creation of text objects. It uses markdown-like markup so you can change how each character
or group of character behaves. You can also define functions that will act on each character's properties, giving you freedom to do pretty much
whatever you want with text objects.

<h3 id="character" data-magellan-destination="character">Character</h3>

As can be seen on the example, each define function acts on a character table. This character table has a bunch of predefined attributes:

*   <code>x, y</code>: the x, y position of the character, usually you wanna change <code class="atrm">.y</code> only since <code class="atrm">.x</code> is calculated automatically 
*   <code>character</code>: the actual character 
*   <code>position</code>: the position of the character in relation to the entire text string, starts at <code class="number">1</code> 
*   <code>text</code>: a reference to the text object 
*   <code>str_text</code>: the string this character belongs to 
*   <code>pivot</code>: the character rotation pivot, <code class="atrm">.x, .y</code> positions 
*   <code>line</code>: the line number this character belongs to if the text has more than one line

Attributes can be added to each character by defining a function that ends with <code class="text">Init</code>. This function will receive the character
table, which you can then change to add whatever other attributes your main function will need to use. 

In the first example above, 
<code class="text">wavyInit</code> is defined, but only <code class="text">wavy</code> is called on text creation. This is because 
<code class="text">Init</code> functions get called automatically on text creation, if they exist, and then the normal function (the one
that receives both a delta and the character table) gets called on every update call to do their work. Those functions always get called right
before each character is drawn.

<h3 id="text" data-magellan-destination="text">Text</h3>

The text string is from where you'll pass information to the text object about what to do where and how! The escape character used is
<code class="string">@</code>. So, for instance: <code class="string">"Test @[text@]"</code> will draw <code class="string">Test [text]</code>.
To escape <code class="string">@</code> itself, use two: <code class="string">email@@email.com</code>.

Functions can be passed parameters:

~~~ lua
TextConfig = {
    color = function(dt, c, ...)
        local colors = {...}
        love.graphics.setColor(colors[1], colors[2], colors[3])
    end,
}

text = mg.Text('[Yellow yellow text!](color: 244, 244, 0)', TextConfig)
~~~ 

And finally, the text settings table has a few special attributes that can be defined:

*   <code>font</code>: the font to be used for this text 
*   <code>line_height</code>: the line height used, the actual line height in pixels is the multiplication of this number by the font height 
*   <code>wrap_width</code>: maximum width in pixels that this text can go, after that it will wrap to the next line
