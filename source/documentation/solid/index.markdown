---
layout: page
title: Solid 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Description %}

A physics solid used by fuccboiGDX to create static collision bodies. It's just a normal {% text fg.Entity %}
class with an already initialized {% text PhysicsBody %} mixin. You can create your own instances whenever 
necessary, but usually the [Tilemap](/documentation/tilemap) (if you're using it) takes care of it via the
{% call :generateCollisionSolids %} call. This class works only for the {% text engine %}, meaning in conjunction
with the use of the {% text fg.world %} instance.
