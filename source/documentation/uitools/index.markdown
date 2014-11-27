---
layout: page
title: UI Tools 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Description %}

An UI module appropriate for building tools (not that useful for your game's UI probably). It's an exact copy of 
[loveframes](https://github.com/KennyShields/LoveFrames), so refer to that for details on the workings of the module.

~~~ lua
function love.load()
    mg.init()

    -- loveframes' Getting Started example
    local parent_frame = mg.loveframes.Create('frame')
    local button = mg.loveframes.Create('button', parent_frame)
    button:SetPos(5, 35)
end
~~~

Should create this:

{% img center /assets/loveframes.png %}
