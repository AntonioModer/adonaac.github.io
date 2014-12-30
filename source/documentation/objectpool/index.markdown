---
layout: page
title: ObjectPool 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Description %}

An [object pooling](http://gameprogrammingpatterns.com/object-pool.html) module that is kinda based on 
[ImpactJS'](http://impactjs.com/documentation/entity-pooling) entity pooling system. Both those links
do a good job of explaining why pooling is necessary and how it works.

fuccboiGDX's pooling system needs three things so that it can work: on an {% text engine %} class (one
that inherits from Entity) a {% text .pool_enabled %} class attribute with the size of the pool to be
created for that class; a {% call :reset %} function that is called every time the object created 
needs to be reused (this call will usually do the same things as the constructor does, and it receives
as arguments the {% text x, y %} values for its position as well as the {% text settings %} table); and
finally, the {% call :initializePools %} call has to be called once everything in your game is loaded. If
using the Loader module for instance, do {% text fg.world.areas[current_area]:initializePools %} after all
assets are done loading, since this call will actually create all objects at once, and if objects need the assets
then you wanna initialize pools only after the assets are loaded. You need to initialize pools for each area
you create.

~~~ lua
MyClass = fg.Class('MyClass', 'Entity')

MyClass.pool_enabled = 100
...

function MyClass:reset(x, y, settings)
    ...
end
~~~ 

When an object is killed (via {% text self.dead = true %}), it goes back to the pool until it gets
selected again, and that's when the {% call :reset %} method is called. If there are no free objects
in a pool then by default you won't be able to create new objects until another one dies and goes back to the
pool to be reused, but there are ways of specifying different overflow behaviors through the {% text .pool_overflow_rule %} 
class variable.

~~~ lua
MyClass = fg.Class('MyClass', 'Entity')

MyClass.pool_enabled = 100
MyClass.pool_overflow_rule = 'distance'
...

function MyClass:reset(x, y, settings)
    ...
end
~~~ 

The possible values for the {% text .pool_overflow_rule %} class variable are: {% string 'oldest' %}, {% string 'distance' %},
{% string 'random' %} and {% string 'never' %}. {% string 'oldest' %} picks the oldest object created to be reallocated, {% string 'distance' %}
picks the object further away from the center of the screen (more likely to be out of view) to be reallocated, {% string 'random' %} picks a random one 
and {% string 'never' %} is the same as the default behavior.
