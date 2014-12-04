---
layout: page
title: Text 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Example %}

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
text = fg.Text('[BLUE BLUE RED RED RED](wavy; increasingRed)', TextConfig)

-- update the text
text:update(dt)

-- draw the text
text:draw(x, y)
-- the below image is the result
~~~

{% img center /assets/blueblueredred.gif %}

{% title Description %}

The {% text fg.Text %} class handles the creation of text objects. 
It uses markdown-like markup so you can change how each character or group 
of character behaves. You can also define functions that will act on each 
character's properties, giving you freedom to do pretty much whatever you 
want in terms of effects and behaviors.

{% title Character %}

As can be seen on the example, each defined function acts on a character table. 
This character table has a bunch of predefined attributes:

*   {% param x, y %}: the x, y position of the character, usually you wanna change {% text .y %} only since {% text .x %} is calculated automatically 
*   {% param character %}: the actual character string
*   {% param position %}: the position of the character in relation to the entire text string, starts at {% number 1 %} 
*   {% param text %}: a reference to the text object 
*   {% param str_text %}: the text this character belongs to (a string)
*   {% param pivot %}: the character rotation pivot, {% text .x, .y %} positions 
*   {% param line %}: the line number this character belongs to if the text has more than one line

Attributes can be added to each character by defining a function that ends with {% text Init %}. 
This function will receive the character table, which you can then change to add whatever other a
ttributes your main function will need to use. 

In the first example above, 
{% text wavyInit %} and {% text wavy %} are defined, but only {% text wavyInit %} is called on text creation. This is because 
{% text Init %} functions get called automatically on text creation, if they exist, and then the normal function (the one
that receives both a delta and the character table and doesn't have {% text Init %} in its name) gets called on every update 
call to do their work.

{% title Text %}

The text string is from where you'll pass information to the text object about what to do where and how! The escape character used is
{% string @ %}. So, for instance: {% string "Test @[text@]" %} will draw {% string Test [text] %}.
To escape {% string @ %} itself, use two: {% string email@@email.com %}.

Functions can be passed parameters:

~~~ lua
TextConfig = {
    color = function(dt, c, ...)
        local colors = {...}
        love.graphics.setColor(colors[1], colors[2], colors[3])
    end,
}

text = fg.Text('[Yellow yellow text!](color: 244, 244, 0)', TextConfig)
~~~ 

And finally, the text settings table (in all these examples, {% text TextConfig %}) has a few special attributes that can be defined:

*   {% param font %}: the font to be used for this text 
*   {% param line_height %}: the line height used, the actual line height in pixels is the multiplication of this number by the font height 
*   {% param wrap_width %}: maximum width in pixels that this text can go, after that it will wrap to the next line
