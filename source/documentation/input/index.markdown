---
layout: page
title: Input 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

<h3 id="example" data-magellan-destination="example">Example</h3>

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

<h3 id="description" data-magellan-destination="description">Description</h3>

The <code class="text">mg.Input</code> class handles binding keys to actions and then enables checking of actions in the <code class="text">update</code> loop. 
An instance <code class="text">mg.input</code>
is automatically created when <code class="text">mg.init()</code> is called, but you can also create your own instances by doing <code class="text">input = mg.Input()</code>. 
To use this module you must add 
<code class="text">mg.input:keypressed</code>, <code class="text">mg.input:keyreleased</code>, <code class="text">mg.input:mousepressed</code>, <code class="text">mg.input:mousereleased</code>,
<code class="text">mg.input:gamepadpressed</code>, <code class="text">mg.input:gamepadreleased</code> and <code class="text">mg.input:gamepadaxis</code>
to their respective love callbacks.  If you create your own input instances then you also have to do this.

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

<h3 id="methods" data-magellan-destination="methods">Methods</h3>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">bind</span>(key<span class="tag">[string]</span>, action<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   <code>key</code>: the key constant, see [Constants](#constants) for a complete list of possible keys 
*   <code>action</code>: the action bound to this key
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">down</span>(action<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   <code>action</code>: the action being checked
*   <code>boolean</code> returns <code class="text">true</code> if the button bound to this action is down, <code class="text">false</code> otherwise
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">pressed</span>(action<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   <code>action</code>: the action being checked
*   <code>boolean</code> returns <code class="text">true</code> if the button bound to this action has just been pressed, <code class="text">false</code> otherwise
<br><br>


<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">released</span>(action<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   <code>action</code>: the action being checked
*   <code>boolean</code> returns <code class="text">true</code> if the button bound to this action has just been released, <code class="text">false</code> otherwise
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">unbind</span>(key<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   unbinds a key and whatever action was bound to it will no longer be activated on key press/down/release
*   <code>key</code>: the key being unbound 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">unbindAll</span>()
</pre></td>
</table></div>

*   unbinds all keys and actions
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">update</span>()
</pre></td>
</table></div>

*   updates input state
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">keypressed</span>(key<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   function to be added to LÖVE's <code class="text">keypressed</code> callback
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">keyreleased</span>(key<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   function to be added to LÖVE's <code class="text">keyreleased</code> callback
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">mousepressed</span>(button<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   function to be added to LÖVE's <code class="text">mousepressed</code> callback
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">mousereleased</span>(button<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   function to be added to LÖVE's <code class="text">mousereleased</code> callback
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">gamepadpressed</span>(joystick<span class="tag">[Joystick]</span>, button<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   function to be added to LÖVE's <code class="text">gamepadpressed</code> callback
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">gamepadreleased</span>(joystick<span class="tag">[Joystick]</span>, button<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   function to be added to LÖVE's <code class="text">gamepadreleased</code> callback
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">gamepadaxis</span>(joystick<span class="tag">[Joystick]</span>, axis<span class="tag">[GamepadAxis]</span>, new_value<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   function to be added to LÖVE's <code class="text">gamepadaxis</code> callback
<br><br>

<h3 id="attributes" data-magellan-destination="attributes">Attributes</h3>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">state</span>
</pre></td>
</table></div>

*   the current state of all keys, <code class="text">state[key]</code> is <code class="text">true</code> is the key is down, </code>false otherwise
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">binds</span>
</pre></td>
</table></div>

*   the key->action binding table, <code class="text">binds[action] = {key1, key2, ...}</code>
<br><br>

<h3 id="constants" data-magellan-destination="constants">Constants</h3>

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
'fdown' -- fdown/up/left/right = face buttons: a, b, x, y...
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
'l2'
'r2'
'dpup' -- dpad buttons
'dpdown'
'dpleft'
'dpright'
'leftx' -- from -1 to 1 left stick's horizontal position
'lefty' -- same for vertical
'rightx' -- same for right stick
'righty'
~~~
