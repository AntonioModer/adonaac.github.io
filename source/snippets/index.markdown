---
layout: page
title: Snippets
subtitle:
comments: false
sharing: false
footer: false 
sidebar: false 
---

<div id="nav" class="fixed right show-for-large-up">
<p>
<strong><a href="#framework">Framework</a></strong><br>
<a href="#main_template">main.lua template</a><br>

<br>
<strong><a href="#engine">Engine</a></strong><br>
<a href="#physics_template">physics template</a><br>
</p>
</div>

<h3 id="framework" data-magellan-destination="framework">Framework</h3>

Framework related snippets.
<br><br>

<h5 id="main_template">main.lua template</h5>

The template <code class="text">main.lua</code> file:

~~~ lua
require 'mogamett/mogamett'

function love.load()
    mg.init()
end

function love.update(dt)
    mg.update(dt)
end

function love.draw()
    mg.draw()
end

function love.keypressed(key)
    mg.keypressed(key)
end

function love.keyreleased(key)
    mg.keyreleased(key)   
end

function love.mousepressed(x, y, button)
    mg.mousepressed(button) 
end

function love.mousereleased(x, y, button)
    mg.mousereleased(button) 
end

function love.gamepadpressed(joystick, button)
    mg.gamepadpressed(joystick, button)
end

function love.gamepadreleased(joystick, button)
    mg.gamepadreleased(joystick, button)
end

function love.gamepadaxis(joystick, axis, newvalue)
    mg.gamepadaxis(joystick, axis, newvalue)
end

function love.run()
    math.randomseed(os.time())
    math.random() math.random()
    if love.math then love.math.setRandomSeed(os.time()) end
    if love.event then love.event.pump() end
    if love.load then love.load(arg) end
    if love.timer then love.timer.step() end
    mg.run()
end
~~~

<br><br>

<h3 id="engine" data-magellan-destination="engine">Engine</h3>

Engine related snippets.
<br><br>

<h5 id="physics_template">physics entity template</h5>

The template <code class="text">physics enabled class</code>:

~~~ lua
MyClass = mg.class('MyClass', 'Entity')
MyClass:implement(mg.PhysicsBody)

function MyClass:new(world, x, y, settings)
    MyClass.super.new(self, world, x, y, settings)
    self:physicsBodyNew(world, x, y, settings)
end

function MyClass:update(dt)
    self:physicsBodyUpdate(dt)
end

function MyClass:draw()
    self:physicsBodyDraw()
end
~~~
