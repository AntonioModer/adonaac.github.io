---
layout: page
title: Loader 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Description %}

A threaded resource loading module. It's an exact copy of [love-loader](https://github.com/kikito/love-loader), 
so refer to that for details on the workings of each method. A table named {% text fg.Assets %} exists so that 
you can load your assets to it, but you can use any table you'd like.

~~~ lua
function Game:new()
    -- Load assets
    fg.Loader.newImage(fg.Assets, 'female_idle', 'resources/female/idle.png')
    fg.Loader.newImage(fg.Assets, 'female_run', 'resources/female/run.png')

    self.finished_loading = false
    fg.Loader.start(function() 
        self.finished_loading = true 
        -- Do things after loading
    end)
end

function Game:update(dt)
    -- If loading then update the loader
    if not self.finished_loading then fg.Loader.update() end
    -- else update your game
end
~~~
