---
layout: page
title: World 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

<h3 id="description" data-magellan-destination="description">Description</h3>

The <code class="text">mg.World</code> module is the heart of the <code class="text">engine</code>. An instance <code class="text">mg.world</code> is automatically created on initialization, and you may not
create additional instances or things will not work. The <code class="text">mg.world</code> object provides a place for you to add your objects to and then it automatically organizes them, 
removing dead ones, applying actions to some of them when and however you want it to, dealing with rendering orders, layers, physics callbacks, etc, etc. It is the main and most important
place about your game if you're using the <code class="text">engine</code>.
<br><br>

<h3 id="world_methods" data-magellan-destination="world_methods">World Methods</h3>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">addGroup</span>(group_name<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   creates a new <code class="text">Group</code> named <code class="text">group_name</code>, used internally
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">addToGroup</span>(group_name<span class="tag">[string]</span>, entity<span class="tag">[Entity]</span>)
</pre></td>
</table></div>

*   adds <code class="text">entity</code> to the group named <code class="text">group_name</code>, used internally
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">destroy</span>()
</pre></td>
</table></div>

*   destroys and removes all entities from the world 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">getEntitiesFromGroup</span>(group_name<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   <code>table</code> returns a table containing references to all entities contained in the Group named <code class="text">group_name</code> 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">getEntityById</span>(id<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   <code>Entity</code> returns the entity that matches <code class="text">id</code> 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">removeFromGroup</span>(group_name<span class="tag">[string]</span>, id<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   removes from the Group named <code class="text">group_name</code> the entity that matches <code class="text">id</code>, used internally
<br><br>

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

<h3 id="creation_methods" data-magellan-destination="creation_methods">Creation Methods</h3>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">createEntity</span>(entity_type<span class="tag">[string]</span>, x<span class="tag">[number]</span>, y<span class="tag">[number]</span>, settings<span class="tag">[table]</span><span class="tag">[optional]</span>)
</pre></td>
</table></div>

*   <code>entity_type</code>: the type of the entity to be created, available types are all required classes before <code class="text">mg.init</code> is called 
*   <code>x, y</code>: the initial position to spawn the entity at
*   <code>settings</code>: the table with additional settings, the entity is added the attributes defined by this table
<br>

~~~ lua
-- creates a Player and defines its .v, .hp and .damage attributes
mg.world:createEntity('Player', 400, 300, {v = 300, hp = 50, damage = 10})
~~~
<br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">createEntityImmediate</span>(entity_type<span class="tag">[string]</span>, x<span class="tag">[number]</span>, y<span class="tag">[number]</span>, settings<span class="tag">[table]</span><span class="tag">[optional]</span>)
</pre></td>
</table></div>

*   <code>Entity</code> returns the created entity, physics enabled objects should not be created with this
*   <code>entity_type</code>: the type of the entity to be created, available types are all required classes before <code class="text">mg.init</code> is called 
*   <code>x, y</code>: the initial position to spawn the entity at
*   <code>settings</code>: the table with additional settings, the entity is added the attributes defined by this table
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">generateCollisionSolids</span>(tilemap<span class="tag">[Tilemap]</span>)
</pre></td>
</table></div>

*   generates collision [Solids](/documentation/solid) based on the tilemap's collision data
*   <code>tilemap</code>: the tilemap to use as reference for collision solid generation 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">spawnParticles</span>(name<span class="tag">[string]</span>, x<span class="tag">[number]</span>, y<span class="tag">[number]</span>, settings<span class="tag">[table]</span>)
</pre></td>
</table></div>

*   <code>name</code>: the name of the particle system to be spawned, must be a particle system created with the editor (there must be a file named <code class="text">[name].lua</code> in the 
<code class="text">/resources/particles/sperm</code> folder)
*   <code>x, y</code>: the position to spawn the particle system at
*   <code>settings</code>: a table containing all particle spawning settings, all values are optional

Possible settings:

*   <code>follow_target</code>: the target that the particle system should follow, the target must inherit from <code class="text">mg.Entity</code> 
*   <code>rotation</code>: if the particle system should be rotated towards some direction
<br><br>

<h3 id="query_methods" data-magellan-destination="query_methods">Query Methods</h3>

<code class="text">apply</code> functions apply some action to all entities inside an area: 

~~~ lua
-- deals damage to all Enemy1, Enemy2, Enemy3 enemies inside a 32x32 rectangle around world coordinate 400, 300
mg.world:applyAreaRectangle(400, 300, 32, 32, {'Enemy1', 'Enemy2', 'Enemy3'}, function(enemy)
    enemy:dealDamage(math.random(5, 10))
end)
~~~
<br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">applyAreaCircle</span>(x<span class="tag">[number]</span>, y<span class="tag">[number]</span>, radius<span class="tag">[number]</span>, object_types<span class="tag">[table]</span>, action<span class="tag">[function]</span>)
</pre></td>
</table></div>

*   <code>x, y</code>: the center of the circle being checked for entities
*   <code>radius</code>: the radius of the circle being checked for entities
*   <code>object_types</code>: the class names of the entities that should be acted upon
*   <code>action</code>: the action to be applied, must receive a single argument: the current entity being acted upon
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">applyAreaLine</span>(x1<span class="tag">[number]</span>, y1<span class="tag">[number]</span>, x2<span class="tag">[number]</span>, y2<span class="tag">[number]</span>, object_types<span class="tag">[table]</span>, action<span class="tag">[function]</span>)
</pre></td>
</table></div>

*   <code>x1, y1, x2, y2</code>: the initial and final points the line being checked for entities
*   <code>object_types</code>: the class names of the entities that should be acted upon
*   <code>action</code>: the action to be applied, must receive a single argument: the current entity being acted upon
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">applyAreaRectangle</span>(x<span class="tag">[number]</span>, y<span class="tag">[number]</span>, width<span class="tag">[number]</span>, height<span class="tag">[number]</span>, object_types<span class="tag">[table]</span>, action<span class="tag">[function]</span>)
</pre></td>
</table></div>

*   <code>x, y</code>: the center of the rectangle being checked for entities
*   <code>width, height</code>: the size of the rectangle being checked for entities
*   <code>object_types</code>: the class names of the entities that should be acted upon
*   <code>action</code>: the action to be applied, must receive a single argument: the current entity being acted upon
<br><br>

<code class="text">query</code> functions return all entities inside an area: 

~~~ lua
-- deals damage to all Enemy1, Enemy2, Enemy3 enemies inside a 32x32 rectangle around world coordinate 400, 300
entities = mg.world:queryAreaRectangle(400, 300, 32, 32, {'Enemy1', 'Enemy2', 'Enemy3'})
for _, entity in ipairs(entities) do 
    entity:dealDamage(math.random(5, 10))
end
~~~
<br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">queryAreaCircle</span>(x<span class="tag">[number]</span>, y<span class="tag">[number]</span>, radius<span class="tag">[number]</span>, object_types<span class="tag">[table]</span>)
</pre></td>
</table></div>

*   <code>table</code> returns a table containing the entities inside this area
*   <code>x, y</code>: the center of the circle being checked for entities
*   <code>radius</code>: the radius of the circle being checked for entities
*   <code>object_types</code>: the class names of the entities that should be acted upon
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">queryAreaLine</span>(x1<span class="tag">[number]</span>, y1<span class="tag">[number]</span>, x2<span class="tag">[number]</span>, y2<span class="tag">[number]</span>, object_types<span class="tag">[table]</span>)
</pre></td>
</table></div>

*   <code>table</code> returns a table containing the entities inside this area
*   <code>x1, y1, x2, y2</code>: the initial and final points the line being checked for entities
*   <code>object_types</code>: the class names of the entities that should be acted upon
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">queryAreaRectangle</span>(x<span class="tag">[number]</span>, y<span class="tag">[number]</span>, width<span class="tag">[number]</span>, height<span class="tag">[number]</span>, object_types<span class="tag">[table]</span>)
</pre></td>
</table></div>

*   <code>table</code> returns a table containing the entities inside this area
*   <code>x, y</code>: the center of the rectangle being checked for entities
*   <code>width, height</code>: the size of the rectangle being checked for entities
*   <code>object_types</code>: the class names of the entities that should be acted upon
<br><br>

<h3 id="attributes" data-magellan-destination="attributes">Attributes</h3>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">world</span><span class="tag">[World]</span>
</pre></td>
</table></div>

*   the box2d [World](http://www.love2d.org/wiki/World)
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">camera</span><span class="tag">[Camera]</span>
</pre></td>
</table></div>

*   the camera instance
<br><br>
