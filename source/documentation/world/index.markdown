---
layout: page
title: World 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Description %}

The {% text mg.World %} module is the heart of the {% text engine %}. The instance {% text mg.world %} is 
automatically created on initialization, and you may not create additional instances or things will not work. 
The {% text mg.world %} object provides a place for you to add your objects to and then it automatically organizes them, 
removing dead ones, applying actions to some of them when and however you want it to, dealing with physics callbacks, etc, etc. 
It also holds [areas](/documentation/area) that have the same functionality as a world, but make the act of changing between 
areas/levels/worlds easier than if you were just using the single {% text mg.world %} instance.
<br><br>

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

{% attribute box2d_world box2d_world World %}

*   the [box2d World](http://www.love2d.org/wiki/World)
<br><br>

{% attribute camera camera Camera %}

*   the camera instance
<br><br>
