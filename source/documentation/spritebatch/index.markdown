---
layout: page
title: Spritebatch 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Example %}

~~~ lua
-- in some initialization part of code
fg.Spritebatches['Blood'] = fg.Spritebatch(0, 0, love.graphics.newImage('blood.png'), 5000, 'stream')

-- add the spritebatch to a layer so that it can be drawn
fg.world:addToLayer('Blood', fg.Spritebatches['Blood'])

-- in the update code of the Blood effect object
fg.Spritebatches['Blood'].spritebatch:add(self.blood_quad, self.x, self.y, self.angle, self.sx, self.y, self.w/2, self.h/2)
~~~

{% title Description %}

The {% text fg.Spritebatch %} module is used for drawing multiple identical copies of a single image with only one 
[love.graphics.draw](https://www.love2d.org/wiki/love.graphics.draw) call, which results in more performant draw code. 

{% title Methods %}

{% method new x number y number image Image size number usage_hint string %}

*   {% param x, y %}: the position to draw this spritebatch at
*   {% param image %}: the image to use for sprites
*   {% param number %}: the max number of sprites
*   {% param usage_hint %}: the [usage hint](https://www.love2d.org/wiki/SpriteBatchUsage)
<br><br>

{% method update dt number %}

*   {% param dt %}: delta value passed from the main loop to update the spritebatch 
<br><br>

{% method draw %}

*   draws the spritebatch, if using the {% text engine %}, use {% call .world:addToLayer(layer_name, spritebatch) %}
<br><br>

{% title Attributes %}

{% attribute image image Image %}

*	the image to be used for sprites	
<br><br>

{% attribute size size number %}

*	the max number of sprites
<br><br>

{% attribute position x number y number %}

*   the position to draw the spritebatch at	
<br><br>

{% attribute spritebatch spritebatch Spritebatch %}

*	the [spritebatch](https://www.love2d.org/wiki/SpriteBatch)
<br><br>

{% attribute usage_hint usage_hint string %}

*   the [usage hint](https://www.love2d.org/wiki/SpriteBatchUsage)
<br><br>
