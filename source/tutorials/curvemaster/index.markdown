---
layout: page
title: CurveMaster 
subtitle:
comments: true 
sharing: false
footer: true
sidebar: false 
---

<dl class="accordion" data-accordion>
<dd>
<a href="#panel30">Requirements</a>
<div id="panel30" class="content">
<ul class="require">
<li>Basic Programming Concepts</li>
<li><a href="http://nova-fusion.com/2012/08/27/lua-for-programmers-part-1/">Lua</a></li>
<li>LÖVE</li>
<li>Basic Game Programming</li>
<li>Object Oriented Programming</li>
</ul>
</div>
</dd>
</dl>

*   [How to read requirements](/requirements)
*   [How to do exercises](/exercise)
<br><br>

This tutorial will teach you about some of the basic features of the Mogamett Framework through building an enhanced version of Pong.

{% img center /assets/curvemaster.gif %}

You should have the framework [downloaded](/downloads/mogamett.zip) and [setup](/snippets#main_template) properly.
<br><br>

{% title Ball %}

The first we're gonna do is create the main ball. Since we're using the framework 
(which means that we're using each module on their own, without being tied to the 
{% text engine %} through {% text fg.world %}), we'll use the 
[Class](/documentation/class) module to do it:

~~~ lua
-- in Ball.lua
local Ball = fg.Object:extend('Ball')

function Ball:new()

end

function Ball:update(dt)

end

function Ball:draw()

end

return Ball
~~~

A ball needs a few attributes like position, radius, velocity and the angle it's moving 
towards... We'll add that to the Ball's class constructor, but do it in a manner that 
enables further attribute addition whenever desired without having to change the 
constructor that much:

~~~ lua
function Ball:init(x, y, settings)
    local settings = settings or {}
    self.x, self.y = x, y
    self.r = settings.r or 30
    self.v = settings.v or mg.Vector(400, 400)
    self.angle = settings.angle or 0
end
~~~

By passing a named table named {% text settings %}, we can take its values when they 
are defined or fall back to default ones when they aren't (that's what the {% text or %}
does). So on object creation we can do:

~~~ lua
Ball = require 'Ball'

function Game:new()
    ball = Ball(fg.screen_width/2, fg.screen_height/2, {angle = math.pi/4})
end
...
~~~

And this creates a ball with {% text angle = math.pi/4 %}, 
{% text v = mg.Vector(100, 100) %} and {% text r = 15 %}. This construct is 
the same as the one used by {% text engine %} entities, and it's a pretty flexible 
and useful way of organizing object construction. 

Another thing to note here is that we're returning the Ball class and storing it in
a global variable of the same name. This is just a useful thing to note, since it lets
you change how classes behave dynamically (if you ever need that for whatever reason).

In any case, now we want to update and draw the ball so that it moves like it would 
on a Pong game:

~~~ lua
-- in Ball.lua
function Ball:update(dt)
    self.x = self.x + self.v.x*math.cos(self.angle)*dt
    self.y = self.y + self.v.y*math.sin(self.angle)*dt
end

function Ball:draw()
    love.graphics.rectangle('fill', self.x - self.r/2, self.y - self.r/2, self.r, self.r)
end

-- in Game.lua
function Game:update(dt)
    ball:update(dt)
end

function Game:draw()
    ball:draw()
end
~~~

The ball update function does basic movement based on the ball's angle, and the draw 
function draws the rectangle (yes, it should be a circle, but let's be **~~RADICAL~~** 
and do a rectangle instead). The ball moves to one direction but quickly moves out 
of the screen's boundaries. For that not to happen we can do the following:

~~~ lua
function Ball:update(dt)
    ...
    if self.x < 0 + self.r/2 then
        self.angle = math.pi - self.angle
    end
    if self.x > fg.screen_width - self.r/2 then
        self.angle = math.pi - self.angle
    end
    if self.y < 0 + self.r/2 then
        self.angle = -self.angle
    end
    if self.y > fg.screen_height - self.r/2 then
        self.angle = -self.angle
    end
end
~~~

This will make it so that the ball bounces off of the screen's edges like it's expected 
to do. Not adding the {% text +-self.r/2 %} to the checks makes it so that the ball 
goes a bit off screen before bouncing back, because the position is the center of the 
sprite and not one of its edges.
<br><br>

{% title Paddles %}

To add the paddles we create a Paddle class in a similar fashion to the way we did the 
Ball:

~~~ lua
Paddle = mg.Class('Paddle')

function Paddle:init(x, y, settings)
    local settings = settings or {}
    self.x, self.y = x, y
    self.w = settings.w or 30
    self.h = settings.h or 100
end

function Paddle:update(dt)
    _, self.y = love.mouse.getPosition()
end

function Paddle:draw()
    love.graphics.rectangle('fill', self.x - self.w/2, self.y - self.h/2, self.w, self.h)
end
~~~

This makes it so that the paddle follows the mouse position on the y axis. To create 
both paddles you can do:

~~~ lua
...
Paddle = require 'Paddle'

function Game:new()
    ...
    paddle1 = Paddle(15, 50)
    paddle2 = Paddle(fg.screen_width - 15, 50)
end

function Game:update(dt)
    ...
    paddle1:update(dt)
    paddle2:update(dt)
end

function Game:draw()
    ...
    paddle1:draw()
    paddle2:draw()
end
~~~

This should create two paddles, one on the left and another on the right of the screen. 
They should both follow the mouse's y position.

<dl class="accordion" data-accordion>
<dd>
<a href="#panel1">Exercises</a>
<div id="panel1" class="content">
<ol>
    <li> Like the ball previously could, the paddles can go offscreen if you move the mouse close to the borders of the screen. Prevent this from happening!
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel5">Answer</a>
        <div id="panel5" class="content answer">
        Check the paddle's y position against the screen's top and bottom borders and force that position in case it's past it, taking into account the paddle's height:<br><br>
<div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
<a href="#n2" name="n2">2</a>
<a href="#n3" name="n3">3</a>
<a href="#n4" name="n4">4</a>
<a href="#n5" name="n5">5</a>
<a href="#n6" name="n6">6</a>
<a href="#n7" name="n7">7</a>
<a href="#n8" name="n8">8</a>
<a href="#n9" name="n9">9</a>
</pre></td>
  <td class="code"><pre><span class="keyword">function</span> Paddle:<span class="function">update</span>(dt)
    ...
    <span class="keyword">if</span> self.y &lt; <span class="integer">0</span> + self.h/<span class="integer">2</span> <span class="keyword">then</span>
        self.y = <span class="integer">0</span> + self.h/<span class="integer">2</span>
    <span class="keyword">end</span>
    <span class="keyword">if</span> self.y &gt; <span class="integer">600</span> - self.h/<span class="integer">2</span> <span class="keyword">then</span>
        self.y = <span class="integer">600</span> - self.h/<span class="integer">2</span>
    <span class="keyword">end</span>
<span class="keyword">end</span>
</pre></td>
</tr></table>
</div>
        </div>
        </dd>
        </dl>
    </li>
</ol>
</div>
</dd>
</dl>
<br>

<h3 id="collision" data-magellan-destination="collision">Ball-Paddle Collision</h3>

The ball doesn't collide with the paddles yet... But in a similar manner to how we did it for the borders of the screen we can do it for the paddles. Check the ball's position 
against the position of each paddle and change its angle accordingly:

~~~ lua
function Ball:update(dt)
    ...
    if (self.x - self.r/2 <= paddle1.x + paddle1.w/2) and 
       (self.y >= paddle1.y - paddle1.h/2) and (self.y <= paddle1.y + paddle1.h/2) then
        self.angle = math.pi - self.angle
    end
end
~~~

The check first sees if the ball's x position is to the left of the right edge of the left paddle (!), and then on top of that checks if the ball's y position is inside the left paddle's
top and bottom edges. If all of those conditions are met then the ball is bounced back.

<dl class="accordion" data-accordion>
<dd>
<a href="#panel2">Exercises</a>
<div id="panel2" class="content">
<ol>
    <li> Perform that check for the right paddle as well.
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel3">Answer</a>
        <div id="panel3" class="content answer"><br>
<div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
<a href="#n2" name="n2">2</a>
<a href="#n3" name="n3">3</a>
<a href="#n4" name="n4">4</a>
<a href="#n5" name="n5">5</a>
<a href="#n6" name="n6">6</a>
<a href="#n7" name="n7">7</a>
</pre></td>
  <td class="code"><pre><span class="keyword">function</span> Ball:<span class="function">update</span>(dt)
    ...
    <span class="keyword">if</span> (self.x + self.r/<span class="integer">2</span> &gt;= paddle2.x - paddle2.w/<span class="integer">2</span>) <span class="keyword">and</span> 
       (self.y &gt;= paddle2.y - paddle2.h/<span class="integer">2</span>) <span class="keyword">and</span> (self.y &lt;= paddle2.y + paddle2.h/<span class="integer">2</span>) <span class="keyword">then</span>
        self.angle = math.pi - self.angle
    <span class="keyword">end</span>
<span class="keyword">end</span>
</pre></td>
</tr></table>
</div>

        </div>
        </dd>
        </dl>
    </li>
    <br>

    <li> Sometimes if the ball hits a paddle in one of its top or bottom edges it will behave strangely. The reason this happens is because it keeps changing angle repeatedly, since sometimes
    the collision check is satisfied multiple times. How would you go about avoiding this? (<strong>hint</strong>: create a <code class="atrm">.just_hit_paddle</code> boolean and use the
    <a href="/documentation/timer">Timer</a> module)
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel29">Answer</a>
        <div id="panel29" class="content answer">
        The way to solve this is by completely ignoring the collision checks if the ball has just hit a paddle. When a collision actually happens, set .just_hit_paddle to true and then after
        some time, in this case 0.2 seconds, set it to false again. This prevents collisions between ball and paddle to happening too close to each other:<br><br>
<div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
<a href="#n2" name="n2">2</a>
<a href="#n3" name="n3">3</a>
<a href="#n4" name="n4">4</a>
<a href="#n5" name="n5">5</a>
<a href="#n6" name="n6">6</a>
<a href="#n7" name="n7">7</a>
<a href="#n8" name="n8">8</a>
<a href="#n9" name="n9">9</a>
<strong><a href="#n10" name="n10">10</a></strong>
<a href="#n11" name="n11">11</a>
<a href="#n12" name="n12">12</a>
<a href="#n13" name="n13">13</a>
<a href="#n14" name="n14">14</a>
<a href="#n15" name="n15">15</a>
<a href="#n16" name="n16">16</a>
<a href="#n17" name="n17">17</a>
<a href="#n18" name="n18">18</a>
<a href="#n19" name="n19">19</a>
<strong><a href="#n20" name="n20">20</a></strong>
<a href="#n21" name="n21">21</a>
<a href="#n22" name="n22">22</a>
<a href="#n23" name="n23">23</a>
<a href="#n24" name="n24">24</a>
<a href="#n25" name="n25">25</a>
<a href="#n26" name="n26">26</a>
</pre></td>
  <td class="code"><pre><span class="keyword">function</span> Ball:<span class="function">init</span>(...)
    ...
    self.just_hit_paddle = <span class="predefined-constant">false</span>
    ...
<span class="keyword">end</span>

<span class="keyword">function</span> Ball:<span class="function">update</span>(dt)
    ...
    <span class="keyword">if</span> <span class="keyword">not</span> self.just_hit_paddle <span class="keyword">then</span>
        <span class="keyword">if</span> (self.x - self.r/<span class="integer">2</span> &lt;= paddle1.x + paddle1.w/<span class="integer">2</span>) <span class="keyword">and</span> 
           (self.y &gt;= paddle1.y - paddle1.h/<span class="integer">2</span>) <span class="keyword">and</span> 
           (self.y &lt;= paddle1.y + paddle1.h/<span class="integer">2</span>) <span class="keyword">then</span>
            ...
            self.just_hit_paddle = <span class="predefined-constant">true</span>
            mg.timer:after(<span class="float">0.2</span>, <span class="keyword">function</span>() self.just_hit_paddle = <span class="predefined-constant">false</span> <span class="keyword">end</span>)
        <span class="keyword">end</span>
        <span class="keyword">if</span> (self.x + self.r/<span class="integer">2</span> &gt;= paddle2.x - paddle2.w/<span class="integer">2</span>) <span class="keyword">and</span> 
           (self.y &gt;= paddle2.y - paddle2.h/<span class="integer">2</span>) <span class="keyword">and</span> 
           (self.y &lt;= paddle2.y + paddle2.h/<span class="integer">2</span>) <span class="keyword">then</span>
            ...
            self.just_hit_paddle = <span class="predefined-constant">true</span>
            mg.timer:after(<span class="float">0.2</span>, <span class="keyword">function</span>() self.just_hit_paddle = <span class="predefined-constant">false</span> <span class="keyword">end</span>)
        <span class="keyword">end</span>
    <span class="keyword">end</span>
    ...
<span class="keyword">end</span>
</pre></td>
</tr></table>
</div>

        </div>
        </dd>
        </dl>
    </li>
</ol>
</div>
</dd>
</dl>
<br>

<h3 id="game_loop" data-magellan-destination="game_loop">Game Loop</h3>

Now what the want to do is make it so that every time the ball reaches one of the sides of the screen, it is removed from the game and new ball is spawned.
A way of doing this is signaling that the current ball is dead and then when that happens spawn a new one. To do this though, we need some place to hold multiple balls
(doing this we additionally gain the ability to spawn multiple balls on the screen whenever we want):

~~~ lua
function love.load()
    ...
    balls = {}
    table.insert(balls, Ball(400, 300))
    ...
end

function love.update(dt)
    ...
    for i = #balls, 1, -1 do
        balls[i]:update(dt)
        if balls[i].dead then table.remove(balls, i) end
    end
end
~~~

In the update function here we're traversing the balls list, updating each ball and removing the balls that have the attribute <code class="atrm">.dead</code> set to true.
We'll only set that attribute to true when a ball reaches one of the edges of the screen, like so:

~~~ lua
function Ball:update(dt)
    ...
    if self.x < 0 + self.r/2 then
        self.dead = true
    end
    if self.x > 800 - self.r/2 then
        self.dead = true
    end
    ...
    if self.dead then
        table.insert(balls, Ball(400, 300))
    end
end
~~~

On top of setting the <code class="atrm">.dead</code> attribute to true, we then add a new ball to the center of the screen when it dies, so that the game continues. Even though the update
function is run each frame, the condition inside the <code class="text">if self.dead</code> check will only be run once, because this ball will be removed from the balls list and not updated
anymore after it's been set to die.

<dl class="accordion" data-accordion>
<dd>
<a href="#panel4">Exercises</a>
<div id="panel4" class="content">
<ol>
    <li> Create a scoring system for the game. Create a level variable that keeps track of the current level. Later when we add AI this variable will control how hard the AI will be.
    Every time the left player scores, add one to the level, every time the right player scores, subtract one.
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel6">Answer</a>
        <div id="panel6" class="content answer">
        Create a level variable. Increase it if the ball has died on right side of the screen (left player point), decrease otherwise (right player point):<br><br>
<div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
<a href="#n2" name="n2">2</a>
<a href="#n3" name="n3">3</a>
<a href="#n4" name="n4">4</a>
<a href="#n5" name="n5">5</a>
<a href="#n6" name="n6">6</a>
<a href="#n7" name="n7">7</a>
<a href="#n8" name="n8">8</a>
<a href="#n9" name="n9">9</a>
<strong><a href="#n10" name="n10">10</a></strong>
<a href="#n11" name="n11">11</a>
<a href="#n12" name="n12">12</a>
<a href="#n13" name="n13">13</a>
<a href="#n14" name="n14">14</a>
<a href="#n15" name="n15">15</a>
<a href="#n16" name="n16">16</a>
</pre></td>
  <td class="code"><pre><span class="comment">-- in main.lua</span>
<span class="keyword">function</span> love.<span class="function">load</span>()
    ...
    level = <span class="integer">1</span>
    ...
<span class="keyword">end</span>

<span class="comment">-- in Ball.lua</span>
<span class="keyword">function</span> Ball:<span class="function">update</span>(dt)
    ...
    <span class="keyword">if</span> self.dead <span class="keyword">then</span>
        <span class="keyword">if</span> self.x &gt; <span class="integer">400</span> <span class="keyword">then</span> level = level + <span class="integer">1</span> <span class="keyword">end</span>
        <span class="keyword">if</span> self.x &lt; <span class="integer">400</span> <span class="keyword">then</span> level = level - <span class="integer">1</span> <span class="keyword">end</span>
        table.insert(balls, Ball(<span class="integer">400</span>, <span class="integer">300</span>))
    <span class="keyword">end</span>
<span class="keyword">end</span>
</pre></td>
</tr></table>
</div>

        </div>
        </dd>
        </dl>
    </li>
    <br>

    <li> How would you make it so that every new ball is spawned at a random angle?
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel7">Answer</a>
        <div id="panel7" class="content answer">
        Specify the new ball's angle. In this case, use the mg.utils.math.random function to pick an angle between 0 and 360 degrees. Another possible way is doing it directly
        on the ball's constructor, self.angle = mg.utils.math.random(0, 2*math.pi).<br><br>
<div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
<a href="#n2" name="n2">2</a>
<a href="#n3" name="n3">3</a>
<a href="#n4" name="n4">4</a>
<a href="#n5" name="n5">5</a>
<a href="#n6" name="n6">6</a>
<a href="#n7" name="n7">7</a>
</pre></td>
  <td class="code"><pre><span class="keyword">function</span> Ball:<span class="function">update</span>(dt)
    ...
    <span class="keyword">if</span> self.dead <span class="keyword">then</span>
        ...
        table.insert(balls, Ball(<span class="integer">400</span>, <span class="integer">300</span>, <span class="map"><span class="delimiter">
                    {</span><span class="key">angle</span> = mg.utils.math.random(<span class="integer">0</span>, <span class="integer">2</span>*math.pi)<span class="delimiter">}</span></span>))
    <span class="keyword">end</span>
<span class="keyword">end</span>
</pre></td>
</tr></table>
</div>

        </div>
        </dd>
        </dl>
    </li>
</ol>
</div>
</dd>
</dl>
<br>

<h3 id="curve" data-magellan-destination="curve">Curve</h3>

Next we're gonna add the ability for paddles to add some curve to the ball based on how fast the player moves it. Hitting the ball while moving the paddle up really fast should 
add some spinning down, while hitting it while moving the paddle down should add some spinning up. Before we can actually do that addition though, we need to figure out how fast the paddle is moving:

~~~ lua
function Paddle:init(...)
    ...
    self.last_y = 0
end

function Paddle:update(dt)
    self.last_y = self.y
    ...
    self.v = self.last_y - self.y
    ...
end
~~~

What these two lines do is simply take the current position of the paddle and subtract with its last position. The faster the player is moving the mouse, the higher this difference will be.
We can now use that velocity as a base for how much spinning we're gonna add to the ball. The way spinning will be added is by changing the ball's angle slightly:

~~~ lua
function Ball:init(...)
    ...
    self.angle_speed = 0
end

function Ball:update(dt)
    ...
    self.angle = self.angle + self.angle_speed*dt
    ...
    if (self.x - self.r/2 <= paddle1.x + paddle1.w/2) and 
       (self.y >= paddle1.y - paddle1.h/2) and (self.y <= paddle1.y + paddle1.h/2) then
        self.angle = math.pi - self.angle
        self.angle_speed = paddle1.v/96
    end
end
~~~

Whenever the ball hits the paddle its angle speed gets changed to <code class="text">paddle.v/96</code>. This value was reached by trial and error until it felt nice, you may find
your own angle speed calculations that involve the paddle's velocity somehow. You can go as complex as you want with mathematical functions here, with the end goal of it feeling nice
to play.

<dl class="accordion" data-accordion>
<dd>
<a href="#panel8">Exercises</a>
<div id="panel8" class="content">
<ol>
    <li> Make it so that the other paddle can curve the ball as well.
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel9">Answer</a>
        <div id="panel9" class="content answer"><br>
 <div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
<a href="#n2" name="n2">2</a>
<a href="#n3" name="n3">3</a>
<a href="#n4" name="n4">4</a>
<a href="#n5" name="n5">5</a>
<a href="#n6" name="n6">6</a>
</pre></td>
  <td class="code"><pre><span class="keyword">if</span> (self.x + self.r/<span class="integer">2</span> &gt;= paddle2.x - paddle2.w/<span class="integer">2</span>) <span class="keyword">and</span> 
   (self.y &gt;= paddle2.y - paddle2.h/<span class="integer">2</span>) <span class="keyword">and</span> (self.y &lt;= paddle2.y + paddle2.h/<span class="integer">2</span>) <span class="keyword">then</span>
    ...
    self.angle_speed = paddle2.v/<span class="integer">96</span>
    ...
<span class="keyword">end</span>
</pre></td>
</tr></table>
</div>

        </div>
        </dd>
        </dl>
    </li>
    <br>

    <li> What happens when the value dividing <code class="text">paddle.v</code> increases? And when it decreases?
    What is a decent interval for the angle speed value such that it doesn't spin too fast nor too slow?
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel10">Answer</a>
        <div id="panel10" class="content answer">
            When the value dividing paddle.v increases, the angle speed value decreases, meaning that the added spin from the paddle has a lower effect on the ball's trajectory.
            When the value decreases, the angle speed increases, meaning that the added spin has a higher effect. A decent interval is a number that ranges from -2 to 2. 
            Translating this to degrees, it's about 120 degrees per second to whichever side. You could make any function based on the paddle's velocity (like paddle.v*paddle.v, or
            sin(paddle.v), or sqrt(paddle.v) + log(paddle.v/2), ... feel free to get creative!), but you'd have to scale this function back to this range if you want it to behave
            in an acceptable manner. This range was discovered by trial and error, so your findings on what the range should be may vary depending on what type of gameplay you're looking for.
        </div>
        </dd>
        </dl>
    </li>
</ol>
</div>
</dd>
</dl>
<br>

<h3 id="ai" data-magellan-destination="ai">AI</h3>

And now for the last thing to make before we have completely functional Pong game, the AI. We're gonna do something very simple for the AI: make it follow the ball's y position. At first doing this 
is ezpz:

~~~ lua
-- in Paddle.lua
function Paddle:init(...)
    ...
    self.ai = settings.ai
    ...
end

function Paddle:update(dt)
    ...
    if self.ai then
        self.y = balls[1].y
    else
        local mx, my = love.mouse.getPosition()
        self.y = my
    end
    ...
end

-- in main.lua
function love.load()
    ...
    paddle1 = Paddle(50, 300)
    paddle2 = Paddle(750, 300)
end
~~~

But if you play this, the AI is pretty much invincible. We need to add some way for it to not follow the ball so closely all the time. To do that we're gonna add some maximum velocity to the
AI controlled paddle:

~~~ lua
function Paddle:init(...)
    ...
    self.v = 0
    self.max_v = 400
    ...
end

function Paddle:update(dt)
    ...
    if self.ai then
        local dy = self.y - balls[1].y
        if dy < 0 then
            self.y = self.y - math.max(dy, -self.max_v)*dt
        else
            self.y = self.y - math.min(dy, self.max_v)*dt
        end
    else
        local mx, my = love.mouse.getPosition()
        self.y = my
    end
    ...
end
~~~

Here we check the difference between the paddle's current y position and ball's y position. Then based on this difference we add a certain velocity (which is this difference, but could
be some other value calculated using this difference as a parameter) to the paddle's y position, but always limitting it by the paddle's maximum velocity. In this way, we get a nice
smooth motion towards the ball that is as slow/fast as we want it to be (but not higher than <code class="text">max_v</code>), based on the velocity calculated.

<dl class="accordion" data-accordion>
<dd>
<a href="#panel11">Exercises</a>
<div id="panel11" class="content">
<ol>
    <li> How would you make it so that the AI's difficulty scales with the current level? (<strong>hint</strong>: change its max velocity as well as the rate at which its velocity is changed
    to catch up with the ball's position)
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel12">Answer</a>
        <div id="panel12" class="content answer">
            Initially bind the paddle's max velocity to the level according to some formula. Then do the same for the dy variable. Optionally, make it so that with each ball hit on either paddle,
            the ball's velocity is increased based on the current level, making each round harder the longer it goes on for.<br><br>
<div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
<a href="#n2" name="n2">2</a>
<a href="#n3" name="n3">3</a>
<a href="#n4" name="n4">4</a>
<a href="#n5" name="n5">5</a>
<a href="#n6" name="n6">6</a>
<a href="#n7" name="n7">7</a>
<a href="#n8" name="n8">8</a>
<a href="#n9" name="n9">9</a>
<strong><a href="#n10" name="n10">10</a></strong>
<a href="#n11" name="n11">11</a>
<a href="#n12" name="n12">12</a>
<a href="#n13" name="n13">13</a>
<a href="#n14" name="n14">14</a>
<a href="#n15" name="n15">15</a>
<a href="#n16" name="n16">16</a>
<a href="#n17" name="n17">17</a>
<a href="#n18" name="n18">18</a>
<a href="#n19" name="n19">19</a>
<strong><a href="#n20" name="n20">20</a></strong>
<a href="#n21" name="n21">21</a>
<a href="#n22" name="n22">22</a>
<a href="#n23" name="n23">23</a>
<a href="#n24" name="n24">24</a>
<a href="#n25" name="n25">25</a>
<a href="#n26" name="n26">26</a>
</pre></td>
  <td class="code"><pre><span class="comment">-- in Paddle.lua</span>
<span class="keyword">function</span> Paddle:<span class="function">update</span>(dt)
    ...
    self.max = <span class="integer">175</span>*level
    ...
    <span class="keyword">if</span> self.ai <span class="keyword">then</span>
        <span class="keyword">local</span> <span class="local-variable">dy</span> = self.y - balls[<span class="integer">1</span>].y
        <span class="keyword">if</span> dy &lt; <span class="integer">0</span> <span class="keyword">then</span>
            self.y = self.y - math.max((level+<span class="float">1.2</span>)*dy, -self.max_v)*dt
        <span class="keyword">else</span>
            self.y = self.y - math.min((level*<span class="float">1.2</span>)*dy, self.max_v)*dt
        <span class="keyword">end</span>
    ...
<span class="keyword">end</span>

<span class="comment">-- in Ball.lua</span>
<span class="keyword">function</span> Ball:<span class="function">update</span>(dt)
    ...
    <span class="keyword">if</span> (self.x - self.r/<span class="integer">2</span> &lt;= paddle1.x + paddle1.w/<span class="integer">2</span>) <span class="keyword">and</span> 
       (self.y &gt;= paddle1.y - paddle1.h/<span class="integer">2</span>) <span class="keyword">and</span> (self.y &lt;= paddle1.y + paddle1.h/<span class="integer">2</span>) <span class="keyword">then</span>
        ...
        self.v.x = (<span class="float">1.07</span> + <span class="float">0.01</span>*level)*self.v.x 
        ...
    <span class="keyword">end</span>
    ...
<span class="keyword">end</span>
</pre></td>
</tr></table>
</div>

        </div>
        </dd>
        </dl>
    </li>
    <br>

    <li> Make the AI paddle behave in a more human-like manner by adding some randomicity to it. Whenever the ball is going towards the player and not back to the AI paddle, make it so that it
    moves about randomly following whatever pattern you think a normal human would when he's waiting for the ball to come back to his side.
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel13">Answer</a>
        <div id="panel13" class="content answer">
            Whenever the ball is moving away from the AI paddle, move it towards a variable named .idle_position. Add a timer that picks a new idle position around the y center of the game
            every few seconds. This will make it so that the AI paddle moves randomly around the center of the screen whenever it's waiting for the ball to bounce back, and then when it does
            bounce back it changes to the normal following behavior.<br><br>
<div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
<a href="#n2" name="n2">2</a>
<a href="#n3" name="n3">3</a>
<a href="#n4" name="n4">4</a>
<a href="#n5" name="n5">5</a>
<a href="#n6" name="n6">6</a>
<a href="#n7" name="n7">7</a>
<a href="#n8" name="n8">8</a>
<a href="#n9" name="n9">9</a>
<strong><a href="#n10" name="n10">10</a></strong>
<a href="#n11" name="n11">11</a>
<a href="#n12" name="n12">12</a>
<a href="#n13" name="n13">13</a>
<a href="#n14" name="n14">14</a>
<a href="#n15" name="n15">15</a>
<a href="#n16" name="n16">16</a>
<a href="#n17" name="n17">17</a>
<a href="#n18" name="n18">18</a>
<a href="#n19" name="n19">19</a>
<strong><a href="#n20" name="n20">20</a></strong>
<a href="#n21" name="n21">21</a>
<a href="#n22" name="n22">22</a>
<a href="#n23" name="n23">23</a>
<a href="#n24" name="n24">24</a>
<a href="#n25" name="n25">25</a>
<a href="#n26" name="n26">26</a>
<a href="#n27" name="n27">27</a>
<a href="#n28" name="n28">28</a>
<a href="#n29" name="n29">29</a>
<strong><a href="#n30" name="n30">30</a></strong>
<a href="#n31" name="n31">31</a>
<a href="#n32" name="n32">32</a>
<a href="#n33" name="n33">33</a>
<a href="#n34" name="n34">34</a>
<a href="#n35" name="n35">35</a>
<a href="#n36" name="n36">36</a>
<a href="#n37" name="n37">37</a>
<a href="#n38" name="n38">38</a>
<a href="#n39" name="n39">39</a>
<strong><a href="#n40" name="n40">40</a></strong>
<a href="#n41" name="n41">41</a>
<a href="#n42" name="n42">42</a>
<a href="#n43" name="n43">43</a>
</pre></td>
  <td class="code"><pre><span class="comment">-- in Paddle.lua</span>
<span class="keyword">function</span> Paddle:<span class="function">init</span>(...)
    ...
    self.idle_p = <span class="integer">0</span>
    mg.timer:every(<span class="map"><span class="delimiter">{</span><span class="float">0.3</span>, <span class="float">0.6</span><span class="delimiter">}</span></span>, <span class="keyword">function</span>()
        self.idle_p = <span class="integer">300</span> + math.random(<span class="integer">-150</span>, <span class="integer">150</span>)
    <span class="keyword">end</span>)
    ...
<span class="keyword">end</span>

<span class="keyword">function</span> Paddle:<span class="function">update</span>(dt)
    ...
    <span class="keyword">if</span> self.ai <span class="keyword">then</span>
        <span class="keyword">local</span> <span class="local-variable">dy</span> = self.y - balls[<span class="integer">1</span>].y
        <span class="keyword">if</span> self.idle <span class="keyword">then</span> dy = self.y - self.idle_p <span class="keyword">end</span>
        <span class="keyword">if</span> dy &lt; <span class="integer">0</span> <span class="keyword">then</span>
        ...
    ...
<span class="keyword">end</span>

<span class="comment">-- in Ball.lua</span>
<span class="keyword">function</span> Ball:<span class="function">update</span>(dt)
    ...
    <span class="keyword">if</span> (self.x - self.r/<span class="integer">2</span> &lt;= paddle1.x + paddle1.w/<span class="integer">2</span>) <span class="keyword">and</span> 
       (self.y &gt;= paddle1.y - paddle1.h/<span class="integer">2</span>) <span class="keyword">and</span> (self.y &lt;= paddle1.y + paddle1.h/<span class="integer">2</span>) <span class="keyword">then</span>
        ...
        paddle2.idle = <span class="predefined-constant">false</span>
        ...
    <span class="keyword">end</span>
    <span class="keyword">if</span> (self.x + self.r/<span class="integer">2</span> &gt;= paddle2.x - paddle2.w/<span class="integer">2</span>) <span class="keyword">and</span> 
       (self.y &gt;= paddle2.y - paddle2.h/<span class="integer">2</span>) <span class="keyword">and</span> (self.y &lt;= paddle2.y + paddle2.h/<span class="integer">2</span>) <span class="keyword">then</span>
        ...
        paddle2.idle = <span class="predefined-constant">true</span>
        ...
    <span class="keyword">end</span>
    ...
    <span class="keyword">if</span> self.dead <span class="keyword">then</span>
        <span class="keyword">if</span> self.x &gt; <span class="integer">400</span> <span class="keyword">then</span> level = level + <span class="integer">1</span> <span class="keyword">end</span>
        <span class="keyword">if</span> self.x &lt; <span class="integer">400</span> <span class="keyword">then</span> level = level - <span class="integer">1</span> <span class="keyword">end</span>
        paddle2.idle = <span class="predefined-constant">false</span>
        table.insert(balls, Ball(<span class="integer">400</span>, <span class="integer">300</span>))
    <span class="keyword">end</span>
<span class="keyword">end</span>
</pre></td>
</tr></table>
</div>

        </div>
        </dd>
        </dl>
    </li>
</ol>
</div>
</dd>
</dl>
<br>

<h3 id="polish" data-magellan-destination="polish">Polish</h3>

You should have a completely functional Pong game by now. But it's kinda boring to look at... It certainly doesn't look as interesting as the gif up there. How to make it 
better? Well, we can do a LOT of things to make it better. Some of them are described in this video: 

{% youtube Fy0aCDmgnxg %}
<br>

while a lot of them aren't. But the fact is is that making a game feel nice to play and look at is highly about experimentation, trial and error. I'll outline some of the things you can do,
but you're the one who should go a step further and do even more!

<h5>Ball Rotation</h5>

The first thing we can add is ball rotation. Since the ball actually curves, it makes sense that it would spin around itself too. To do this, we code the following:

~~~ lua
function Ball:init(...)
    ...
    self.rotation = 0
    self.rotation_speed = math.pi
    ...
end

function Ball:update(dt)
    ...
    self.rotation = self.rotation + self.rotation_speed*dt
    ...
    if (self.x - self.r/2 <= paddle1.x + paddle1.w/2) and 
       (self.y >= paddle1.y - paddle1.h/2) and (self.y <= paddle1.y + paddle1.h/2) then
        ...
        self.rotation_speed = paddle1.v/4
        ...
    end
    ...
end
~~~

Every frame we add to the ball's rotation its rotation speed, and when the ball hits a paddle we make sure to take into account that paddle's velocity as well. To draw the rotated
rectangle:

~~~ lua
function Ball:draw()
    mg.utils.graphics.pushRotate(self.x, self.y, self.rotation)
    love.graphics.rectangle('fill', self.x - self.r/2, self.y - self.r/2, self.r, self.r)
    love.graphics.pop()
end
~~~

The <code class="atrm">mg.utils.graphics.pushRotate</code> call rotates whatever is drawn between it and <code class="atrm">love.graphics.pop()</code> by 
<code class="text">self.rotation</code> angles around point <code class="text">self.x, self.y</code>.

<dl class="accordion" data-accordion>
<dd>
<a href="#panel18">Exercises</a>
<div id="panel18" class="content">
<ol>
    <li> Make it so that the other paddle also adds rotation to the ball.
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel14">Answer</a>
        <div id="panel14" class="content answer"><br>
<div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
<a href="#n2" name="n2">2</a>
<a href="#n3" name="n3">3</a>
<a href="#n4" name="n4">4</a>
<a href="#n5" name="n5">5</a>
<a href="#n6" name="n6">6</a>
<a href="#n7" name="n7">7</a>
<a href="#n8" name="n8">8</a>
<a href="#n9" name="n9">9</a>
<strong><a href="#n10" name="n10">10</a></strong>
<a href="#n11" name="n11">11</a>
<a href="#n12" name="n12">12</a>
</pre></td>
  <td class="code"><pre><span class="keyword">function</span> Ball:<span class="function">update</span>(dt)
    ...
    self.rotation = self.rotation + self.rotation_speed*dt
    ...
    <span class="keyword">if</span> (self.x + self.r/<span class="integer">2</span> &gt;= paddle2.x - paddle1.w/<span class="integer">2</span>) <span class="keyword">and</span> 
       (self.y &gt;= paddle2.y - paddle2.h/<span class="integer">2</span>) <span class="keyword">and</span> (self.y &lt;= paddle2.y + paddle2.h/<span class="integer">2</span>) <span class="keyword">then</span>
        ...
        self.rotation_speed = paddle2.v/<span class="integer">4</span>
        ...
    <span class="keyword">end</span>
    ...
<span class="keyword">end</span>
</pre></td>
</tr></table>
</div>

        </div>
        </dd>
        </dl>
    </li>
    <br>

    <li> Make the ball's rotation be cut in half whenever it hits the top or bottom edge of the screen.
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel15">Answer</a>
        <div id="panel15" class="content answer"><br>
<div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
<a href="#n2" name="n2">2</a>
<a href="#n3" name="n3">3</a>
<a href="#n4" name="n4">4</a>
<a href="#n5" name="n5">5</a>
<a href="#n6" name="n6">6</a>
<a href="#n7" name="n7">7</a>
<a href="#n8" name="n8">8</a>
<a href="#n9" name="n9">9</a>
<strong><a href="#n10" name="n10">10</a></strong>
<a href="#n11" name="n11">11</a>
<a href="#n12" name="n12">12</a>
</pre></td>
  <td class="code"><pre><span class="keyword">function</span> Ball:<span class="function">update</span>(dt)
    ...
    <span class="keyword">if</span> self.y &lt; <span class="integer">0</span> + self.r/<span class="integer">2</span> <span class="keyword">then</span>
        self.angle = -self.angle
        self.rotation_speed = self.rotation_speed/<span class="integer">2</span>
    <span class="keyword">end</span>
    <span class="keyword">if</span> self.y &gt; <span class="integer">600</span> - self.r/<span class="integer">2</span> <span class="keyword">then</span>
        self.angle = -self.angle
        self.rotation_speed = self.rotation_speed/<span class="integer">2</span>
    <span class="keyword">end</span>
    ...
<span class="keyword">end</span>
</pre></td>
</tr></table>
</div>

        </div>
        </dd>
        </dl>
    </li>
</ol>
</div>
</dd>
</dl>
<br>

<h5>Ball Trails</h5>

To make the ball look even better we can add trails. We'll do that by repeatedly spawning rectangles that quickly fade away at the ball's current position. 

~~~ lua
-- in BallTrail.lua
BallTrail = mg.Class('BallTrail')

function BallTrail:init(x, y, r, rotation)
    self.x = x
    self.y = y
    self.r = r + mg.utils.math.random(-4, 4)
    self.rotation = mg.utils.math.random(0, 2*math.pi)
    self.alpha = 0
    self.dead = false

    mg.timer:tween(0.02, self, {alpha = 255}, 'in-out-cubic')
    mg.timer:after(0.02, function()
        mg.timer:tween(0.4, self, {alpha = 0}, 'in-out-cubic')
        mg.timer:after(0.4, function() self.dead = true end)
    end)
end

function BallTrail:draw()
    love.graphics.setColor(255, 255, 255, self.alpha)
    mg.utils.graphics.pushRotate(self.x, self.y, self.rotation)
    love.graphics.rectangle('fill', self.x - self.r/2, self.y - self.r/2, self.r, self.r)
    love.graphics.pop()
    love.graphics.setColor(255, 255, 255, 255)
end
~~~

There are a few interesting things to notice here. One is the use of the [Timer](/documentation/timer) module. First we tween this trail's alpha to full color for <code class="number">0.02</code>
seconds; then after those <code class="number">0.02</code> seconds we tween that same alpha to <code class="number">0</code> over <code class="number">0.4</code> seconds, giving the trail effect
if we're spawning multiple of those near each other. After that same amount of time we also set the entity to die, doing the same as we did for the balls' death: removing dead entities
from the list that holds them.

~~~ lua
function love.load()
    ...
    ball_trails = {}
    ...
end

function love.update(dt)
    ...
    for i = #ball_trails, 1, -1 do
        ball_trails[i]:update(dt)
        if ball_trails[i].dead then table.remove(ball_trails, i) end
    end
    ...
end

function love.draw()
    ...
    for _, ball_trail in ipairs(ball_trails) do ball_trail:draw() end
    ...
end
~~~

After doing this we can finally actually spawn the trails:

~~~ lua
function Ball:init(...)
    ...
    mg.timer:every({0.02, 0.04}, function()
        table.insert(ball_trails, BallTrail(self.x, self.y, self.r, self.rotation))
    end)
end
~~~

This create a new timer that will spawn a trail every <code class="number">0.02-0.04</code> seconds, or nearly every <code class="number">2-4</code> frames. Playing around with this number
will give you different trail effects. Playing around with how long a ball trail object takes to fade away will also make the trail look different. Scaling the trail down as it fades away
makes it look even more different... All this means is that there are tons of ways of getting different trail effects, and that the one outlined here is only a very particular one.

<dl class="accordion" data-accordion>
<dd>
<a href="#panel20">Exercises</a>
<div id="panel20" class="content">
<ol>
    <li> Add trails to the paddles as well.
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel21">Answer</a>
        <div id="panel21" class="content answer">
            Paddle trails are extremely similar to the ball trails, since we're using pretty much the same fading functionality. The difference being a rectangle and that you
            may wanna change the tween times so it doesn't look as confusing:<br><br>
<div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
<a href="#n2" name="n2">2</a>
<a href="#n3" name="n3">3</a>
<a href="#n4" name="n4">4</a>
<a href="#n5" name="n5">5</a>
<a href="#n6" name="n6">6</a>
<a href="#n7" name="n7">7</a>
<a href="#n8" name="n8">8</a>
<a href="#n9" name="n9">9</a>
<strong><a href="#n10" name="n10">10</a></strong>
<a href="#n11" name="n11">11</a>
<a href="#n12" name="n12">12</a>
<a href="#n13" name="n13">13</a>
<a href="#n14" name="n14">14</a>
<a href="#n15" name="n15">15</a>
<a href="#n16" name="n16">16</a>
<a href="#n17" name="n17">17</a>
<a href="#n18" name="n18">18</a>
<a href="#n19" name="n19">19</a>
<strong><a href="#n20" name="n20">20</a></strong>
<a href="#n21" name="n21">21</a>
<a href="#n22" name="n22">22</a>
<a href="#n23" name="n23">23</a>
<a href="#n24" name="n24">24</a>
<a href="#n25" name="n25">25</a>
<a href="#n26" name="n26">26</a>
</pre></td>
  <td class="code"><pre>PaddleTrail = mg.Class(<span class="string"><span class="delimiter">'</span><span class="string">PaddleTrail</span><span class="delimiter">'</span></span>)

<span class="keyword">function</span> PaddleTrail:<span class="function">init</span>(x, y, w, h)
    self.x = x
    self.y = y
    self.w = w + mg.utils.math.random(<span class="integer">-2</span>, <span class="integer">2</span>)
    self.h = h + mg.utils.math.random(<span class="integer">-2</span>, <span class="integer">2</span>)
    self.alpha = <span class="integer">0</span>
    self.dead = <span class="predefined-constant">false</span>

    mg.timer:tween(<span class="float">0.02</span>, self, <span class="map"><span class="delimiter">{</span><span class="key">alpha</span> = <span class="integer">255</span><span class="delimiter">}</span></span>, <span class="string"><span class="delimiter">'</span><span class="string">in-out-cubic</span><span class="delimiter">'</span></span>)
    mg.timer:after(<span class="float">0.02</span>, <span class="keyword">function</span>()
        mg.timer:tween(<span class="float">0.2</span>, self, <span class="map"><span class="delimiter">{</span><span class="key">alpha</span> = <span class="integer">0</span><span class="delimiter">}</span></span>, <span class="string"><span class="delimiter">'</span><span class="string">in-out-cubic</span><span class="delimiter">'</span></span>)
        mg.timer:after(<span class="float">0.2</span>, <span class="keyword">function</span>() self.dead = <span class="predefined-constant">true</span> <span class="keyword">end</span>)
    <span class="keyword">end</span>)
<span class="keyword">end</span>

<span class="keyword">function</span> PaddleTrail:<span class="function">update</span>(dt)

<span class="keyword">end</span>

<span class="keyword">function</span> PaddleTrail:<span class="function">draw</span>()
    love.graphics.setColor(<span class="integer">255</span>, <span class="integer">255</span>, <span class="integer">255</span>, self.alpha)
    love.graphics.rectangle(<span class="string"><span class="delimiter">'</span><span class="string">fill</span><span class="delimiter">'</span></span>, self.x - self.w/<span class="integer">2</span>, self.y - self.h/<span class="integer">2</span>, self.w, self.h)
    love.graphics.setColor(<span class="integer">255</span>, <span class="integer">255</span>, <span class="integer">255</span>, <span class="integer">255</span>)
<span class="keyword">end</span>
</pre></td>
</tr></table>
</div>

        </div>
        </dd>
        </dl>
    </li>
    <br>

    <li> Make it so that the trail spawning interval for the ball is tied to its angle speed. (<strong>hint</strong>: drop the use of timers and calculate the time needed on your own on the update
    function, since you can't get variable times using the Timer module)
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel22">Answer</a>
        <div id="panel22" class="content answer">
            Here we calculate the time needed based on some formula (you may come up with anojther) that uses the angle speed as a parameter. The adding of dt and then zeroing the trail_t variable
            is the basic timing construct that the Timer module also does internally for its calculations. The point here is that the Timer module is not as flexible to accept arbitrary intervals
            that change based on whatever, so you have to do it yourself:<br><br>
<div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
<a href="#n2" name="n2">2</a>
<a href="#n3" name="n3">3</a>
<a href="#n4" name="n4">4</a>
<a href="#n5" name="n5">5</a>
<a href="#n6" name="n6">6</a>
<a href="#n7" name="n7">7</a>
<a href="#n8" name="n8">8</a>
<a href="#n9" name="n9">9</a>
<strong><a href="#n10" name="n10">10</a></strong>
<a href="#n11" name="n11">11</a>
<a href="#n12" name="n12">12</a>
<a href="#n13" name="n13">13</a>
<a href="#n14" name="n14">14</a>
<a href="#n15" name="n15">15</a>
</pre></td>
  <td class="code"><pre><span class="keyword">function</span> Ball:<span class="function">init</span>(...)
    ...
    self.trail_t = <span class="integer">0</span>
    ...
<span class="keyword">end</span>

<span class="keyword">function</span> Ball:<span class="function">update</span>(dt)
    ...
    self.trail_t = self.trail_t + dt
    <span class="keyword">if</span> self.trail_t &gt; (<span class="float">0.03</span> - math.abs(<span class="float">0.0125</span>*self.angle_speed)) <span class="keyword">then</span>
        self.trail_t = <span class="integer">0</span>
        table.insert(ball_trails, BallTrail(self.x, self.y, self.r, self.rotation))
    <span class="keyword">end</span>
    ...
<span class="keyword">end</span>
</pre></td>
</tr></table>
</div>


        </div>
        </dd>
        </dl>
    </li>
</ol>
</div>
</dd>
</dl>
<br>

<h5>Ball Size</h5>

Another thing we can do is change the ball's size based on its velocity, as well as add some pulsing to its size so that it looks a bit more alive. The first one:

~~~ lua
function Paddle:update(dt)
    ...
    if (self.x - self.r/2 <= paddle1.x + paddle1.w/2) and 
       (self.y >= paddle1.y - paddle1.h/2) and (self.y <= paddle1.y + paddle1.h/2) then
        mg.timer:cancel('r_speed_add')
        mg.timer:tween('r_speed_add', 1.5, self, {r = 30 - math.abs(12.5*self.angle_speed)}, 
                       'in-out-cubic')
    end
    ...
end
~~~

What this does is create a tween that acts on the ball's radius through a formula that uses the angle speed as a parameter. This formula says that the higher the angle speed, the smaller
the radius. This makes it so that when the ball is turning a lot it looks smaller (and its trail looks smaller too since each trail is created using the current radius).

The second thing we can do, making the ball pulsate:

~~~ lua
function Ball:init(...)
    ...
    self.r_pulse = 0
    mg.timer:every({0.02, 0.04}, function()
        mg.timer:tween(0.02, self, {r_pulse = mg.utils.math.random(-2, 2)}, 'in-elastic')
    end)
end

function Ball:draw()
    mg.utils.graphics.pushRotate(self.x, self.y, self.rotation)
    local r = self.r + self.r_pulse
    love.graphics.rectangle('fill', self.x - r/2, self.y - r/2, r, r)
    love.graphics.pop()
end
~~~

Here we create a timer that tweens an additional radius to be added to the original radius between <code class="number">-2</code> and <code class="number">2</code>. Doing this every
<code class="number">0.02-0.04</code> seconds, it gives a nice twitchy/pulsating effect to the ball. You could also make the intensity of this twitching be higher if the ball's velocity
is fast... Or make it higher/lower when it touches a border or a paddle. The possibilities are endless!

<dl class="accordion" data-accordion>
<dd>
<a href="#panel24">Exercises</a>
<div id="panel24" class="content">
<ol>
    <li> Do the same for paddles and make them pulsate like the ball does.
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel25">Answer</a>
        <div id="panel25" class="content answer"><br>
<div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
<a href="#n2" name="n2">2</a>
<a href="#n3" name="n3">3</a>
<a href="#n4" name="n4">4</a>
<a href="#n5" name="n5">5</a>
<a href="#n6" name="n6">6</a>
<a href="#n7" name="n7">7</a>
<a href="#n8" name="n8">8</a>
<a href="#n9" name="n9">9</a>
<strong><a href="#n10" name="n10">10</a></strong>
<a href="#n11" name="n11">11</a>
<a href="#n12" name="n12">12</a>
<a href="#n13" name="n13">13</a>
<a href="#n14" name="n14">14</a>
<a href="#n15" name="n15">15</a>
</pre></td>
  <td class="code"><pre><span class="keyword">function</span> Paddle:<span class="function">init</span>(...)
    ...
    self.w_pulse = <span class="integer">0</span>
    self.h_pulse = <span class="integer">0</span>
    mg.timer:every(<span class="map"><span class="delimiter">{</span><span class="float">0.02</span>, <span class="float">0.04</span><span class="delimiter">}</span></span>, <span class="keyword">function</span>()
        mg.timer:tween(<span class="float">0.02</span>, self, <span class="map"><span class="delimiter">{</span><span class="key">w_pulse</span> = mg.utils.math.random(<span class="integer">-4</span>, <span class="integer">4</span>)<span class="delimiter">}</span></span>, <span class="string"><span class="delimiter">'</span><span class="string">in-elastic</span><span class="delimiter">'</span></span>)
        mg.timer:tween(<span class="float">0.02</span>, self, <span class="map"><span class="delimiter">{</span><span class="key">h_pulse</span> = mg.utils.math.random(<span class="integer">-4</span>, <span class="integer">4</span>)<span class="delimiter">}</span></span>, <span class="string"><span class="delimiter">'</span><span class="string">in-elastic</span><span class="delimiter">'</span></span>)
    <span class="keyword">end</span>)
    ...
<span class="keyword">end</span>

<span class="keyword">function</span> Paddle:<span class="function">draw</span>()
    <span class="keyword">local</span> <span class="local-variable">w</span>, <span class="local-variable">h</span> = self.w + self.w_pulse, self.h + self.h_pulse
    love.graphics.rectangle(<span class="string"><span class="delimiter">'</span><span class="string">fill</span><span class="delimiter">'</span></span>, self.x - w/<span class="integer">2</span>, self.y - h/<span class="integer">2</span>, w, h)
<span class="keyword">end</span>
</pre></td>
</tr></table>
</div>

        </div>
        </dd>
        </dl>
    </li>
</ol>
</div>
</dd>
</dl>
<br>

<h5>Challenges</h5>

There are things you can do to polish the game even more, but instead of just giving you the working code on how to do them, I'll pose them as challenges that you need to figure out
for yourself. As stated in the [How to do exercises](/exercises) page, building up the necessary skills so you can search and do things on your own is important for game development, and that
building up can only happen when you're actually doing things without too much hand-holding.

1. Adding particles effects is possible by using the [Particles](/documentation/particles) module. Set it up according to the description on that page, create a particle system using the editor
(make it point to one particular direction with a spread of ~90 degrees or so instead of projecting particles everywhere), and spawn this particle system whenever the ball hits the screen edges
or a paddle, using the <code class="atrm">mg.world:spawnParticles</code> call. You will probably need to set the <code class="text">rotation</code> attribute in each spawned system to match
the direction of what the ball hit.

2. Adding camera shake whenever the ball hits something can be done by using the [Camera](/documentation/camera) module. Create a new camera instance, set it to follow the center of the screen
so that when you shake it it doesn't keep going offscreen, set attach/detach around everything in the <code class="text">love.draw</code> function so that your shakes are applied to everything in the 
screen, and then use the <code class="text">:shake</code> call to make the screen shake.

3. Shader effects can be achieved by using [love.graphics.newShader](http://www.love2d.org/wiki/love.graphics.newShader). Mogamett comes with a few default shaders located in 
<code class="text">mogamett/resources/shaders</code>. Play around with them and see what kinds of effects you can create. The effect on the gif up there was achieved through the use
of 3 shaders.
<br><br>

<h3 id="the_end" data-magellan-destination="the_end">The End</h3>

And that's it! If you finished all exercises and challenges you should have something that looks pretty similar to this:

{% img center /assets/curvemaster.gif %}

Hopefully you did even more and your version of it looks a lot better! In any case, you should also have a pretty good idea on how to read Mogamett's documentation
and you should be able to start using it for your own games. Good luck!
<br><br>
