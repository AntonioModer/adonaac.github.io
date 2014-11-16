---
layout: page
title: Animation
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

<h3 id="example" data-magellan-destination="example">Example</h3>

{% img center /assets/girlrun.png spritesheet.png %}

~~~ lua
-- the above image is spritesheet.png, each of its frames is 64x64
-- create the animation, parameters are: image, width, height, delay
animation = mg.Animation(love.graphics.newImage('spritesheet.png'), 64, 64, 0.1)

-- update the animation
animation:update(dt)

-- draw the animation
animation:draw(x, y)
-- the below image is the result, 'loop' mode is set by default
~~~

{% img center /assets/girlrun.gif %}

<h3 id="description" data-magellan-destination="description">Description</h3>

The <code class="text">mg.Animation</code> class handles the creation of animated sprites from sprite sheets. You have control over what to do with the animation itself,
since it's returned and you just hold it in a variable. The draw operation, like LÖVE's, also takes rotation, scaling and shearing parameters after <code class="text">x, y</code>.
<br><br>

<h3 id="methods" data-magellan-destination="methods">Methods</h3>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">new</span>(image</span><span class="tag">[Image]</span>, width<span class="tag">[number]</span>, height<span class="tag">[number]</span>, delay<span class="tag">[number]</span>, frames<span class="tag">[number][optional]</span>)
</pre></td>
</table></div>

*   <code>image</code>: the sprite sheet containing the full animation
*   <code>width</code>: the width of each frame 
*   <code>height</code>: the height of each frame 
*   <code>delay</code>: the delay between each frame in seconds
*   <code>frames</code>: the number of frames to use for this animation, omitting this parameter or passing <code class="number">0</code> tells the library to automatically handle it
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">update</span>(dt<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   <code>dt</code>: delta value passed from the main loop to update the animation
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">draw</span>(x<span class="tag">[number]</span>, y<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   <code>x, y</code>: position to draw the animation, with optional values as seen in <a href="http://www.love2d.org/wiki/love.graphics.draw">love.graphics.draw</a>
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">addFrame</span>(x<span class="tag">[number]</span>, y<span class="tag">[number]</span>, width<span class="tag">[number]</span>, height<span class="tag">[number]</span>, delay<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   <code>x, y</code>: left top coordinate of the frame on the original sprite sheet
*   <code>width</code>: the width of the frame 
*   <code>height</code>: the height of the frame 
*   <code>delay</code>: the delay before the next frame is shown
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">getHeight</span>()
</pre></td>
</table></div>

* <code> number</code> returns the height of the current frame
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">getWidth</span>()
</pre></td>
</table></div>

* <code> number</code> returns the width of the current frame
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">play</span>()
</pre></td>
</table></div>
*   starts the animation if it was stopped
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">reset</span>()
</pre></td>
</table></div>
*   goes back to the first frame
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">seek</span>(frame<span class="tag">[number]</span>)
</pre></td>
</table></div>
*   <code>frame</code>: the frame position to seek, minimum is <code class="number">1</code> and maximum is <code class="atrm">.size</code>
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">setDelay</span>(frame<span class="tag">[number]</span>, delay<span class="tag">[number]</span>)
</pre></td>
</table></div>
*   <code>frame</code>: the frame position to set the delay
*   <code>delay</code>: the new delay
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">setMode</span>(mode<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   <code>mode</code>: the animation play mode

Possible modes:

*   <code>'loop'</code>: loops the animation after it's over
*   <code>'once'</code>: plays the animation only once
*   <code>'bounce'</code>: play it once, play it in reverse, play it again (looping)
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">setSpeed</span>(speed<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   <code>speed</code>: the speed to play the animation at, <code class="number">1</code> is normal, <code class="number">2</code> is double...
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">stop</span>()
</pre></td>
</table></div>

*   stops the animation
<br><br>

<h3 id="attributes" data-magellan-destination="attributes">Attributes</h3>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">current_frame</span><span class="tag">[number]</span>
</pre></td>
</table></div>

*   the frame currently being displayed, minimum is <code class="number">1</code> and maximum is <code class="atrm">.size</code>
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">frame_height</span><span class="tag">[number]</span>
</pre></td>
</table></div>

*   the height of the animation, can also be accessed through <code class="atrm">:getHeight()</code>
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">frame_width</span><span class="tag">[number]</span>
</pre></td>
</table></div>

*   the width of the animation, can also be accessed through <code class="atrm">:getWidth()</code>
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">size</span><span class="tag">[number]</span>
</pre></td>
</table></div>

*   the number of frames the animation has
<br><br>
