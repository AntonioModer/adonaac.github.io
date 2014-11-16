---
layout: page
title: Solid 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

<h3 id="description" data-magellan-destination="description">Description</h3>

A physics solid used by Mogamett to create static collision bodies. It's just a normal <code class="text">mg.Entity</code> class with an already initialized <code class="text">PhysicsBody</code> 
mixin. You can create your own instances whenever necessary, but usually the [Tilemap](/documentation/tilemap) takes care of it on its own. So far this class only works for the <code class="text">
engine</code>.
