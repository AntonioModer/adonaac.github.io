---
layout: page
title: Collision 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

<h3 id="description" data-magellan-destination="description">Description</h3>

The <code class="text">mg.Collision</code> module handles setting up collision handling for physics enabled entities (ones that have the <code class="text">PhysicsBody</code>
mixin attached to them). This module is used internally by Mogamett and shouldn't be touched by you at all. However, learning how to properly use
Mogamett's box2d facilities is necessary to use the <code class="text">engine</code>, so this page is dedicated to covering that.
<br><br>

<h3 id="physics_entities" data-magellan-destination="physics_entities">Physics Entities</h3>

For an entity to be able to be physical and have its collision handled by Mogamett, it first has to do two things: inherit from <code class="text">Entity</code> and
have a <code class="text">PhysicsBody</code> mixin attached to it. This is the template for such entities:

~~~ lua
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

To understand more about what the <code class="text">PhysicsBody</code> mixin does, check the [PhysicsBody](/documentation/physicsbody) page. In any case, now that this class is physical, we can start
specifying its behavior. There are two main ways in which we get to control an entities' physics behavior: which other entities it collides with and which ones it ignores, 
and what to do once we collide with another entity. The first is handled by setting class variables:

~~~ lua
MyClass = mg.class('MyClass', 'Entity')
MyClass:implement(mg.PhysicsBody)

-- MyClass will physically ignore objects of OtherClass1 and OtherClass2
MyClass.ignores = {'OtherClass1', 'OtherClass2'}

function MyClass:new(world, x, y, settings)
...
~~~

The <code class="atrm">.ignores</code> class field tells Mogamett which entities this entity should pass through and not collide with physically. For instance, in a platformer enemies
may not need to collide physically with other enemies, since they may need to go through each other to get to the player. In that case, the <code class="text">Enemy</code> class would
have a <code class="atrm">.ignores</code> field that looks like this <code class="text">Enemy.ignores = {'Enemy'}</code>.

The second, figuring out what to do when we collide with other entities, is done by setting class variables and defining callback functions:

~~~ lua
MyClass = mg.class('MyClass', 'Entity')
MyClass:implement(mg.PhysicsBody)

MyClass.ignores = {'OtherClass2'}

-- MyClass will generate collision callbacks on collision enter with objects of OtherClass1/2
MyClass.enter = {'OtherClass1', 'OtherClass2'}

function MyClass:new(world, x, y, settings)
...

...
function MyClass:onCollisionEnter(other, contact)
    -- check the collision class of the object by accessing the .tag field
    -- the object is in the .object field
    if other.tag == 'OtherClass1' then
        print('Collided with an OtherClass1 object!')

    elseif other.tag == 'OtherClass2' then
        print('Collided with an OtherClass2 object!')
    end
end
~~~

In this example <code class="text">MyClass</code> physically ignores <code class="text">OtherClass2</code>, but generates collision callbacks for both <code class="text">OtherClass1</code> 
and <code class="text">OtherClass2</code>. The object needs to implement an <code class="text">onCollisionEnter</code> function, which gets called whenever an <code class="text">enter</code> 
collision event happens with an entity inside the <code class="text">enter</code> list of this object's class.

All possible collision events are (as well as collision event related class variables): 

*   <code class="atrm">enter</code>: when two objects begin contact with each other
*   <code class="atrm">exit</code>: when two objects end contact with each other
*   <code class="atrm">pre</code>: one frame before two objects begin contact with each other
*   <code class="atrm">post</code>: one frame after two objects end contact with each other

The callback functions that need to be defined for each one of those are:

*   <code class="atrm">onCollisionEnter(other, contact)</code>
*   <code class="atrm">onCollisionExit(other, contact)</code>
*   <code class="atrm">preSolve(other, contact)</code>
*   <code class="atrm">postSolve(other, contact, normal_impulse1, tangent_impulse2, normal_impulse2, tangent_impulse2)</code>

<code class="atrm">.object</code> is a reference to the other object this entity just collided with, and <code class="text">contact</code> is the box2d object [Contact](http://www.love2d.org/wiki/Contact).
Refer to [LÖVE's collision callbacks tutorial](http://www.love2d.org/wiki/Tutorial:PhysicsCollisionCallbacks), as well as this [box2d tutorial](http://www.iforce2d.net/b2dtut/collision-anatomy)
for more information.
<br><br>

<h3 id="collision_classes" data-magellan-destination="collision_classes">Collision Classes</h3>

A collision class is composed of a tag and of a table of other tags. When you define an engine class, its collision class' tag is the name of the class, and the table of other tags is the 
<code class="atrm">.ignores</code> list. Therefore, a collision class serves to define which objects a certain class will physically ignore or not.

Sometimes, however, you wanna change the <code class="atrm">.ignores</code> attribute for a certain object depending on its behavior. For instance, suppose the player suddenly gets a phasing skill that lets him
move through walls. If the original Player ignores list doesn't have Solid in it, then it means the player doesn't pass through solids and everything works as it should. But how would the player then
pass through them when the phasing skill is active? 

This is when changing collision classes is useful. In this example, for instance, you would add a new collision class by calling 
<code class="text">mg.Collision:addCollisionClass('PlayerIgnoreSolids', {'Solid'})</code> and then, using PhysicsBody's mixin's <code class="atrm">:changeCollisionClass</code> call, you'd change the
collision class of the player to <code class="text">'PlayerIgnoreSolids'</code> whenever needed, like when the phasing skill is active. When the skill is done you'd use the same call to change it back
to the original <code class="text">'Player'</code> collision class.

More details on the [PhysicsBody](/documentation/physicsbody) page.
