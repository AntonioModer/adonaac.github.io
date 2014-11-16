---
layout: page
title: Documentation
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---


**Mogamett** is composed of two parts: the <code class="text">framework</code> and the <code class="text">engine</code>. 

The <code class="text">framework</code> part contains some [user created LÖVE libraries](http://www.love2d.org/wiki/Category:Libraries) that I found useful for game development. A few of them have been
improved upon, while others work pretty much the same. All libraries chosen are self-contained, composable and well designed enough that they can be used independently of each
other with no problems. This is in a similar fashion to how LÖVE's own modules work.

The <code class="text">engine</code> part uses libraries from the framework to build a higher level programming experience **at the cost of customizability and control**. 
The features provided by the engine have the goal of making your life easier, taking care of some boring/tedious work that usually goes into making a game, things like: 
box2d physics wrapping, collision handling, map saving/loading, level transitioning and so on... This is ideal for game jams or fast prototypes. 

Some helpful snippets/templates can be found [here](/snippets). Use the main.lua one to get started with the engine.

<h3 id="module_reference" data-magellan-destination="module_reference">Module Reference</h3>

**Main**

*   [mg](mg) - holds all framework and engine functionality
*   Core (Engine) - not done yet
*   Render (Engine) - not done yet
*   [World (Engine)](world) - orchestrates all engine functionality, an instance <code class="text">mg.world</code> is automatically created on init

**Logic**

*   [Class](class) - OOP library for Lua, [Classic](https://github.com/rxi/classic)
*   [Collision (Engine)](collision) - internal module used for handling box2d collisions, read if you want to use the engine
*   Components/Mixins - will contain a list of generic components/mixins to be reused across multiple games
*   [Debug](debug) - browser-based debug console for LÖVE, [lovebird](https://github.com/rxi/lovebird)
*   [Entity](entity) - base class for all engine game objects 
*   [Group](group) - bundles entities together, letting you organize things better and apply actions to multiple entities 
*   [Gamestate](gamestate) - game state system, [hump.gamestate](http://vrld.github.io/hump/#hump.gamestate)
*   [Input](input) - binds keys to actions and allows for pressed/released checks outside of LÖVE's callbacks 
*   Level - not done yet
*   [Loader](loader) - threaded resource loader, [love-loader](https://github.com/kikito/love-loader)
*   Map Editor - not done yet 
*   Object Pool (Engine) - not done yet
*   [PhysicsBody (Engine)](physicsbody) - mixin used for adding physics capabilities to an object 
*   Serialization - not done yet
*   [Solid (Engine)](solid) - the base collision solid entity
*   [Tilemap](tilemap) - tilemaps with autotiling and collision solid generation support 
*   [Timer](timer) - handles timers, tweens and allows timer/tween tagging, an enhanced version of [hump.timer](http://vrld.github.io/hump/#hump.timer) 
*   [Utils](utils) - utility functions for various purposes 
*   [Vector](vector) - 2D vector class, [hump.vector](http://vrld.github.io/hump/#hump.vector)

**Visual**

*   [Animation](animation) - creates animated sprites from sprite sheet images, an enhanced version of [AnAL](https://love2d.org/wiki/AnAL)
*   [Background](background) - backgrounds for use with parallaxed layers
*   [Camera](camera) - very similar to [HaxeFlixel's camera (demo)](http://haxeflixel.com/demos/FlxCamera/), also with screen shakes
*   Layer - not done yet
*   [Particles (Engine)](particles) - not done yet
*   [Text](text) - draws text with all sorts of effects and behaviors
*   UI Game - not done yet
*   UI Tools - not done yet 

**Sound**

*   Sound - not done yet 
<br>
<br>
