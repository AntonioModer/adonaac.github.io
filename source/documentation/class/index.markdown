---
layout: page
title: Class 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Description %}

The {% text mg.Class %} module handles OOP and is a slightly modified version of [classic](https://github.com/rxi/classic).

There are two ways of using the class system with FuccboiGDX, one if you're using the {% text engine %} 
(meaning you're using {% text mg.world %}) and another if you're using only the {% text framework %}. 
Class creation calls for the engine should be {% text mg.Class %}, while for the framework they should be {% text mg.Object:extend %}. 

*   {% text mg.Object:extend %} simply creates a class normally like stated in classic's github page.
*   {% text mg.Class %} adds the class to a list of classes that FuccboiGDX then refers to for things like drawing and object creation/removal; 
<br><br>

{% title Example %}

There are some small changes from classic in how to create classes using FuccboiGDX. For framework/normal classes:

~~~ lua
-- create a normal class, the string passed to extend is the name of the class
-- and can be accessed by calling MyClass.class_name
MyClass = mg.Object:extend('MyClass')

-- constructor
function MyClass:new()

end
~~~

And for engine classes:

~~~ lua
-- create a mg.world/physics enabled class, passing the name of the class and the name of the parent
-- engine classes don't necessarily need to be physics enabled but they must all inherit from Entity
MyClass = mg.Class('MyClass', 'Entity')
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

