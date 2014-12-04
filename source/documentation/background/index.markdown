---
layout: page
title: Background 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Example %}

~~~ lua
-- create two new layers
fg.world:addLayer('BG1', {parallax_scale = 0.8})
fg.world:addLayer('BG2', {parallax_scale = 0.9})

-- add backgrounds to layers, background parameters are: x, y (center) position, background image
fg.world:addToLayer('BG1', fg.Background(320, 300, love.graphics.newImage('bg_back.png')))
fg.world:addToLayer('BG2', fg.Background(320, 320, love.graphics.newImage('bg_mid.png')))

-- sets the order in which to draw layers, here draws 'BG1' -> 'BG2' -> 'Default'
fg.world:setLayerOrder({'BG1', 'BG2', 'Default'})
~~~
<br>

{% title Description %}

The {% text fg.Background %} class handles the creation of {% text Background %} objects. Those are used 
so they can be added to layers and then drawn. Layers can have different parallax values, 
so you can have multiple backgrounds on different layers, moving at different speeds as the camera moves around.
<br><br>

{% title Methods %}

{% method new x number y number image Image %}

*   {% param x, y %}: the center position of the background 
*   {% param image %}: the background image
<br><br>

{% method draw %}

*   draws the background
<br><br>

{% title Attributes %}

{% attribute position x number y number %}

*   the center position of the background   
<br><br>

{% attribute size w number h number %}

*   the width and height of the background, calculated automatically from its image
<br><br>
