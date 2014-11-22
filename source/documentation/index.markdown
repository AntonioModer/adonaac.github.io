---
layout: page
title: Documentation
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

**FuccboiGDX** is composed of two parts: the <code class="text">framework</code> and the <code class="text">engine</code>.

The <code class="text">framework</code> contains some [user created LÖVE libraries](http://www.love2d.org/wiki/Category:Libraries) 
(as well as some that I created on my own) that are useful for game development. All libraries chosen are
[simple](http://www.infoq.com/presentations/Simple-Made-Easy), self-contained and composable so that they can be used independently 
of each other with few problems. This is in a similar fashion to how LÖVE's own modules work.

The <code class="text">engine</code> uses modules from the framework as well as a bunch of glue code to build a higher level
programming experience **at the cost of customizability and control**. The features provided by the engine have the goal of 
making the programmer's life easier, taking care of some tedious work usually goes into making a game, things like: box2d
wrappers, collision handling, map saving/loading, levels, pooling, and so on...

The words <code class="text">framework</code> and <code class="text">engine</code> will be used throughout the documentation
and usually you only have to pay more attention when the <code class="text">engine</code> is mentioned, since it implies that 
things are tied together in sometimes initially unintuitive or unexpected ways. I've taken care of documenting those parts
extensively so hopefully they aren't that much of a problem.

<h3 id="module_reference" data-magellan-destination="module_reference">Module Reference</h3>

**Main**

*   [fg](fg) - core, contains everything 
*   [Render](render) - orchestrates all engine rendering functionality (inside the <code class="text">fg.world</code> instance)
*   [World](world) - orchestrates all engine functionality, an instance named <code class="text">fg.world</code> is automatically created on initialization

**Logic**

*   [Class](class) - object orientation library, [Classic](https://github.com/rxi/classic)
*   [Collision](collision) - internal module used for handling box2d collisions, read to understand how collisions are handled 
*   [Debug](debug) - browser-based debug console for LÖVE, [lovebird](https://github.com/rxi/lovebird)
*   [Entity](entity) - base class for all engine game objects 
*   [Gamestate](gamestate) - game state system, [hump.gamestate](http://vrld.github.io/hump/#hump.gamestate)
*   [Input](input) - binds keys to actions and allows for pressed/released checks outside of LÖVE's callbacks 
*   [Level](level) - 
*   [Loader](loader) - threaded resource loader, [love-loader](https://github.com/kikito/love-loader)
*   [ObjectPool](pool) - 
*   [PhysicsBody](physicsbody) - mixin used for adding physics capabilities to an object 
*   [Serialization](serialization) - not done yet
*   [Solid](solid) - the base collision solid entity
*   [Tilemap](tilemap) - tilemaps with autotiling, collision solid generation and Tiled support 
*   [Timer](timer) - timers, tweens and allows timer/tween tagging, an enhanced version of [hump.timer](http://vrld.github.io/hump/#hump.timer) 
*   [Utils](utils) - utility functions for various purposes 
*   [Vector](vector) - 2D vector class, [hump.vector](http://vrld.github.io/hump/#hump.vector)

**Visual**

*   [Animation](animation) - creates animated sprites from sprite sheet images, an enhanced version of [AnAL](https://love2d.org/wiki/AnAL)
*   [Background](background) - backgrounds for use with parallaxed layers
*   [Camera](camera) - very similar to [HaxeFlixel's camera (demo)](http://haxeflixel.com/demos/FlxCamera/) with a few improvements
*   [Layer](layer) - 
*   [Particles](particles) -
*   [Text](text) - programmable text drawing
*   [UI Tools](uitools) -  

**Sound**

*   [Sound]() - 
<br>
<br>
