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

~~~ lua
-- Create a new area
fg.world:createArea('Level_1', 0, 0)

-- Create a bunch of objects to it
fg.world.areas['Level_1']:createEntity('Player', 200, 100)
fg.world.areas['Level_1']:createEntity('Solid', 200, 200, {w = 200, h = 50})
fg.world.areas['Level_1']:createEntity('Solid', 200, -100, {w = 200, h = 50})

-- Activate the area so that objects are created/drawn/updated
fg.world.areas['Level_1']:activate()
~~~ 

{% title Description %}

The {% text fg.Area %} module handles the creation/deletion/updating of engine object, 
querying the world for objects in a certain area/position/condition,
saving/loading all objects in the area for when you have to transition from one are to another (changing levels),
as well as a bunch of other smaller utilities (like hitFrameStops). Area instances are created in the 
{% text fg.world %} instance and can be manipulated by doing {% text fg.world.areas['area_name']:method %}. Omitting
{% text .areas['area_name'] %} and doing {% text fg.world:method %} is an alias for {% text fg.world.areas['Default']:method %},
which uses the {% string 'Default' %} area.

Areas are the main way of getting information about the level you're currently in as well as organizing your entities
in separate logical bundles that can also be manipulated; think of it as literally a zone/level/area/map in a game
where the loading screen usually appears (although for 2D games the loading screen is probably unnecessary most of the time
since you can just load everything and have it in memory from when the game is launched).

{% title Area Methods %}

{% method activate %}

*   activates the area, enabling drawing and updating of its entities
<br><br>

{% method deactivate %}

*   deactivates the area, disabling drawing and updating of its entities
<br><br>

{% title Creation Methods %}

{% method createEntity entity_type string x number y number settings table[any][optional] %}

*   creates an entity **at the end of the current frame**, if you need to rely on this entity's creation to do stuff on this frame then
use {% text createEntityImmediate %}; physics enabled classes should be created at the end of the frame (with this call) otherwise bugs are generated if
an object is trying to be created while the box2d world is updating
*   {% param entity_type %}: the type of the entity to be created, available types are all classes created with the {% text fg.Class %} call 
*   {% param x, y %}: the initial position to spawn the entity at
*   {% param settings %}: the table with additional settings, the entity is added attributes defined by this table
<br>

~~~ lua
-- creates a Player and defines its .v, .hp and .damage attributes
fg.world:createEntity('Player', 400, 300, {v = 300, hp = 50, damage = 10})
~~~

{% method createEntityImmediate type string x number y number settings table[any][optional] %}

*   returns the created entity, use this when you need an entity to be created **RIGHT NOW!!!** instead of at the end of the frame
*   {% param entity_type %}: the type of the entity to be created, available types are all classes created with the {% text fg.Class %} call 
*   {% param x, y %}: the initial position to spawn the entity at
*   {% param settings %}: the table with additional settings, the entity is added attributes defined by this table; for this call specifically, if the
attribute {% text no_layer %} is set to true, then this entity won't be added to any rendering layers, this can be useful when creating object hierarchies and
so letting the parent object draw the child object manually instead of letting the rendering module do it automatically
<br>

~~~ lua
-- creates a Player and defines its .v, .hp and .damage attributes
player = fg.world:createEntityImmediate('Player', 400, 300, {v = 300, hp = 50, damage = 10})
~~~

{% method createTiledMapEntities tilemap Tilemap %}

*   generates entities defined by a Tiled map tilemap
*   {% param tilemap %}: the tilemap to use as reference for collision solid generation 
<br><br>

{% method generateCollisionSolids tilemap Tilemap %}

*   generates collision [Solids](/documentation/solid) based on the tilemap's collision data
*   {% param tilemap %}: the tilemap to use as reference for entity generation 

It's important to notice that on a few edge cases this algorithm doesn't work, such as when a hole
shares a corner with another hole, like this:

~~~ lua
{1, 1, 0}
{1, 0, 1}
{1, 1, 1}
~~~

As those bugs happen I'll try to fix most of them, but this is a pretty tricky problem to solve with 100% robustness, so
if you keep running into those issues just generate collision solids manually either through Tiled or code alone.
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
fg.world:hitFrameStopAdd(10, {'Player', 'Enemy', 'Particles'}, function() print(1) end)

-- Stops all instances of all classes except for the Particles class from being updated for 20 frames
fg.world:hitFrameStopAdd(20, {'All', except = {'Particles'}})

-- Stops all instances of all classes from being update for 30 frames, printing 2 after it's all done
fg.world:hitFrameStopAdd(30, function() print(2) end)
~~~
<br>

{% title Query Methods %}

{% text apply %} functions apply some action to all entities inside an area: 

~~~ lua
-- deals damage to all Enemy1, Enemy2, Enemy3 type of enemies inside a 32x32 rectangle around world coordinate 400, 300
fg.world:applyAreaRectangle(400, 300, 32, 32, {'Enemy1', 'Enemy2', 'Enemy3'}, function(enemy)
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

{% method applyAreaPolygon polygon_points table[number] object_types table[string] action function %}

*   {% param polygon_points %}: the {% text x1, y1, x2, y2, ..., xn, yn %} points of the polygon
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
entities = fg.world:queryAreaRectangle(400, 300, 32, 32, {'Enemy1', 'Enemy2', 'Enemy3'})
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

{% method queryAreaPolygon polygon_points table[number] object_types table[string] %}

*   returns a table containing the entities inside the area defined by this polygon
*   {% param polygon_points %}: the {% text x1, y1, x2, y2, ..., xn, yn %} points of the polygon
*   {% param object_types %}: the class names of the entities that should be acted upon

{% method queryAreaRectangle x number y number width number height number object_types table[string] %}

*   returns a table containing the entities inside this area
*   {% param x, y %}: the center of the rectangle being checked for entities
*   {% param width, height %}: the size of the rectangle being checked for entities
*   {% param object_types %}: the class names of the entities that should be acted upon
<br><br>

{% method queryClosestAreaCircle ids table[number] x number y number radius number object_types table[string] %}

*   returns the closest entity to position {% text x, y %} inside {% text radius %} 
*   {% param ids %}: a table of numbers (object ids) saying which objects to ignore, usually {% text {self.id} %}, meaning that it shouldn't
consider the object that called it when doing the proximity calculations
*   {% param x, y %}: the center of the circle being checked for entities
*   {% param radius %}: the radius of the circle being checked for entities
*   {% param object_types %}: the class names of the entities that should be acted upon
<br><br>

{% method getEntitiesBy key string value any object_types table[string][optional] %}

*   returns a table of entities where {% text entity.key == value %}
*   {% param key %}: the key (as a string) to look for
*   {% param value %}: the value to look for
*   {% param object_types %}: the class names of the entities that should be acted upon, if omitted defaults to all classes
<br><br>

{% method getEntitiesWhere condition function object_types table[string][optional] %}

*   returns a table of entities where condition is satisfied
*   {% param condition %}: the condition to be satisfied
*   {% param object_types %}: the class names of the entities that should be acted upon, if omitted defaults to all classes

~~~ lua
entities = fg.world:getEntitiesWhere(function(object) if object.hp < 5 then return true end end)
~~~
<br><br>

{% title Attributes %}

{% attribute active active boolean %}

*	if the area is active (and drawing/updating) or not	
<br><br>

{% attribute fg fg table %}

*   a reference to the variable that holds the entire engine/framework
<br><br>

{% attribute position x number y number %}

*   the top-left position of the area; all entities created will be offset by this position	
<br><br>

{% attribute world world World %}

*	a reference to the {% text fg.world %} instance that holds this area
<br><br>
