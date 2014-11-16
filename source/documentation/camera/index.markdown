---
layout: page
title: Camera 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

<h3 id="example" data-magellan-destination="example">Example</h3>

~~~ lua
-- initialize the camera, passing a settings table with optional parameters or setting them directly
camera = mg.Camera({lerp = 3, follow_style = 'lockon', target = followed_entity})
camera.debug_draw = true

-- update the camera
camera:update(dt)

-- draw the camera, attach/detach applies/removes camera transforms
camera:attach()
entities:draw()
camera:detach()
~~~
<br>

<h3 id="description" data-magellan-destination="description">Description</h3>

The <code class="text">mg.Camera</code> module handles basic things that a camera should handle, like translations, rotations and scaling, but also adds a bunch of high level features such as
target tracking, lerp (delay between camera position and target position), lead (how much in front of the target the camera should be), deadzones and camera shakes. 
An instance <code class="text">mg.world.camera</code> is automatically created on initialization, but you can also create your own instances doing <code class="text">camera = mg.Camera()</code>.

This module is based on [hump.camera](http://vrld.github.io/hump/#hump.camera) and has been modified for additional functionality and consistency. Also, check 
[HaxeFlixel's camera demo](http://haxeflixel.com/demos/FlxCamera/) for an example on how lerp, lead and targetting modes work. This module copies HaxeFlixel's camera pretty closely for those
features.
<br><br>

<h3 id="methods" data-magellan-destination="methods">Methods</h3>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">new</span>(settings<span class="tag">[table]</span><span class="tag">[optional]</span>)
</pre></td>
</table></div>

*   <code>settings</code>: a table containing all camera initialization settings, all values are optional 

Possible settings:

*   <code>x, y</code>: the initial position of the camera, defaults to the center of the screen 
*   <code>bounds</code>: a table in the format <code class="text">{left = <span class="tag">[number]</span>, top = <span class="tag">[number]</span>, right = <span class="tag">[number]</span> down = <span class="tag">[number]</span>}</code>
*   <code>follow_style</code>: the follow style: <code class="string">'lockon'</code>, <code class="string">'screen'</code>, <code class="string">'platformer'</code>, 
<code class="string">'topdown'</code> or <code class="string">'topdown-tight'</code>, defaults to <code class="string">'lockon'</code>
*   <code>lead</code>: the initial lead value, defaults to <code class="text">{x = 0, y = 0}</code> 
*   <code>lerp</code>: the initial lerp value, defaults to <code class="number">0</code> 
*   <code>max_shake_intensity</code>: the maximum amount of camera shake, defaults to <code class="number">15</code> 
*   <code>rotation</code>: the initial rotation of the camera, defaults to <code class="number">0</code> 
*   <code>target</code>: the tracked object, defaults to <code class="text">nil</code> . The object must have <code class="text">.x, .y</code> fields.
*   <code>zoom</code>: the initial zoom of the camera, defaults to <code class="number">1</code> 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">update</span>(dt)
</pre></td>
</table></div>

*   <code>dt</code>: delta value passed from the main loop to update the camera
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">draw</span>(func<span class="tag">[function]</span>)
</pre></td>
</table></div>

*   automatically wraps a function between <code class="atrm">:attach</code> and <code class="atrm">:detach</code> calls
*   <code>func</code>: the function to be drawn

~~~ lua
function love.draw()
    camera:draw(drawWorld)
    drawUI()
end
~~~
<br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">attach</span>()
</pre></td>
</table></div>

*   attaches the camera, applying all its transformations until <code class="atrm">:detach()</code> is called 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">detach</span>()
</pre></td>
</table></div>

*   detaches the camera, removing all its transformations

~~~ lua
function love.draw()
    camera:attach()
    drawWorld()
    camera:detach()
    drawUI()
end
~~~
<br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">follow</span>(target<span class="tag">[table]</span>, settings<span class="tag">[table]</span><span class="tag">[optional]</span>)
</pre></td>
</table></div>

*   Sets a new target, follow style, lead and lerp values and resets the deadzone according to the follow style.
*   <code>target</code>: the new target to follow, must have <code class="atrm">.x, .y</code> fields 
*   <code>settings</code>: a table containing target following settings, all values are optional 

Possible settings:

*   <code>follow_style</code>: the new follow style: <code class="string">'lockon'</code>, <code class="string">'screen'</code>, <code class="string">'platformer'</code>, <code class="string">'topdown'</code> or <code class="string">'topdown-tight'</code>, defaults to the already set follow style 
*   <code>lead</code>: the new lead value, defaults to the already set lead value 
*   <code>lerp</code>: the new lerp value, defaults to the already set lerp value 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">getPosition</span>()
</pre></td>
</table></div>

*   <code>number, number</code> returns the <code class="atrm">.x, .y</code> camera position 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">getMousePosition</span>()
</pre></td>
</table></div>

*   <code>number, number</code> returns the <code class="text">x, y</code> mouse position in world coordinates 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">getCameraCoords</span>(x<span class="tag">[number]</span>, y<span class="tag">[number]</span>)
:<span class="annotation">getWorldCoords</span>(x<span class="tag">[number]</span>, y<span class="tag">[number]</span>)
</pre></td>
</table></div>

Because a camera has a point it looks at, a rotation and a zoom factor, it defines a coordinate system. A point now has two sets of coordinates: one defines where the point is to be found 
in the game world, and the other describes the position on the computer screen. The first set of coordinates is called world coordinates, the second one camera coordinates. Sometimes it is 
needed to convert between the two coordinate systems, for example to get the position of a mouse click in the game world in a strategy game, or to see if an object is visible on the screen.

*   <code>x, y</code>: the position in camera/world coordinates to be converted
*   <code>number, number</code> returns the converted <code class="atrm">.x, .y</code> position

~~~ lua
x, y = camera:getWorldCoords(love.mouse.getPosition())
selectedUnit:plotPath(x, y)

x, y = camera:getCameraCoords(player.x, player.y)
love.graphics.line(x, y, love.mouse.getPosition())
~~~
<br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">removeBounds</span>()
</pre></td>
</table></div>

*   removes the current set bounds
<br><br>


<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">setBounds</span>(left<span class="tag">[number]</span>, top<span class="tag">[number]</span>, right<span class="tag">[number]</span>, down<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   <code>left, top, right, down</code>: the boundaries the camera can't get past, in world coordinates
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">setDeadzone</span>(left<span class="tag">[number]</span>, top<span class="tag">[number]</span>, right<span class="tag">[number]</span>, down<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   Defines a rectangle around the center of the screen where the target moves without camera tracking. 
*   <code>left, top, right, down</code>: the deadzone positions, in screen coordinates assuming <code class="number">0, 0</code> is the center
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">shake</span>(intensity<span class="tag">[number]</span>, duration<span class="tag">[number]</span>, settings<span class="tag">[table]</span><span class="tag">[optional]</span>)
</pre></td>
</table></div>

*   <code>intensity</code>: the amount of pixels the camera should shake around
*   <code>duration</code>: the amount of seconds the camera should shake for
*   <code>settings</code>: a table containing camera shake settings, all values are optional

Possible settings:

*   <code>direction</code>: the direction in which to shake: <code class="string">'vertical'</code>, <code class="string">'horizontal'</code> or <code class="string">'both'</code>, defaults to <code class="string">'both'</code> 

~~~ lua
camera:shake(5, 0.5, {direction = 'vertical'})
~~~
<br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">move</span>(x<span class="tag">[number]</span>, y<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   moves the camera by some amount, equivalent to <code class="text">camera.x, camera.y = camera.x + x, camera.y + y</code>
*   <code>x, y</code>: the amount to move the camera by 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">moveTo</span>(x<span class="tag">[number]</span>, y<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   <code>x, y</code>: the new camera position
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">rotate</span>(angle<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   moves the camera by some angle, equivalent to <code class="text">camera.rotation = camera.rotation + angle</code>
*   <code>angle</code>: the amount to rotate the camera by
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">rotateTo</span>(angle<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   <code>angle</code>: the new camera angle 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">zoom</span>(multiplier<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   multiplies the camera scale by some amount, equivalent to <code class="text">camera.scale = camera.scale * multiplier</code>
*   <code>multiplier</code>: the amount to scale the camera by
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">zoomTo</span>(zoom<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   <code>zoom</code>: the new camera zoom
<br><br>

<h3 id="attributes" data-magellan-destination="attributes">Attributes</h3>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">debug_draw</span><span class="tag">[boolean]</span>
</pre></td>
</table></div>

*   debug drawing, shows the current follow style, lead and lerp, as well as the deadzone and current target 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">follow_lead</span><span class="tag">[number]</span>
</pre></td>
</table></div>

*   how much the camera should be ahead of the moving target 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">follow_lerp</span><span class="tag">[number]</span>
</pre></td>
</table></div>

*   how much the camera should lag behind the moving target 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">follow_style</span><span class="tag">[string]</span>
</pre></td>
</table></div>

*   the camera follow_style, only set with the <code class="atrm">:follow</code> call, otherwise the deadzone doesn't get reset 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">max_shake_intensity</span><span class="tag">[number]</span>
</pre></td>
</table></div>

*   the maximum intensity the camera can shake for 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">target</span><span class="tag">[table]</span>
</pre></td>
</table></div>

*   the target the camera should follow, needs to have <code class="atrm">.x, .y</code> fields
<br><br>
