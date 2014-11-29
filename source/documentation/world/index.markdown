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
removing dead ones, applying actions to some of them when and however you want it to, dealing with rendering orders, 
layers, physics callbacks, etc, etc. It also holds [areas](/documentation/area) that have the same functionality, but
make the act of changing between areas/levels/worlds easier than if you were just using the single {% text mg.world %} instance.
<br><br>

{% comment %}
<h3 id="render_methods" data-magellan-destination="render_methods">Render Methods</h3>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">addLayer</span>(layer_name<span class="tag">[string]</span>, scale<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   adds a layer to the world, a layer named <code class="string">'Default'</code> is added by default and all objects are placed in it 
*   <code>scale</code>: the parallax scale of the layer, <code class="number">1</code> is closer to the screen, <code class="number">0</code> is further away 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">addToLayer</span>(layer_name<span class="tag">[string]</span>, entity<span class="tag">[Entity]</span>)
</pre></td>
</table></div>

*   adds <code class="text">entity</code> to the layer named <code class="text">layer_name</code>, both this function and <code class="atrm">:addLayer</code> are used internally
<br>

Layers for each class can be set as class variables. Mogamett automatically creates new layers and adds new objects to the appropriate ones.

~~~ lua
MyClass = mg.class('MyClass', mg.Entity)
MyClass:include(PhysicsBody)

MyClass.static.layer = 'Front'

MyClass:init(world, x, y, settings)
...
~~~
<br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">setLayerOrder</span>(layers_order<span class="tag">[table]</span>)
</pre></td>
</table></div>

*   sets the rendering order for all layers
*   <code>layers_order</code>: the layer order table, first elements are drawn first, last are drawn last
<br>

~~~ lua
mg.world:setLayerOrder({'Back', 'Middle', 'Front', 'Effects'})
~~~
<br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">sortLayerRenderOrder</span>(layer_name<span class="tag">[string]</span>, order_function<span class="tag">[function]</span>)
</pre></td>
</table></div>

*   sorts all objects in the layer named <code class="text">layer_name</code> according to <code class="text">order_function</code> 
*   <code>layer_name</code>: the name of the layer being sorted
*   <code>order_function</code>: the order function, see [table.sort](http://lua-users.org/wiki/TableLibraryTutorial) for more information
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">sortRenderOrder</span>(order_function<span class="tag">[function]</span>)
</pre></td>
</table></div>

*   sorts all objects in the all layers according to <code class="text">order_function</code> 
*   <code>order_function</code>: the order function, see [table.sort](http://lua-users.org/wiki/TableLibraryTutorial) for more information
<br>

~~~ lua
-- sorts all objects according to their .y attribute, useful for games in a Zelda-ish topdown angle
-- in some update function
mg.world:sortRenderOrder(function(a, b) return a.y < b.y end)
~~~
<br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">renderAttach</span>()
</pre></td>
</table></div>

*   attaches <code class="text">mg.world.camera</code>, applying all its transformations until <code class="atrm">:renderDetach()</code> is called 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">renderDetach</span>()
</pre></td>
</table></div>

*   detaches the camera, removing all its transformations
<br><br>
{% endcomment %}

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
