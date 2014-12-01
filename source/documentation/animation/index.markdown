---
layout: page
title: Animation
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Example %}

{% img center /assets/girlrun.png spritesheet.png %}

~~~ lua
-- the above image is spritesheet.png, each of its frames is 64x64
-- create the animation, parameters are: image, width, height, delay
animation = mg.Animation(love.graphics.newImage('spritesheet.png'), 64, 64, 0.1)

-- update the animation
animation:update(dt)

-- draw the animation
animation:draw(x, y)
-- the below image is the result, 'loop' mode is set by default
~~~

{% img center /assets/girlrun.gif %}

{% title Description %}

The {% text mg.Animation %} class handles the creation of animated sprites from sprite sheets. 
You have control over what to do with the animation itself, since it's returned and you just hold it in a variable. 
The draw operation, like LÖVE's, also takes rotation, scaling and shearing parameters after {% text x, y %}. The module
also supports reading sprite sheets from texture atlases on top of isolated spritesheets.
<br><br>

{% title Methods %}

{% method new image Image width number height number delay number frames number[optional] %}

*   {% param image %}: the sprite sheet containing the full animation
*   {% param width, height %}: the width and height of each frame 
*   {% param delay %}: the delay between each frame in seconds
*   {% param frames %}: the number of frames to use for this animation, omitting this parameter or passing {% number 0 %} tells the library to automatically handle it
<br><br>

{% method new image Image x number y number width number height number delay number frames number %}

*   {% param image %}: the texture atlas containing the full animation and 
*   {% param x, y %}: the top-left position of the first animation frame
*   {% param width, height %}: the width and height of each frame
*   {% param delay %}: the delay between each frame in seconds
*   {% param frames %}: the number of frames to use for this animation, can't be omitted or {% number 0 %} when using a texture atlas
<br><br>

{% method update dt number %}

*   {% param dt %}: delta value passed from the main loop to update the animation
<br><br>

{% method draw x number y number %}

*   {% param x, y %}: position to draw the animation, with optional values as seen in [love.graphics.draw](http://www.love2d.org/wiki/love.graphics.draw)
<br><br>

{% method addFrame x number y number width number height number delay number %}

*   {% param x, y %}: left top coordinate of the frame on the original sprite sheet
*   {% param width, height %}: the width and height of each frame
*   {% param delay %}: the delay between each frame in seconds
<br><br>

{% method getHeight %}

*   returns the height of the current frame
<br><br>

{% method getWidth %}

*   returns the width of the current frame
<br><br>

{% method play %}

*   starts the animation if it was stopped
<br><br>

{% method reset %}

*   goes back to the first frame
<br><br>

{% method seek frame number %}

*   {% param frame %}: the frame position to seek, minimum is {% number 1 %} and maximum is {% text .size %}
<br><br>

{% method setDelay frame number delay number %}

*   {% param frame %}: the frame position to set the delay
*   {% param delay %}: the new delay
<br><br>

{% method setMode mode string %}

*   {% param mode %}: the animation play mode

Possible modes:

*   {% param 'loop' %}: loops the animation after it's over
*   {% param 'once' %}: plays the animation only once
*   {% param 'bounce' %}: play it once, play it in reverse, play it again (looping)
<br><br>

{% method setSpeed speed number %}

*   {% param speed %}: the speed to play the animation at, {% number 1 %} is normal, {% number 2 %} is twice as fast...
<br><br>

{% method stop %}

*   stops the animation
<br><br>

{% title Attributes %}

{% attribute current_frame current_frame number %}

*   the frame currently being displayed, minimum is {% number 1 %} and maximum is {% text .size %}
<br><br>

{% attribute frame_height frame_height number %}

*   the height of the animation, can also be accessed through {% call :getHeight %}
<br><br>

{% attribute frame_width frame_width number %}

*   the width of the animation, can also be accessed through <code class="atrm">:getWidth()</code>
<br><br>

{% attribute size size number %}

*   the number of frames the animation has
<br><br>
