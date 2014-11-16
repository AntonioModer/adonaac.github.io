---
layout: page
title: Group 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

<h3 id="example" data-magellan-destination="example">Example</h3>

~~~ lua
-- create enemy group
enemy_group = mg.Group('Enemy')

-- add some enemies
enemy_group:add(enemy_1)
enemy_group:add(enemy_2)

-- deal damage to all enemies
group:apply(function(enemy)
    enemy.hp = enemy.hp - math.random(2, 4)
end)
~~~
<br>

<h3 id="description" data-magellan-destination="description">Description</h3>

The <code class="text">mg.Group</code> class handles the creation of groups: logical bundling of entities for extra organization and handling of multiple related entities.
Multiple instances are automatically created on <code class="text">mg.world.groups</code>, more specifically, one instance of a Group is created for each class created with 
the <code class="text">mg.class</code> call. the is so that the call <code class="text">mg.world:createEntity('group_name', ...)</code> adds each entity type to the appropriate Group.
Alternatively, you can create your own groups by calling <code class="text">group = mg.Group('group_name')</code>.

<h3 id="methods" data-magellan-destination="methods">Methods</h3>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">new</span>(name<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   <code>name</code>: the name of the group 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">update</span>(dt)
</pre></td>
</table></div>

*   updates all entities contained in the group that have an <code class="text">update</code> function implemented 
*   <code>dt</code>: delta value passed from the main loop to update the camera
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">draw</span>()
</pre></td>
</table></div>

*   draws all entities contained in the group that have a <code class="text">draw</code> function implemented 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">add</span>(entity<span class="tag">[table]</span>)
</pre></td>
</table></div>

*   <code>entity</code>: the object to be added to the group 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">apply</span>(action<span class="tag">[function]</span>)
</pre></td>
</table></div>

*   applies a function to all entities in the group
*   <code>action</code>: the function to be applied, it should receive one argument: the current entity being acted upon 

~~~ lua
group:apply(function(entity)
    entity:doSomething()
end)
~~~
<br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">destroy</span>()
</pre></td>
</table></div>

*   removes all references to all entities from the group
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">getEntities</span>()
</pre></td>
</table></div>

*   <code>table</code> returns a table containing a reference to all entities from the group 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">remove</span>(id<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   <code>id</code>: the id of the entity to be removed 
<br><br>

<h3 id="attributes" data-magellan-destination="attributes">Attributes</h3>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">name</span><span class="tag">[string]</span>
</pre></td>
</table></div>

*   the name of the group 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">entities</span><span class="tag">[table]</span>
</pre></td>
</table></div>

*   the table containing all entities, can also be accessed through <code class="atrm">:getEntities()</code> 
<br><br>

