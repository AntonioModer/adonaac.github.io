---
layout: page
title: Camera 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

<div data-alert class="alert-box info radius">
    Resizing and scaling the screen may cause unexpected bugs with cameras
    if the zoom calls are used with the engine. Try to use fg.screen_scale instead.
</div>

{% title Example %}

~~~ lua
-- initialize the camera, passing a settings table with optional parameters or setting them directly
camera = fg.Camera({lerp = 3, follow_style = 'lockon', target = followed_entity})
camera.debug_draw = true

-- update the camera
camera:update(dt)

-- draw the camera, attach/detach applies/removes camera transforms
camera:attach()
entities:draw()
camera:detach()
~~~
<br>

{% title Description %}

The {% text fg.Camera %} module handles basic things that a camera should handle, like translations, 
rotations and scaling, but also adds a bunch of high level features such as target tracking, lerp 
(delay between camera position and target position), lead (how much in front of the target the camera should be), 
deadzones and camera shakes.  An instance {% text fg.world.camera %} is automatically created on initialization, 
but you can also create your own instances doing {% text camera = fg.Camera() %}.

This module is based on [hump.camera](http://vrld.github.io/hump/#hump.camera) and has been modified for additional 
functionality and consistency. Also, check [HaxeFlixel's camera demo](http://haxeflixel.com/demos/FlxCamera/) for an 
example on how lerp, lead and targetting modes work. This module copies HaxeFlixel's camera pretty closely for those
features.
<br><br>

{% title Methods %}

{% method new settings table[optional] %}

*   {% param settings %}: a table containing all camera initialization settings, all values are optional 

Possible settings:

*   {% param x, y %}: the initial position of the camera, defaults to the center of the screen 
*   {% param bounds %}: a table in the format {% text left = [number], top = [number], right = [number], down = [number] %}
*   {% param follow_style %}: the follow style: {% string 'lockon' %}, {% string 'screen' %}, {% string 'platformer' %}, 
{% string 'topdown' %} or {% string 'topdown-tight' %}, defaults to {% string 'lockon' %}
*   {% param lead %}: the initial lead value, defaults to {% text {x = 0, y = 0} %} 
*   {% param lerp %}: the initial lerp value, defaults to {% number 0 %} 
*   {% param max_shake_intensity %}: the maximum amount of camera shake, defaults to {% number 15 %} 
*   {% param rotation %}: the initial rotation of the camera, defaults to {% number 0 %} 
*   {% param target %}: the tracked object, defaults to {% text nil %}; the object must have {% text .x, .y %} fields.
<br><br>

{% method update dt number %}

*   {% param dt %}: delta value passed from the main loop to update the camera
<br><br>

{% method draw func function %}

*   automatically wraps a function between {% call :attach %} and {% call :detach %} calls
*   {% param func %}: the function to be drawn

~~~ lua
function love.draw()
    camera:draw(drawWorld)
    drawUI()
end
~~~
<br>

{% method attach %}

*   attaches the camera, applying all its transformations until {% call :detach %} is called 
<br><br>

{% method detach %}

*   detaches the camera, removing all its transformations

~~~ lua
function love.draw()
    camera:attach()
    drawWorld()
    camera:detach()
    drawUI()
end
~~~
<br>

{% method follow target table settings table[optional] %}

*   sets a new target, follow style, lead and lerp values and resets the deadzone according to the follow style
*   {% param target %}: the new target to follow, must have {% text .x, .y %} fields 
*   {% param settings %}: a table containing target following settings, all values are optional 

Possible settings:

*   {% param follow_style %}: the follow style: {% string 'lockon' %}, {% string 'screen' %}, {% string 'platformer' %}, 
{% string 'topdown' %} or {% string 'topdown-tight' %}, defaults to the already set follow style
*   {% param lead %}: the new lead value, defaults to the already set lead value 
*   {% param lerp %}: the new lerp value, defaults to the already set lerp value 
<br><br>

{% method getPosition %}

*   returns the {% text .x, .y %} camera position 
<br><br>

{% method getMousePosition %}

*   returns the {% text .x, .y %} mouse position in world coordinates 
<br><br>

{% method getCameraCoords x number y number %}
{% method getWorldCoords x number y number %}

Because a camera has a point it looks at, a rotation and a zoom factor, it defines a coordinate system. A point now has two sets of coordinates: one defines where the point is to be found 
in the game world, and the other describes the position on the computer screen. The first set of coordinates is called world coordinates, the second one camera coordinates. Sometimes it is 
needed to convert between the two coordinate systems, for example to get the position of a mouse click in the game world in a strategy game, or to see if an object is visible on the screen.

*   returns the converted {% text .x, .y %} position
*   {% param x, y %}: the position in camera/world coordinates to be converted

~~~ lua
x, y = camera:getWorldCoords(love.mouse.getPosition())
selectedUnit:plotPath(x, y)

x, y = camera:getCameraCoords(player.x, player.y)
love.graphics.line(x, y, love.mouse.getPosition())
~~~
<br>

{% method removeBounds %}

*   removes the current set bounds
<br><br>

{% method setBounds left number top number right number down number %}

*   {% param left, top, right, down %}: the boundaries the camera can't get past, in world coordinates
<br><br>

{% method setDeadzone left number top number right number down number %}

*   defines a rectangle around the center of the screen where the target moves without camera tracking
*   {% param left, top, right, down %}: the deadzone positions, in screen coordinates assuming {% number 0, 0 %} is the center
<br><br>

{% method shake intensity number duration number settings table[optional] %}

*   {% param intensity %}: the amount of pixels the camera should shake around
*   {% param duration %}: the amount of seconds the camera should shake for
*   {% param settings %}: a table containing camera shake settings, all values are optional

Possible settings:

*   {% param direction %}: the direction in which to shake: {% string 'vertical' %}, {% string 'horizontal' %} or {% string 'both' %}, defaults to {% string 'both' %} 

~~~ lua
camera:shake(5, 0.5, {direction = 'vertical'})
~~~
<br>

{% method move x number y number %}

*   moves the camera by some amount, equivalent to {% text camera.x, camera.y = camera.x + x, camera.y + y %}
*   {% param x, y %}: the amount to move the camera by 
<br><br>

{% method moveTo x number y number %}

*   {% param x, y %}: the new camera position
<br><br>

{% method rotate angle number %}

*   rotates the camera by some angle, equivalent to {% text camera.rotation = camera.rotation + angle %}
*   {% param angle %}: the amount to rotate the camera by
<br><br>

{% method rotateTo angle number %}

*   {% param angle %}: the new camera angle 
<br><br>

{% method zoom scale number %}

*   zooms the camera by some angle, equivalent to {% text camera.scale = camera.scale + scale %} 
*   {% param scale %}: the amount to scale the camera by
<br><br>

{% method zoomTo scale number %}

*   {% param scale %}: the new camera scale
<br><br>

{% title Attributes %}

{% attribute debug_draw debug_draw boolean %}

*   debug drawing, shows the current follow style, lead and lerp, as well as the deadzone and current target 
<br><br>

{% attribute follow_style follow_style string %}

*   the camera follow_style, only set with the {% call :follow %} call, otherwise the deadzone doesn't get reset 
<br><br>

{% attribute lead lead number %}

*   how much the camera should be ahead of the moving target 
<br><br>

{% attribute lerp lerp number %}

*   how much the camera should lag behind the moving target 
<br><br>

{% attribute max_shake_intensity max_shake_intensity number %}

*   the maximum intensity the camera can shake for 
<br><br>

{% attribute target target table %}

*   the target the camera should follow, needs to have {% text .x, .y %} fields
<br><br>
