---
layout: page
title: Class 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

<h3 id="description" data-magellan-destination="description">Description</h3>

The <code class="text">mg.Class</code> module handles OOP and is a slightly modified version of [Classic](https://github.com/rxi/classic).

There are two ways of using the class system with Mogamett, one if you're using the <code class="text">engine</code> (meaning you're using <code class="text">mg.world</code>) and another if you're using
only the <code class="text">framework</code>. Class creation calls for the engine should be <code class="text">mg.class</code>, while for the framework they should be <code class="text">mg.Class</code>. 

*   <code class="text">mg.class</code> adds the class to a list of classes that Mogamett then refers to for things like collision and object creation/removal; 
*   <code class="text">mg.Class</code> simply creates a class normally like stated in Classic's github page.
<br><br>

<h3 id="example" data-magellan-destination="example">Example</h3>

There are some small changes from Classic in how to create classes using Mogamett. For framework/normal classes:

~~~ lua
-- create a normal class, the string passed to extend is the name of the class
-- and can be accessed by calling MyClass.class_name
MyClass = mg.Class:extend('MyClass')

-- constructor
function MyClass:new()

end
~~~

And for engine classes:

~~~ lua
-- create a mg.world/physics enabled class, passing the name of the class and the name of the parent
-- engine classes don't necessarily need to be physics enabled but they must all inherit from Entity
MyClass = mg.class('MyClass', 'Entity')
MyClass:implement(mg.PhysicsBody)

-- constructor required
-- world, x, y, settings required
function MyClass:new(world, x, y, settings)
    MyClass.super.new(self, world, x, y, settings)
    self:physicsBodyNew(world, x, y, settings)
end

-- update required
function MyClass:update(dt)
    self:physicsBodyUpdate(dt)
end

-- draw required
function MyClass:draw()
    self:physicsBodyDraw()
end
~~~

