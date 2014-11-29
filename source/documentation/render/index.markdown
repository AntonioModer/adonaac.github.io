---
layout: page
title: Render 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Render %}

The {% text render %} module takes care of drawing everything in the {% text engine %}. It's attached to the {% text mg.world %}
instance and so all its functions should be called from there. It provides access to a [camera](/documentation/camera), as well as
layers to which you can add objects and then sort their draw order, add layer/screen-wide shaders, etc, etc.

{% title Layer %}

Layers are useful for separating objects into groups and then sorting those objects/groups in whatever way necessary
in your game. The {% text render %} module has a list of layers and offers a few functions to interface with them.
The funcionality for now is limited to drawing orders (object draw order inside a layer and draw order of layers in relation
to one another) and shaders (apply a layer/screen-wide shader to a certain layer). Each class/object needs to have 
its layer defined, otherwise the {% string 'Default' %} one is picked. If defined, FuccboiGDX automatically adds new objects to the appropriate layer.
A layer can be set as a class variable or as an object attribute, the latter having preference if both are defined.

~~~ lua
MyClass = mg.class('MyClass', 'Entity')

MyClass.layer = 'Front'

MyClass:init(world, x, y, settings)
    ...
    self.layer = 'Back'
end
...

-- in this example the layer used will be 'Back'
~~~
<br>

{% title Layer Methods %}

{% method addLayer layer_name string settings table[any][optional] %}

*   adds a layer to the world, a layer named {% string 'Default' %} is added by default and all objects are placed in it if
they (or their class) have no layer attribute defined
*   {% param layer_name %}: the name of the layer to be added
*   {% param settings %}: a table with settings for the layer

Possible settings:

*   {% param not_sortable %}: makes it so that the objects inside this layer can't be sorted when {% call :sortRenderOrder %} is called
*   {% param parallax_scale %}: how close or far away this layer is from the camera, {% number 1 %} is the normal value, {% number <1 %} is closer {% number >1 %} is further away
<br><br>

{% method addShaderToLayer layer_name string shader_name string shader_vertex_path string shader_fragment_path string %}

*   adds a shader with the identifier {% text shader_name %} to the layer named {% text layer_name %}. The canvas created
by this layer (to which all its objects get drawn to) will then be affected by this shader.
*   {% param layer_name %}: the name of the layer the shader is being added to
*   {% param shader_name %}: the name of the shader to be added
*   {% param shader_vertex_path %}: the path to the vertex shader
*   {% param shader_fragment_path %}: the path to the fragment shader

~~~ lua
mg.world:addLayer('Blood_Floor')
mg.world:addShaderToLayer('Blood_Floor', 'Outline', 'resources/shaders/default.vert', 'resources/shaders/outline.frag')
~~~
<br>

{% method addToLayer layer_name string entity Entity %}

*   adds {% text entity %} to the layer named {% string layer_name %}, used internally most of the time but useful for adding [spritebatches](/documentation/spritebatch) or
[backgrounds](/documentation/background) when needed
*   {% param layer_name %}: the name of the layer where the entity will be added
*   {% param entity %}: the entity to be added
<br><br>

{% method sendToShader layer_name string shader_name variable string value any %}
*   sends the {% text variable, value %} pair to the shader, see [Shader:send](https://www.love2d.org/wiki/Shader:send) for more information
*   {% param layer_name %}: the name of the layer being affected by this value
*   {% param shader_name %}: the name of the shader on that layer being affected by this value
*   {% param variable %}: the name of the variable
*   {% param value %}: the value of the variable

~~~ lua
-- in some update function
mg.world:sendToShader('Blood_Floor', 'Outline', 'brightness', 0.4)
~~~
<br>

{% method setShaderClassList layer_name string shader_name string class_list table[string] %}

*   makes it so that the classes defined in {% text list %} are the only ones in this layer affected by this shader
*   {% param layer_name %}: the name of the layer
*   {% param shader_name %}: the name of the shader
*   {% param class_list %}: a list of class names defining which classes get affected by this shader on this layer
<br><br>

{% method setLayerOrder layers_order table[string] %}

*   sets the rendering order for all layers
*   {% param layers_order %}: the layer order table, first layers are drawn first, last are drawn last

~~~ lua
mg.world:setLayerOrder({'Back', 'Middle', 'Default', 'Front', 'Effects'})
~~~
<br>

{% method sortLayerRenderOrder layer_name string order_function function %}

*   sorts all objects in the layer named {% text layer_name %} according to {% text order_function %} 
*   {% param layer_name %}: the name of the layer being sorted
*   {% param order_function %}: the order function, see [table.sort](http://lua-users.org/wiki/TableLibraryTutorial) for more information
<br><br>

{% method sortRenderOrder order_function function %}

*   sorts all objects in the all layers according to {% text order_function %} 
*   {% param order_function %}: the order function, see [table.sort](http://lua-users.org/wiki/TableLibraryTutorial) for more information

~~~ lua
-- sorts all objects according to their .y attribute, useful for games in a Zelda-ish topdown angle
-- in some update function
mg.world:sortRenderOrder(function(a, b) return a.y < b.y end)
~~~
<br>

{% title Render Methods %}

{% method renderAttach %}

*   attaches {% text mg.world.camera %}, applying all its transformations until {% call :renderDetach() %} is called 
<br><br>

{% method renderDetach %}

*   detaches the camera, removing all its transformations
<br><br>
