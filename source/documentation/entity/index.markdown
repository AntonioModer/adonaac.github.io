---
layout: page
title: Entity 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Description %}

The {% text fg.Entity %} class is the base class that all {% text engine %} classes should inherit from. 
It has basic attributes that are used by all systems in {% text fg.world %}. If your class is not going 
to use {% text fg.world %} in any way (as a rule of thumb it's not a class that needs to be drawn) then
you don't need to inherit from {% text fg.Entity %}.

~~~ lua
-- This is an example of a class that needs to inherit from 'Entity'
Box = fg.Class('Box', 'Entity')

function Box:new(area, x, y, settings)
    -- initialize Entity parent
    Box.super.new(self, area, x, y, settings)
end

function Box:update(dt)
    -- do box things
end

function Box:draw()
    -- draw box
end
~~~

~~~ lua
-- This is an example of a class that doesn't need to inherit from 'Entity'
LogicalConceptThatDoesntMapToGameRealityAtAll = fg.Object:extend('LogicalConceptThatDoesntMapToGameRealityAtAll')

function LogicalConceptThatDoesntMapToGameRealityAtAll:new()
    -- initialize your class
end
~~~
<br>

{% title Attributes %}

{% attribute area area Area %}

*   a reference to the area the entity belongs to
<br><br>

{% attribute dead dead boolean %}

*   if the entity is dead or alive, dead entities get automatically removed from the world at the end of the frame
<br><br>

{% attribute id id number %}

*   the unique identifier of the entity 
<br><br>

{% attribute position x number y number %}

*   the position of the entity, in world coordinates
<br><br>

