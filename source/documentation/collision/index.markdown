---
layout: page
title: Collision 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Description %}

The {% text fg.Collision %} module handles setting up collision handling for physics enabled entities (ones that have the {% text PhysicsBody %}
mixin attached to them). This module is used internally by fuccboiGDX and shouldn't be touched by you at all. However, learning how to properly use
fuccboiGDX's box2d facilities is necessary to use the {% text engine %}, so this page is dedicated to covering that.
<br><br>

{% title Physics Entities %}

For an entity to be able to be physical and have its collision handled by fuccboiGDX, it first has to do two things: inherit from {% text Entity %} and
have a {% text PhysicsBody %} mixin attached to it. This is the template for such entities:

~~~ lua
MyClass = fg.Class('MyClass', 'Entity')
MyClass:implement(fg.PhysicsBody)

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

To understand more about what the {% text PhysicsBody %} mixin does, check the [PhysicsBody](/documentation/physicsbody) page. In any case, now that this class is physical, we can start
specifying its behavior. There are two main ways in which we get to control an entities' physics behavior regarding collisions: which other entities it collides with and which ones it ignores, 
and what to do once we collide with another entity. The first is handled by setting class variables:

~~~ lua
MyClass = fg.Class('MyClass', 'Entity')
MyClass:implement(fg.PhysicsBody)

-- MyClass will physically ignore objects of OtherClass1 and OtherClass2
MyClass.ignores = {'OtherClass1', 'OtherClass2'}

function MyClass:new(world, x, y, settings)
...
~~~

The {% text .ignores %} class field tells fuccboiGDX which entities this entity should pass through and not collide with physically. For instance, in a platformer, enemies
may not need to collide physically with other enemies, since they may need to go through each other to get to the player. In that case, the {% text Enemy %} class would
have a {% text .ignores %} field that looks like this {% text Enemy.ignores = {'Enemy' %}.

The second, figuring out what to do when we collide with other entities, is done by setting class variables and defining callback functions:

~~~ lua
MyClass = fg.Class('MyClass', 'Entity')
MyClass:implement(fg.PhysicsBody)

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

In this example, {% text MyClass %} physically ignores {% text OtherClass2 %}, but generates collision callbacks for both {% text OtherClass1 %} 
and {% text OtherClass2 %}. The object needs to implement an {% text onCollisionEnter %} function, which gets called whenever an {% text enter %} 
collision event happens with an entity from that class that is inside the {% text enter %} list of this object's class.

All possible collision events are (as well as collision event related class variables): 

*   {% param enter %}: when two objects begin contact with each other
*   {% param exit %}: when two objects end contact with each other
*   {% param pre %}: one frame before two objects begin contact with each other
*   {% param post %}: one frame after two objects end contact with each other

The callback functions that need to be defined for each one of those are:

*   {% param onCollisionEnter(other, contact) %}
*   {% param onCollisionExit(other, contact) %}
*   {% param preSolve(other, contact) %}
*   {% param postSolve(other, contact, normal_impulse1, tangent_impulse1, normal_impulse2, tanget_impulse2) %}

{% text other.object %} is a reference to the other object this entity just collided with, and {% text contact %} is the box2d object [Contact](http://www.love2d.org/wiki/Contact)
created on collision events.  Refer to [LÖVE's collision callbacks tutorial](http://www.love2d.org/wiki/Tutorial:PhysicsCollisionCallbacks), 
as well as this [box2d tutorial](http://www.iforce2d.net/b2dtut/collision-anatomy) for more information.
<br><br>

{% title Collision Classes %}

A collision class is composed of a tag and of a table of other tags. When you define an engine class, its collision class' tag is the name of the class, and the table of other tags is the 
{% text .ignores %} list. Therefore, a collision class serves to define which objects a certain class will physically ignore or not.

Sometimes, however, you wanna change the {% text .ignores %} attribute for a certain object depending on its behavior. 
For instance, suppose the player suddenly gets a phasing skill that lets him move through walls. If the original Player 
ignores list doesn't have {% string 'Solid' %} in it, then it means the player doesn't pass through solids and everything 
works as it should in a normal game. But how would the player then pass through them when the phasing skill is active? 

This is when changing collision classes is useful. In this example, for instance, you would add a new collision class by calling 
{% text fg.Collision:addCollisionClass('PlayerIgnoreSolids', {'Solid'}) %} and then, using PhysicsBody's mixin's {% call :changeCollisionClass %} call, you'd change the
collision class of the player to {% text 'PlayerIgnoreSolids' %} whenever needed, like when the phasing skill is active. When the skill is done you'd use the same call to 
change it back to the original {% text 'Player' %} collision class.

More details on the [PhysicsBody](/documentation/physicsbody) page.
