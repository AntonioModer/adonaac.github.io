---
layout: page
title: Input 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

<div data-alert class="alert-box info radius">
    Gamepads may not work correctly until LÖVE 0.9.2 is released.
</div>

{% title Example %}

~~~ lua
-- bind the key 'a' to the action 'move_left' on initialization
mg.input:bind('a', 'move_left')

-- check if the action 'move_left' is being pressed on update
if mg.input:down('move_left') then
    local vx, vy = self.body:getLinearVelocity()
    self.body:setLinearVelocity(-200, vy)
end
~~~
<br>

{% title Description %}

The {% text mg.Input %} class handles binding keys to actions and then enables checking of actions in the {% text update %} loop. 
The instance {% text mg.input %} is automatically created when {% text mg.init() %} is called, but you can also create your own 
instances by doing {% text input = mg.Input %}. If you do this you must add {% text input:keypressed %}, {% text input:keyreleased %}, 
{% text input:mousepressed %}, {% text input:mousereleased %}, {% text input:gamepadpressed %}, {% text input:gamepadreleased %},
{% text input:gamepadaxis %} to their respective love callbacks. The {% text main.lua %} file that ships with FuccboiGDX already does this
for the default {% text mg.input %} instance (via the {% text mg.[whatever] %} calls).

~~~ lua
function love.load()
    mg = require 'mogamett'
    mg.init()
    input = mg.Input()
end

function love.keypressed(key)
    mg.keypressed(key)
    input:keypressed(key)
end

function love.keyreleased(key)
    mg.keyreleased(key)
    input:keyreleased(key)
end

function love.mousepressed(x, y, button)
    mg.mousepressed(button)
    input:mousepressed(button)
end

function love.mousereleased(x, y, button)
    mg.mousereleased(button)
    input:mousereleased(button)
end

function love.gamepadpressed(joystick, button)
    mg.gamepadpressed(joystick, button)
    input:gamepadpressed(joystick, button)
end

function love.gamepadreleased(joystick, button)
    mg.gamepadreleased(joystick, button)
    input:gamepadreleased(joystick, button)
end

function love.gamepadaxis(joystick, axis, new_value)
    mg.gamepadaxis(joystick, axis, new_value)
    input:gamepadaxis(joystick, axis, new_value)
end
~~~
<br>

{% title Methods %}

{% method bind key string action string %}

*   {% param key %}: the key constant, see [Constants](#constants) for a complete list of possible keys 
*   {% param action %}: the action name bound to this key
<br><br>

{% method down action string %}

*   returns {% text true %} if the button bound to this action is down, {% text false %} otherwise
*   {% param action %}: the action being checked
<br><br>

{% method pressed action string %}

*   returns {% text true %} if the button bound to this action has just been pressed, {% text false %} otherwise
*   {% param action %}: the action being checked
<br><br>

{% method released action string %}

*   returns {% text true %} if the button bound to this action has just been released, {% text false %} otherwise
*   {% param action %}: the action being checked
<br><br>

{% method unbind key string %}

*   unbinds a key, and whatever action was bound to it will no longer be activated on key press/down/release
*   {% param key %}: the key being unbound 
<br><br>

{% method unbindAll %}

*   unbinds all keys and actions
<br><br>

{% method update %}

*   updates input state
<br><br>

{% method keypressed key string %}

*   function to be added to LÖVE's {% text keypressed %} callback
<br><br>

{% method keyreleased key string %}

*   function to be added to LÖVE's {% text keyreleased %} callback
<br><br>

{% method mousepressed button string %}

*   function to be added to LÖVE's {% text mousepressed %} callback
<br><br>

{% method mousereleased button string %}

*   function to be added to LÖVE's {% text mousereleased %} callback
<br><br>

{% method gamepadpressed joystick Joystick button string %}

*   function to be added to LÖVE's {% text gamepadpressed %} callback
<br><br>

{% method gamepadreleased joystick Joystick button string %}

*   function to be added to LÖVE's {% text gamepadreleased %} callback
<br><br>

{% method gamepadaxis joystick Joystick axis GamepadAxis new_value string %}

*   function to be added to LÖVE's {% text gamepadaxis %} callback
<br><br>

{% title Constants %}

Keyboard keys remain the same as LÖVE's [key constants](http://www.love2d.org/wiki/KeyConstant). Mouse and gamepad buttons have been changed to the following:

~~~ lua
-- Mouse
'mouse1'
'mouse2'
'mouse3'
'mouse4'
'mouse5'
'wheelup'
'wheeldown'

-- Gamepad
'fdown' -- fdown/up/left/right = face buttons: a, b...
'fup'
'fleft'
'fright'
'back'
'guide'
'start'
'leftstick' -- left stick pressed or not (boolean)
'rightstick' -- right stick pressed or not (boolean)
'l1'
'r1'
'l2' -- from 0 to 1
'r2' -- from 0 to 1
'dpup' -- dpad buttons
'dpdown'
'dpleft'
'dpright'
'leftx' -- from -1 to 1 left stick's horizontal position
'lefty' -- same for vertical
'rightx' -- same for right stick
'righty'
~~~
