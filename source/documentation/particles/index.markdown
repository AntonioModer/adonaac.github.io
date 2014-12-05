---
layout: page
title: Particles 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Example %}

~~~ lua
-- spawn particle system, parameters are: particle system name, x, y position, optional settings
fg.world:spawnParticles('Explosion', 400, 400, {follow_target = self})
~~~
<br>

{% title Description %}

The particle module takes care of spawning particle systems created with the particle editor. The editor is located at {% text fuccboi/resources/particles/sperm %}.
Running that folder just like you run a normal LÖVE folder should open a particle editor that lets you edit particle systems as well as save them. To properly save them you must change the
fifth line of the {% text main.lua %} file to point to the directory where that file is located. For instance, if your current project is named Project_X, is located on your user's main
directory, and the fuccboiGDX library is inside a folder named libraries, then it'd look something like this:

~~~ lua
function love.load()
    -- YOUR SAVE FOLDER HERE
    save_folder = "C:/Users/Your_Username/Project_X/libraries/fuccboi/resources/particles/sperm/"
    ...
~~~

Failing to change this properly means that particle spawning will not work, because the particle module reads particle systems only from this folder 
({% text /resources/particles/sperm %}). This module only works with the {% text engine %} for now.
<br><br>

{% title Methods %}

{% method spawnParticles name string x number y number settings table %}

*   {% param name %}: the name of the particle system to be spawned, must be a particle system created with the editor (there must be a file named {% text [name].lua %} in the 
{% text /resources/particles/sperm %} folder)
*   {% param x, y %}: the position to spawn the particle system at
*   {% param settings %}: a table containing all particle spawning settings, all values are optional

Possible settings:

*   {% param follow_target %}: the target that the particle system should follow, the target must inherit from {% text fg.Entity %} 
*   {% param rotation %}: if the particle system should be rotated towards some direction
<br><br>

