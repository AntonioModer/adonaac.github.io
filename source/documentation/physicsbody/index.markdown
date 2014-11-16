---
layout: page
title: PhysicsBody 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

<h3 id="example" data-magellan-destination="example">Example</h3>

~~~ lua
-- physics enabled entity template
MyClass = mg.class('MyClass', 'Entity')
MyClass:implement(mg.PhysicsBody)

function MyClass:new(world, x, y, settings)
    MyClass.super.new(self, world, x, y, settings)
    self:physicsBodyNew(world, x, y, settings)
end

function MyClass:update(dt)
    self:physicsBodyUpdate(dt)
end

function MyClass:draw()
    self:physicsBodyDraw()
end
~~~
<br>

<h3 id="description" data-magellan-destination="description">Description</h3>

If you don't know what mixins are, check [this](http://notmagi.me/the-power-of-lua-and-mixins/) article I wrote about them.

The <code class="text">PhysicsBody</code> mixin adds physics capabilities to an object. If you're using the <code class="text">engine</code>, then all your physics enabled entities
should both inherit from <code class="text">Entity</code> and have the <code class="text">PhysicsBody</code> mixin implemented, like in the example above.
<br><br>

<h3 id="methods" data-magellan-destination="methods">Methods</h3>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">physicsBodyNew</span>(world<span class="tag">[World]</span>, x<span class="tag"><span class="tag">[number]</span></span>, y<span class="tag"><span class="tag">[number]</span></span>, settings<span class="tag">[table]</span><span class="tag">[optional]</span>)
</pre></td>
</table></div>

*   <code>world</code>: a reference to the world the entity is manipulated by
*   <code>x, y</code>: the initial position of the entity
*   <code>settings</code>: a table containing physics related settings, all values are optional

Possible settings:

*   <code>body_type</code>: box2d body type: <code class="string">'static'</code>, <code class="string">'dynamic'</code> or <code class="string">'kinematic'</code>, defaults to <code class="string">'dynamic'</code> 
*   <code>shape</code>: box2d shape name: <code class="string">'rectangle'</code>, <code class="string">'bsgrectangle'</code>, <code class="string">'polygon'</code>, <code class="string">'chain'</code> or <code class="string">'circle'</code>,
defaults to <code class="string">'rectangle'</code> 
*   <code>vertices</code>: a table of vertices to define the shape, used if the shape is either <code class="string">'polygon'</code> or <code class="string">'chain'</code>, defaults to <code class="text">nil</code> 
*   <code>loop</code>: if the <code class="string">'chain'</code> shape should loop, defaults to <code class="text">false</code>
*   <code>w, h</code>: width and height of the shape, used if the shape is either <code class="string">'rectangle'</code> or <code class="string">'bsgrectangle'</code>, defaults to <code class="number">32, 32</code> 
*   <code>s</code>: the corner cutting size in a <code class="string">'bsgrectangle'</code>, defaults to <code class="number">4</code> 
*   <code>r</code>: the radius of a <code class="string">'circle'</code>, defaults to <code class="number">16</code> 
*   <code>other</code>: if this object should behave, in terms of collision ignoring (the <code class="atrm">.ignores</code> class variable), as another class, defaults to the name of this object's class 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">physicsBodyUpdate</span>(dt<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   <code>dt</code>: delta value passed from the main loop to update the body
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">physicsBodyDraw</span>()
</pre></td>
</table></div>

*   draws debug lines for the physics object if <code class="text">mg.debug_draw = true</code>
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">addBody</span>(world<span class="tag">[World]</span>, x<span class="tag"><span class="tag">[number]</span></span>, y<span class="tag"><span class="tag">[number]</span></span>, settings<span class="tag">[table]</span><span class="tag">[optional]</span>)
</pre></td>
</table></div>

*   <code>world</code>: a reference to the world the entity is manipulated by
*   <code>x, y</code>: the initial position of the entity
*   <code>settings</code>: a table containing physics related settings, all values are optional
*   adds another body to this entity. Bodies/shapes/fixtures/sensors are stored in those attributes respectively;
*   the settings table follows the same specifications as in the constructor.
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">addJoint</span>(type<span class="tag">[string]</span>, ...<span class="tag">[multiple]</span>)
</pre></td>
</table></div>

*   <code>type</code>: a string specifying which joint type to add: 
<code class="string">'distance'</code>,
<code class="string">'friction'</code>,
<code class="string">'gear'</code>,
<code class="string">'mouse'</code>,
<code class="string">'prismatic'</code>,
<code class="string">'pulley'</code>,
<code class="string">'revolute'</code>,
<code class="string">'rope'</code>,
<code class="string">'weld'</code> or
<code class="string">'wheel'</code>.
*   <code>...</code>: multiple arguments that match the arguments required by the box2d joint creation call
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">changeCollisionClass</span>(n<span class="tag">[number]</span>, collision_class<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   <code>n</code>: the position of the body to be changed 
*   <code>collision_class</code>: the new collision class 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">removeBody</span>(n<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   <code>n</code>: the position of the body to be removed 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">removeJoint</span>(n<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   <code>n</code>: the position of the joint to be removed 
<br><br>

<h3 id="attributes" data-magellan-destination="attributes">Attributes</h3>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">bodies</span><span class="tag">[table]</span>
</pre></td>
</table></div>

*   a table containing physics bodies
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">body</span><span class="tag">[Body]</span>
</pre></td>
</table></div>

*   the physics [Body](http://www.love2d.org/wiki/Body), alias for <code class="atrm">.bodies[1]</code>
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">fixture</span><span class="tag">[Fixture]</span>
</pre></td>
</table></div>

*   the main [Fixture](http://www.love2d.org/wiki/Fixture), alias for <code class="atrm">.fixtures[1]</code>
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">fixtures</span><span class="tag">[table]</span>
</pre></td>
</table></div>

*   a table containing fixtures
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">joints</span><span class="tag">[table]</span>
</pre></td>
</table></div>

*   a table containing joints
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">sensor</span><span class="tag">[Fixture]</span>
</pre></td>
</table></div>

*   the secondary [Fixture](http://www.love2d.org/wiki/Fixture), used for generating callbacks when two objects physically ignore each other, alias for <code class="atrm">.sensors[1]</code>
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">sensors</span><span class="tag">[table]</span>
</pre></td>
</table></div>

*   a table containing sensors
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">shape</span><span class="tag">[Shape]</span>
</pre></td>
</table></div>

*   the physics [Shape](http://www.love2d.org/wiki/Shape), alias for <code class="atrm">.shapes[1]</code>
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">shapes</span><span class="tag">[table]</span>
</pre></td>
</table></div>

*   a table containing shapes
<br><br>


<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">shape_name</span><span class="tag">[string]</span>
</pre></td>
</table></div>

*   the name of this object's shape, possible values are <code class="string">'rectangle'</code>, <code class="string">'bsgrectangle'</code>, <code class="string">'polygon'</code>, <code class="string">'chain'</code> and <code class="string">'circle'</code>
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">w</span><span class="tag"><span class="tag">[number]</span></span>, .<span class="annotation">h</span><span class="tag"><span class="tag">[number]</span></span>
</pre></td>
</table></div>

*   width and height, set if <code class="atrm">.shape_name</code> is <code class="string">'rectangle'</code>, <code class="string">'bsgrectangle'</code> or <code class="string">'circle'</code>
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">r</span><span class="tag"><span class="tag">[number]</span></span>
</pre></td>
</table></div>

*   radius, set if <code class="atrm">.shape_name</code> is <code class="string">'circle'</code>   
<br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">s</span><span class="tag"><span class="tag">[number]</span></span>
</pre></td>
</table></div>

*   corner cutting size, set if <code class="atrm">.shape_name</code> is <code class="string">'bsgrectangle'</code>  
<br><br>
