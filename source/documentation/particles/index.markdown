---
layout: page
title: Particles 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

<h3 id="example" data-magellan-destination="example">Example</h3>

~~~ lua
-- spawn particle system, parameters are: particle system name, x, y position, optional settings
mg.world:spawnParticles('Explosion', 400, 400, {follow_target = self})
~~~
<br>

<h3 id="description" data-magellan-destination="description">Description</h3>

The particle module takes care of spawning particle systems created with the particle editor. The editor is located at <code class="text">mogamett/resources/particles/sperm</code>.
Running that folder just like you run a normal LÖVE folder should open a particle editor that lets you edit particle systems as well as save them. To properly save them you must change the
fifth line of the <code class="text">main.lua</code> file to point to the directory where that file is located. For instance, if your current project is named Project_X, is located on your user's main
directory, and the Mogamett library is inside a folder named libraries, then it'd look something like this:

~~~ lua
require("loveframes")

function love.load()
    -- YOUR SAVE FOLDER HERE
    save_folder = "C:/Users/Waffles/Project_X/libraries/mogamett/resources/particles/sperm/"
    ...
~~~

Failing to change this properly means that particle spawning will not work, because the particle module reads particle systems only from this folder 
(<code class="text">/resource/particles/sperm</code>). This module only works with the <code class="text">engine</code> for now.
<br><br>

<h3 id="methods" data-magellan-destination="methods">Methods</h3>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">world:spawnParticles</span>(name<span class="tag">[string]</span>, x<span class="tag">[number]</span>, y<span class="tag">[number]</span>, settings<span class="tag">[table]</span>)
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

