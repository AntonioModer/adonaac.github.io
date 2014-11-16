---
layout: page
title: Background 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

<h3 id="example" data-magellan-destination="example">Example</h3>

~~~ lua
-- create two new layers, parameters are: layer name, parallax scale
mg.world:addLayer('BG1', 0.8)
mg.world:addLayer('BG2', 0.9)

-- add backgrounds to layers, background parameters are: x, y (center) position, background image
mg.world:addToLayer('BG1', mg.Background(320, 300, love.graphics.newImage('bg_back.png')))
mg.world:addToLayer('BG2', mg.Background(320, 320, love.graphics.newImage('bg_mid.png')))

-- sets the order in which to draw layers, here draws 'BG1' -> 'BG2' -> 'Default'
mg.world:setLayerOrder({'BG1', 'BG2', 'Default'})
~~~
<br>

<h3 id="description" data-magellan-destination="description">Description</h3>

The <code class="text">mg.Background</code> class handles the creation of <code class="text">Background</code> objects. Those are used 
so they can be added to layers and then drawn. Layers can have different parallax values, so you can have multiple backgrounds on different layers,
moving at different speeds as the camera moves around. This is for use with the <code class="text">engine</code> only so far, since layers are
not separated from the from <code class="text">mg.world</code> object yet.
<br><br>

<h3 id="methods" data-magellan-destination="methods">Methods</h3>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">new</span>(x<span class="tag">[number]</span>, y<span class="tag">[number]</span>, image<span class="tag">[Image]</span>)
</pre></td>
</table></div>

*   <code>x, y</code>: the center position of the background 
*   <code>image</code>: the background image
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">draw</span>()
</pre></td>
</table></div>

*   draws the background
<br><br>

<h3 id="attributes" data-magellan-destination="attributes">Attributes</h3>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">x</span><span class="tag">[number]</span>, .<span class="annotation">y</span><span class="tag">[number]</span>
</pre></td>
</table></div>

*    the center position of the background   
<br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">w</span><span class="tag">[number]</span>, .<span class="annotation">h</span><span class="tag">[number]</span>
</pre></td>
</table></div>

*    the width and height of the background, calculated automatically from its image
<br><br>
