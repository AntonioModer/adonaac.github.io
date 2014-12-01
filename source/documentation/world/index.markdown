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
The {% text mg.world %} instance houses the [render](/documentation/render) module, the [collision/physics](/documentation/collision) module 
and a list of [areas](/documentation/area) that have the functionality of holding objects, updating them, removing dead ones, creating new ones,
querying for objects... and so on. Areas act as independent levels of sorts that you can switch between, while the world instance 
holds those areas and updates them appropriately, as well as handles communication between the render/collision/physics modules and each area.

{% title Attributes %}

{% attribute areas areas table[Area] %}

*   a list of areas (areas are created as key, value pairs, i.e. {% text world.areas['Default'] = Area(...) %})
<br><br>

{% attribute box2d_world box2d_world World %}

*   the [box2d World](http://www.love2d.org/wiki/World) [collision/physics module]
<br><br>

{% attribute camera camera Camera %}

*   the camera instance [render module]
<br><br>

{% attribute layers layers table[Layer] %}

*   a list of layers [render module]
<br><br>

{% attribute layers_order layers_order table[string] %}

*   a list of strings specifying layer draw order [render module]
<br><br>

{% attribute mg mg table %}

*   a reference to the variable that holds the entire engine/framework
