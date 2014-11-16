---
layout: page
title: Loader 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

<h3 id="description" data-magellan-destination="description">Description</h3>

A threaded resource loading module. It's an exact copy of [love-loader](https://github.com/kikito/love-loader), so refer to that for details on the workings of each method. A table named
<code class="text">mg.Assets</code> exists so that you can load your assets to it, but you can use any table you'd like.

~~~ lua
function Game:new()
    -- Load assets
    mg.Loader.newImage(mg.Assets, 'female_idle', 'resources/female/idle.png')
    mg.Loader.newImage(mg.Assets, 'female_run', 'resources/female/run.png')

    self.finished_loading = false
    mg.Loader.start(function() 
        self.finished_loading = true 
        -- Do things after loading
    end)
end

function Game:update(dt)
    -- If loading then update the loader
    if not self.finished_loading then mg.Loader.update() end
    -- Else update your game
end
~~~
