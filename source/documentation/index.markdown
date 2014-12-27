---
layout: page
title: documentation
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

**fuccboiGDX** is composed of two parts: the {% text framework %} and the {% text engine %}.

The {% text framework %} contains some [user created LÖVE libraries](http://www.love2d.org/wiki/Category:Libraries) 
that are useful for game development. Most libraries chosen are [simple](http://www.infoq.com/presentations/Simple-Made-Easy), 
self-contained and composable so that they can be used independently of each other with few problems. This is in a similar 
fashion to how LÖVE's own modules work.

The {% text engine %} uses modules from the framework as well as a bunch of glue code to build a higher level
programming experience **at the cost of customizability and control**. The features provided by the engine have the goal of 
making the programmer's life easier, taking care of some tedious work usually goes into making a game, things like: box2d
wrappers, collision handling, map saving/loading, levels, pooling, and so on...

The words {% text framework %} and {% text engine %} will be used throughout the documentation
and usually you only have to pay more attention when the {% text engine %} is mentioned, since it implies that 
things are tied together in sometimes initially unintuitive or unexpected ways. I've taken care of documenting those parts
extensively so hopefully they aren't that much of a problem.

{% title Modules %}

**Main**

*   [fg](fg) - core, contains everything 
*   [Render](render) - orchestrates all engine rendering functionality (inside the {% text fg.world %} instance)
*   [World](world) - orchestrates all engine functionality, an instance named {% text fg.world %} is automatically created on initialization

**Logic**

*   [Area](area) - an area/level/map where objects reside in
*   [Class](class) - object orientation library, [rxi/classic](https://github.com/rxi/classic)
*   [Collision](collision) - internal module used for handling box2d collisions, read to understand how collisions are handled 
*   [Debug](debug) - browser-based debug console for LÖVE, [rxi/lovebird](https://github.com/rxi/lovebird)
*   [Entity](entity) - base class for all engine game objects 
*   [Gamestate](gamestate) - game state system, [vrld/hump.gamestate](http://vrld.github.io/hump/#hump.gamestate)
*   [Input](input) - binds keys to actions, allows for pressed/released checks outside of LÖVE's callbacks and supports gamepads
*   [Loader](loader) - threaded resource loader, [kikito/love-loader](https://github.com/kikito/love-loader)
*   [ObjectPool](pool) - object pooling for higher performance on objects that are killed/created often
*   [PhysicsBody](physicsbody) - mixin used for adding physics capabilities to an object 
*   [Serial](serial) - serialization for areas, objects and tables, uses [gvx/Ser](https://github.com/gvx/Ser) internally
*   [Solid](solid) - the base collision solid entity
*   [Timer](timer) - timers, tweens and allows timer/tween tagging, an enhanced version of [vrld/hump.timer](http://vrld.github.io/hump/#hump.timer) 
*   [Utils](utils) - random utility functions, [rxi/lurker](http://github.com/rxi/lurker), [Yonaba/Moses](https://github.com/Yonaba/Moses), [davisdude/mlib](https://github.com/davisdude/mlib)
*   [Vector](vector) - 2D vector class, [vrld/hump.vector](http://vrld.github.io/hump/#hump.vector)

**Visual**

*   [Animation](animation) - creates animated sprites from sprite sheet images, an enhanced version of [bartbes/AnAL](https://love2d.org/wiki/AnAL)
*   [Background](background) - backgrounds for use with parallaxed layers
*   [Camera](camera) - similar to [HaxeFlixel's camera](http://haxeflixel.com/demos/FlxCamera/) with a few improvements, an enhanced version of [vrld/hump.camera](http://vlrd.github.io/hump/#hump.camera)
*   [Particles (Engine)](particles) - a simple particle systems module, also has an editor for editing particle systems
*   [Spritebatch](spritebatch) - batch draw calls from a single image for more performant draw code
*   [Text](text) - programmable text drawing
*   [Tilemap](tilemap) - tilemaps with autotiling, collision solid generation and Tiled support 
*   [UI Tools](uitools) - UI module for building tools, [KennyShields/loveframes](https://github.com/KennyShields/LoveFrames) 

**Sound**

*   [Sound](sound) - sound management system, [(Ensayia & Taehl)/TEsound](https://love2d.org/wiki/TEsound)
<br><br>
