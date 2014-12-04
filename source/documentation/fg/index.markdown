---
layout: page
title: fg 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

<h3 id="description" data-magellan-destination="description">Description</h3>

The <code class="text">mg</code> module holds Mogamett itself! 
<br><br>

<h3 id="modules_and_instances" data-magellan-destination="modules_and_instances">Modules and Instances</h3>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">Animation</span>
</pre></td>
</table></div>

*   the [Animation](/documentation/animation) module 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">Assets</span>
</pre></td>
</table></div>

*   a table to be used with [Loader](/documentation/loader) to hold resources 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">Camera</span>
</pre></td>
</table></div>

*   the [Camera](/documentation/camera) module
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">Class</span>
</pre></td>
</table></div>

*   the [Class](/documentation/class) module
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">Collision</span>
</pre></td>
</table></div>

*   the [Collision](/documentation/collision) module 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">Gamestate</span>
</pre></td>
</table></div>

*   the [Gamestate](/documentation/gamestate) module 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">Group</span>
</pre></td>
</table></div>

*   the [Group](/documentation/group) module 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">Input</span>, .<span class="annotation">input</span>
</pre></td>
</table></div>

*   the [Input](/documentation/input) module and the <code class="text">input</code> instance 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">Loader</span>
</pre></td>
</table></div>

*   the [Loader](/documentation/loader) module 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">lovebird</span>
</pre></td>
</table></div>

*   the [Debug](/documentation/debug) module 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">Text</span>
</pre></td>
</table></div>

*   the [Text](/documentation/text) module
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">Tilemap</span>
</pre></td>
</table></div>

*   the [Tilemap](/documentation/tilemap) module
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">Timer</span>, .<span class="annotation">timer</span>
</pre></td>
</table></div>

*   the [Timer](/documentation/timer) module and the <code class="text">timer</code> instance 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">utils</span>
</pre></td>
</table></div>

*   the [Utils](/documentation/utils) module  
<br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">Vector</span>
</pre></td>
</table></div>

*   the [Vector](/documentation/vector) module 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">World</span>, .<span class="annotation">world</span>
</pre></td>
</table></div>

*   the [World](/documentation/world) module and the <code class="text">world</code> instance 
<br><br>

<h3 id="entities_and_mixins" data-magellan-destination="entities_and_mixins">Entities and Mixins</h3>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">Entity</span>
</pre></td>
</table></div>

*   the base game object [Entity](/documentation/entity) 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">PhysicsBody</span>
</pre></td>
</table></div>

*   the [PhysicsBody](/documentation/physicsbody) mixin, adds physics capabilities to entities 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">Solid</span>
</pre></td>
</table></div>

*   the base collision [Solid](/documentation/solid) 
<br><br>

<h3 id="methods" data-magellan-destination="methods">Methods</h3>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">init</span>
</pre></td>
</table></div>

*   initializes the framework, <code class="text">mg.world</code> classes should be required before this is called
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">update</span>(dt<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   <code>dt</code>: delta value passed from the main loop to update the camera
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">draw</span>()
</pre></td>
</table></div>

*   draws <code class="text">mg.world</code> 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">run</span>()
</pre></td>
</table></div>

*   Mogamett's main loop, override <code class="text">love.run</code> with it like this: 

~~~ lua
function love.run()
    math.randomseed(os.time())
    math.random() math.random()
    if love.math then love.math.setRandomSeed(os.time()) end
    if love.event then love.event.pump() end
    if love.load then love.load(arg) end
    if love.timer then love.timer.step() end
    mg.run()
end
~~~
<br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">class</span>
</pre></td>
</table></div>

*   creates a class using <code class="atrm">.Class</code> and also adds it to an internal list of classes
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">getUID</span>()
</pre></td>
</table></div>

*   <code>number</code> returns a new unique identifier 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">keypressed</span>(key<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   alias for <code class="text">mg.input:keypressed(key)</code> 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">keyreleased</span>(key<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   alias for <code class="text">mg.input:keyreleased(key)</code> 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">mousepressed</span>(button<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   alias for <code class="text">mg.input:mousepressed(button)</code> 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">mousereleased</span>(button<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   alias for <code class="text">mg.input:mousereleased(button)</code> 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">gamepadpressed</span>(joystick<span class="tag">[Joystick]</span>, button<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   alias for <code class="text">mg.input:gamepadpressed(joystick, button)</code> 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">gamepadreleased</span>(joystick<span class="tag">[Joystick]</span>, button<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   alias for <code class="text">mg.input:gamepadreleased(joystick, button)</code> 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">gamepadaxis</span>(joystick<span class="tag">[Joystick]</span>, axis<span class="tag">[GamepadAxis]</span>, newvalue<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   alias for <code class="text">mg.input:gamepadaxis(joystick, axis, newvalue)</code> 
<br><br>

<h3 id="attributes" data-magellan-destination="attributes">Attributes</h3>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">debug_draw</span><span class="tag">[boolean]</span>
</pre></td>
</table></div>

*   if debug drawing is enabled or not 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">lovebird_enabled</span><span class="tag">[boolean]</span>
</pre></td>
</table></div>

*   if lovebird is enabled or not 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">game_width</span><span class="tag">[number]</span>, .<span class="annotation">game_height</span><span class="tag">[number]</span>
</pre></td>
</table></div>

*   initial size of the screen's width and height 
<br><br>
