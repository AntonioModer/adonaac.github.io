---
layout: page
title: fg 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Description %}

The {% text fg %} module holds fuccboiGDX itself! 
<br><br>

{% title Modules and Instances %}

{% attribute Animation Animation table %}

*   the [Animation](/documentation/animation) module 
<br><br>

{% attribute Background Background table %}

*   the [Background](/documentation/background) module
<br><br>

{% attribute Camera Camera table %}

*   the [Camera](/documentation/camera) module
<br><br>

{% attribute Class Class table %}

*   the [Class](/documentation/class) module
<br><br>

{% attribute Collision Collision table %}

*   the [Collision](/documentation/collision) module 
<br><br>

{% attribute Entity Entity table %}

*   the [Entity](/documentation/entity) module
<br><br>

{% attribute fn fn table %}

*   alias for the [moses](/documentation/utils) module 
<br><br>

{% attribute Gamestate Gamestate table %}

*   the [Gamestate](/documentation/gamestate) module 
<br><br>

{% attribute Input Input table input table %}

*   the [Input](/documentation/input) module and the {% text input %} instance 
<br><br>

{% attribute Loader Loader table %}

*   the [Loader](/documentation/loader) module 
<br><br>

{% attribute lovebird lovebird table %}

*   the [Debug](/documentation/debug) module 
<br><br>

{% attribute loveframes loveframes table %}

*   the [UI Tools](/documentation/uitools) module
<br><br>

{% attribute mlib mlib table %}

*   the [mlib](/documentation/utils) module
<br><br>

{% attribute mo mo table %}

*   alias for the [moses](/documentation/utils) module 
<br><br>

{% attribute moses moses table %}

*   the [moses](/documentation/utils) module
<br><br>

{% attribute Object Object table %}

*   the [Class](/documentation/class) module
<br><br>

{% attribute PhysicsBody PhysicsBody table %}

*   the [PhysicsBody](/documentation/physicsbody) mixin
<br><br>

{% attribute Solid Solid table %}

*   the [Solid](/documentation/solid) entity
<br><br>

{% attribute Sound Sound table %}

*   the [sound](/documentation/sound) module
<br><br>

{% attribute Spritebatch Spritebatch table %}

*   the [Spritebatch](/documentation/spritebatch) module
<br><br>

{% attribute Text Text table %}

*   the [Text](/documentation/text) module
<br><br>

{% attribute Tilemap Tilemap table %}

*   the [Tilemap](/documentation/tilemap) module
<br><br>

{% attribute Timer Timer table timer table %}

*   the [Timer](/documentation/timer) module and the {% text timer %} instance 
<br><br>

{% attribute utils utils table %}

*   the [utils](/documentation/utils) module
<br><br>

{% attribute Vector Vector table %}

*   the [Vector](/documentation/vector) module
<br><br>

{% attribute World World table world table %}

*   the [World](/documentation/world) module and the {% text world %} instance 
<br><br>

{% title Methods %}

{% methoddd init %}

*   initializes the framework
<br><br>

{% methoddd update dt number %}

*   {% param dt %}: delta value passed from the main loop
<br><br>

{% methoddd draw %}

*   draws the {% text engine %} 
<br><br>

{% methoddd run %}

*   fuccboiGDX's main loop, override {% text love.run %} with it like this: 

~~~ lua
function love.run()
    math.randomseed(os.time())
    math.random() math.random()
    if love.math then love.math.setRandomSeed(os.time()) end
    if love.event then love.event.pump() end
    if love.load then love.load(arg) end
    if love.timer then love.timer.step() end
    fg.run()
end
~~~
<br>

{% methoddd Class %}

*   creates an engine class
<br><br>

{% methoddd getPS name string %}

*   returns the built particle system from file {% text fuccboi/resources/particles/sperm/name.lua %}
<br><br>

{% methoddd getUID %}

*   {% param number %} returns a new unique identifier 
<br><br>

{% methoddd keypressed key string %}

*   alias for {% text fg.input:keypressed(key) %} 
<br><br>

{% methoddd keyreleased key string %}

*   alias for {% text fg.input:keyreleased(key) %}
<br><br>

{% methoddd mousepressed button string %}

*   alias for {% text fg.input:mousepressed(button) %}
<br><br>

{% methoddd mousereleased button string %}

*   alias for {% text fg.input:mousereleased(button) %}
<br><br>

{% methoddd gamepadpressed joystick Joystick button string %}

*   alias for {% text fg.input:gamepadpressed(joystick, button) %}
<br><br>

{% methoddd gamepadreleased joystick Joystick button string %}

*   alias for {% text fg.input:gamepadreleased(joystick, button) %}
<br><br>

{% methoddd gamepadaxis joystick Joystick axis GamepadAxis new_value number %}

*   alias for {% text fg.input:gamepadaxis(joystick, axis, new_value) %}
<br><br>

{% methoddd textinput text string %}

*   alias for {% text fg.loveframes.textinput(text) %}
<br><br>

{% methoddd resize w number h number %}

*   resizes the screen to the new {% text w, h %} values
<br><br>

{% methoddd setScreenSize w number h number %}

*   changes the screen size to the new {% text w, h %} values
<br><br>

{% title Attributes %}

{% attribute Assets Assets table %}

*   a table to be used with [Loader](/documentation/loader) to hold resources 
<br><br>

{% attribute classes classes table %}

*   a table that holds all classes created with the {% text fg.Class %} call
<br><br>

{% attribute debug_draw debug_draw boolean %}

*   if debug drawing is enabled or not 
<br><br>

{% attribute lovebird_enabled lovebird_enabled boolean %}

*   if lovebird is enabled or not 
<br><br>

{% attribute min_size min_width number min_height number %}

*   the minimum width and height the screen can be resized to
<br><br>

{% attribute screen_scale screen_scale number %}

*   the amount of scaling (zoom) added to the screen
<br><br>

{% attribute screen_size screen_width number screen_height %}

*   the screen width and height
<br><br>

{% attribute Shaders Shaders table %}

*   a table to hold shaders
<br><br>

{% attribute Spritebatches Spritebatches table %}

*   a table to hold spritebatches
<br><br>
