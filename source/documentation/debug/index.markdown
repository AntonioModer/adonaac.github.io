---
layout: page
title: Debug 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

<h3 id="description" data-magellan-destination="description">Description</h3>

This module takes care of game debugging and uses [lovebird](https://github.com/rxi/lovebird). <code class="text">mg.lovebird</code> is an instance of <code class="text">lovebird</code> and it's through there that 
you can change it's settings. For instance, changing the port is something like <code class="text">mg.lovebird.port = 4000</code>. 

<code class="text">lovebird</code> is disabled by default and you can enable it through <code class="text">mg.lovebird_enabled = true</code>. If it's enabled, after you run your game you can inspect its state
using your browser by opening the following URL: <code class="text">http://localhost:8000</code>, something like the following image should appear:

{% img center /assets/lovebird.png %}
