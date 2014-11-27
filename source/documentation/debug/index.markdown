---
layout: page
title: Debug 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Description %}

This module takes care of game debugging and uses [lovebird](https://github.com/rxi/lovebird). {% text mg.lovebird %}
is an instance of {% text lovebird %} and it's through there that you can change its settings. For instance, 
changing the port goes something like {% text mg.lovebird.port = 4000 %}. 

{% text lovebird %} is disabled by default and you can enable it through {% text mg.lovebird_enabled = true %}. 
If it's enabled, after you run your game you can inspect its state using your browser by opening the following URL
on your browser: {% text http://localhost:8000 %}, something like the following image should appear:

{% img center /assets/lovebird.png %}
