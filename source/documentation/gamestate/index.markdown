---
layout: page
title: Gamestate 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Description %}

A game state systems module. It's an exact copy of [hump.gamestate](http://vrld.github.io/hump/#hump.gamestate), so refer to that for details on the workings of each method.

~~~ lua
function love.load()
    mg.init()

    -- Create game
    game = Game()
    -- Makes it so that you don't have to add game:update, game:draw to love.update, love.draw
    mg.Gamestate.registerEvents()
    -- Switch the current state to the game
    mg.Gamestate.switch(game)
end

function love.update(dt)
    mg.update(dt)
end

function love.draw()
    mg.draw()
end
~~~
