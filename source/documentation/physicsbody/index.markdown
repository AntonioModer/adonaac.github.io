---
layout: page
title: PhysicsBody 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Example %}

~~~ lua
-- physics enabled entity template
MyClass = fg.Class('MyClass', 'Entity')
MyClass:implement(fg.PhysicsBody)

function MyClass:new(area, x, y, settings)
    MyClass.super.new(self, area, x, y, settings)
    self:physicsBodyNew(area, x, y, settings)
end

function MyClass:update(dt)
    self:physicsBodyUpdate(dt)
end

function MyClass:draw()
    self:physicsBodyDraw()
end
~~~
<br>

{% title Description %}

If you don't know what mixins are, check [this](http://notmagi.me/the-power-of-lua-and-mixins/) article I wrote about them.

The {% text PhysicsBody %} mixin adds physics capabilities to an object. If you're using the {% text engine %}, 
then all your physics enabled entities should both inherit from {% text Entity %} and have the {% text PhysicsBody %}
mixin implemented, like in the example above.
<br><br>

{% title Methods %}

{% method physicsBodyNew area Area x number y number settings table[any][optional] %}

*   {% param area %}: a reference to the area where the entity is contained
*   {% param x, y %}: the initial position of the entity
*   {% param settings %}: a table containing physics related settings, all values are optional

Possible settings:

*   {% param body_type %}: box2d body type: {% string 'static' %}, {% string 'dynamic' %} or {% string 'kinematic' %}, defaults to {% string 'dynamic' %} 
*   {% param shape %}: box2d shape name: {% string 'rectangle' %}, {% string 'bsgrectangle' %}, {% string 'polygon' %}, {% string 'chain' %} or {% string 'circle' %}, 
defaults to {% string 'rectangle' %} 
*   {% param vertices %}: a table of vertices to define the shape, used if the shape is either {% string 'polygon' %} or {% string 'chain' %}, defaults to {% text nil %} 
*   {% param loop %}: if the {% string 'chain' %} shape should loop, defaults to {% text false %}
*   {% param w, h %}: width and height of the shape, used if the shape is either {% string 'rectangle' %} or {% string 'bsgrectangle' %}, defaults to {% number 32, 32 %} 
*   {% param s %}: the corner cutting size in a {% string 'bsgrectangle' %}, defaults to {% number 4 %} 
*   {% param r %}: the radius of a {% string 'circle' %}, defaults to {% number 16 %} 
*   {% param collision_class %}: if this object should behave, in terms of collision ignoring (the {% text .ignores %} class variable), as another class, 
defaults to the name of this object's class 
<br><br>

{% method physicsBodyUpdate dt number %}

*   {% param dt %}: delta value passed from the main loop to update the body
<br><br>

{% method physicsBodyDraw %}

*   draws debug lines for the physics object if {% text fg.debug_draw = true %}
<br><br>

{% method addBody area Area x number y number settings table[any][optional] %}

*   adds another body to this entity. Bodies/shapes/fixtures/sensors are stored in those attributes respectively; i.e. you can access all bodies via {% text self.bodies[name] %}
*   {% param area %}: a reference to the area where the entity is contained
*   {% param x, y %}: the initial position of the entity
*   {% param settings %}: a table containing physics related settings, all values are optional

The settings table follows the same specifications as in the constructor, however there's one additional relevant possible value:

*   {% param name %}: a string that is the name of this body/shape/fixture/sensor, which you can use to access those objects via
{% text self.bodies[name] %}. If omitted, defaults to {% string 'main' %}.
<br><br>

{% method addJoint name string type string ... multiple %}

*   {% param name %}: a string that is the name of this joint, which you can use to access it via {% text self.joints[name] %}
*   {% param type %}: a string specifying which joint type to add: 
{% string 'distance' %},
{% string 'friction' %},
{% string 'gear' %},
{% string 'mouse' %},
{% string 'prismatic' %},
{% string 'pulley' %},
{% string 'revolute' %},
{% string 'rope' %},
{% string 'weld' %} or
{% string 'wheel' %}.
*   {% param ... %}: multiple arguments that match the arguments required by the [box2d joint creation call](https://love2d.org/wiki/Joint)
<br><br>

{% method changeCollisionClass name string collision_class string %}

*   {% param name %}: the name of the body to be changed 
*   {% param collision_class %}: the new collision class 
<br><br>

{% method removeBody name string %}

*   {% param name %}: the name of the body to be removed 
<br><br>

{% method removeJoint name string %}

*   {% param name %}: the name of the joint to be removed 
<br><br>

{% method removeShape name string %}

*   {% param name %}: the name of the shape to be removed 
<br><br>

{% title Attributes %}

{% attribute bodies bodies table[Body] %}

*   a table containing physics bodies
<br><br>

{% attribute body body Body %}

*   the physics [Body](http://www.love2d.org/wiki/Body), alias for {% text .bodies['main'] %}
<br><br>

{% attribute fixture fixture Fixture %}

*   the main [Fixture](http://www.love2d.org/wiki/Fixture), alias for {% text .fixtures['main'] %}
<br><br>

{% attribute fixtures fixtures table[Fixture] %}

*   a table containing fixtures
<br><br>

{% attribute joints joints table[Joint] %}

*   a table containing joints
<br><br>

{% attribute sensor sensor Fixture %}

*   the secondary [Fixture](http://www.love2d.org/wiki/Fixture), used for generating callbacks when two objects physically ignore each other, alias for {% text .sensors['main'] %}
<br><br>

{% attribute sensors sensors table[Fixture] %}

*   a table containing sensors
<br><br>

{% attribute shape shape Shape %}

*   the physics [Shape](http://www.love2d.org/wiki/Shape), alias for {% text .shapes['main'] %}
<br><br>

{% attribute shapes shapes table[Shape] %}

*   a table containing shapes
<br><br>

{% attribute shape_name shape_name string %}

*   the name of this object's shape, possible values are {% string 'rectangle' %}, {% string 'bsgrectangle' %}, {% string 'polygon' %}, {% string 'chain' %} and {% string 'circle' %}
<br><br>

{% attribute size w number h number %}

*   width and height, set if {% text .shape_name %} is {% string 'rectangle' %}, {% string 'bsgrectangle' %} or {% string 'circle' %}
<br><br>

{% attribute r r number %}

*   radius, set if {% text .shape_name %} is {% string 'circle' %}   
<br>

{% attribute s s number %}

*   corner cutting size, set if {% text .shape_name %} is {% string 'bsgrectangle' %}  
<br><br>
