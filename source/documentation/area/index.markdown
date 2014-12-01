---
layout: page
title: Area 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Example %}

{% title Description %}

{% title Creation Methods %}

{% method createEntity entity_type string x number y number settings table[any][optional] %}

*   {% param entity_type %}: the type of the entity to be created, available types are all classes created with the {% text mg.class %} call 
*   {% param x, y %}: the initial position to spawn the entity at
*   {% param settings %}: the table with additional settings, the entity is added attributes defined by this table
<br>

~~~ lua
-- creates a Player and defines its .v, .hp and .damage attributes
mg.world:createEntity('Player', 400, 300, {v = 300, hp = 50, damage = 10})
~~~

{% method createTiledMapEntities tilemap Tilemap %}

*   generates entities defined by a Tiled map tilemap
*   {% param tilemap %}: the tilemap to use as reference for collision solid generation 
<br><br>

{% method generateCollisionSolids tilemap Tilemap %}

*   generates collision [Solids](/documentation/solid) based on the tilemap's collision data
*   {% param tilemap %}: the tilemap to use as reference for collision solid generation 
<br><br>

{% title HitFrameStop Methods %}

{% method hitFrameStopAdd number_of_frames number groups table[optional] after_function function[optional] %}

*   stops every object from the classes specified in the {% text groups %} table from updating for {% text number_of_frames %}, executing {% text after_function %} after those frames end
*   {% param number_of_frames %}: the number of frames to stop the objects by
*   {% param groups %}: the classes to stop
*   {% param after_function %}: the function to be executed right before all objects go back to being updated

~~~ lua
-- Stops all instances of objects from the classes Player, Enemy and Particles
-- from being updated for 10 frames, printing 1 after it's all done
mg.world:hitFrameStopAdd(10, {'Player', 'Enemy', 'Particles'}, function() print(1) end)

-- Stops all instances of all classes except for the Particles class from being updated for 20 frames
mg.world:hitFrameStopAdd(20, {'All', except = {'Particles'}})

-- Stops all instances of all classes from being update for 30 frames, printing 2 after it's all done
mg.world:hitFrameStopAdd(30, function() print(2) end)
~~~
<br>

{% title Query Methods %}

{% text apply %} functions apply some action to all entities inside an area: 

~~~ lua
-- deals damage to all Enemy1, Enemy2, Enemy3 type of enemies inside a 32x32 rectangle around world coordinate 400, 300
mg.world:applyAreaRectangle(400, 300, 32, 32, {'Enemy1', 'Enemy2', 'Enemy3'}, function(enemy)
    enemy:dealDamage(math.random(5, 10))
end)
~~~

{% method applyAreaCircle x number y number radius number object_types table[string] action function %}

*   {% param x, y %}: the center of the circle being checked for entities
*   {% param radius %}: the radius of the circle being checked for entities
*   {% param object_types %}: the class names of the entities that should be acted upon
*   {% param action %}: the action to be applied, must receive a single argument: the current entity being acted upon
<br><br>

{% method applyAreaLine x1 number y1 number x2 number y2 number object_types table[string] action function %} 

*   {% param x1, y1, x2, y2 %}: the initial and end points the line being checked for entities
*   {% param object_types %}: the class names of the entities that should be acted upon
*   {% param action %}: the action to be applied, must receive a single argument: the current entity being acted upon
<br><br>

{% method applyAreaRectangle x number y number width number height number object_types table[string] action function %}

*   {% param x, y %}: the center of the rectangle being checked for entities
*   {% param width, height %}: the size of the rectangle being checked for entities
*   {% param object_types %}: the class names of the entities that should be acted upon
*   {% param action %}: the action to be applied, must receive a single argument: the current entity being acted upon
<br><br>

{% text query %} functions return all entities inside an area: 

~~~ lua
-- deals damage to all Enemy1, Enemy2, Enemy3 type of enemies inside a 32x32 rectangle around world coordinate 400, 300
entities = mg.world:queryAreaRectangle(400, 300, 32, 32, {'Enemy1', 'Enemy2', 'Enemy3'})
for _, entity in ipairs(entities) do entity:dealDamage(math.random(5, 10)) end
~~~

{% method queryAreaCircle x number y number radius number object_types table[string] %}

*   returns a table containing the entities inside this area
*   {% param x, y %}: the center of the circle being checked for entities
*   {% param radius %}: the radius of the circle being checked for entities
*   {% param object_types %}: the class names of the entities that should be acted upon
<br><br>

{% method queryAreaLine x1 number y1 number x2 number y2 number object_types table[string] %}

*   returns a table containing the entities inside this area
*   {% param x1, y1, x2, y2 %}: the initial and final points the line being checked for entities
*   {% param object_types %}: the class names of the entities that should be acted upon
<br><br>

{% method queryAreaRectangle x number y number width number height number object_types table[string] %}

*   returns a table containing the entities inside this area
*   {% param x, y %}: the center of the rectangle being checked for entities
*   {% param width, height %}: the size of the rectangle being checked for entities
*   {% param object_types %}: the class names of the entities that should be acted upon
<br><br>

{% title Attributes %}
