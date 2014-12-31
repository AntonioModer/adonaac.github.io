---
layout: page
title: CurveMaster 
subtitle:
comments: true 
sharing: false
footer: true
sidebar: false 
---

{% accopen [requirements] [Knowledge Requirements] %}
<ul class="require">
<li>Essential Programming Concepts (variables, conditionals, etc...) </li>
<li><a href="http://nova-fusion.com/2012/08/27/lua-for-programmers-part-1/">Lua</a></li>
<li>LÖVE</li>
<li>Essential Game Programming (Pong, Tetris, ...)</li>
<li>Object Oriented Programming</li>
</ul>
{% accclose %}

{% img center /assets/curvemaster.gif %}

This tutorial will teach you about some of the basic features of the framework 
through building an enhanced version of Pong. You should have fuccboiGDX 
[downloaded](/downloads/fuccboi.zip) and [set up](/tutorials#Getting_Started) 
properly.
<br><br>

{% title Screen Size %}

Before anything else what we're gonna do first is change the screen size so that it's bigger.
To do this we can start in the {% text Game.lua %} object's constructor and add the {% text fg.setScreenSize %} call:

~~~ lua
function Game:new()
    fg.setScreenSize(800, 600)
end
~~~

{% title Ball %}

After that is done we're gonna create the main ball. Since we're using the framework 
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
function Ball:new(x, y, settings)
    local settings = settings or {}
    self.x, self.y = x, y
    self.r = settings.r or 30
    self.v = settings.v or fg.Vector(400, 400)
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
{% text v = fg.Vector(400, 400) %} and {% text r = 30 %}. This construct is 
the same as the one used by {% text engine %} entities, and it's a pretty flexible 
and useful way of organizing object construction. 

Another thing to note here is that we're returning the Ball class and storing it in
a global variable of the same name. This is just a useful thing to note, since having
a class stored in a variable lets you change how classes behave dynamically (if you 
ever need that for whatever reason).

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
local Paddle = fg.Class('Paddle')

function Paddle:new(x, y, settings)
    local settings = settings or {}
    self.x, self.y = x, y
    self.w = settings.w or 30
    self.h = settings.h or 100
end

function Paddle:update(dt)
    self.y = love.mouse.getY()
end

function Paddle:draw()
    love.graphics.rectangle('fill', self.x - self.w/2, self.y - self.h/2, self.w, self.h)
end

return Paddle
~~~

This makes it so that the paddle follows the mouse position on the y axis. To create 
both paddles you can do:

~~~ lua
...
Paddle = require 'Paddle'

function Game:new()
    ...
    paddle1 = Paddle(30, 50)
    paddle2 = Paddle(fg.screen_width - 30, 50)
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

This should create two paddles, one on the left and another on the right of the screen, 
and they should both follow the mouse's y position.

{% capture exercises_paddle_answer_1 %}
~~~ lua
function Paddle:update(dt)
    ...
    if self.y < 0 + self.h/2 then
        self.y = 0 + self.h/2
    end
    if self.y > fg.screen_height - self.h/2 then
        self.y = fg.screen_height - self.h/2
    end
end
~~~
{% endcapture %}

{% accopen [exercises_paddle_1] [Exercises] %}
    1. Like the ball previously could, the paddles can go offscreen if you move the mouse close to its borders. Prevent this from happening!
    {% aaccopen [exercises_paddle_answer_1] [Answer] %}
        Check the paddle's y position against the screen's top and bottom borders and force that position in case it's past it, taking into account the paddle's height:<br><br>
        {{ exercises_paddle_answer_1 | markdownify }}
    {% accclose %}
{% accclose %}
<br>

{% title Ball-Paddle Collision %}

The ball doesn't collide with the paddles yet, but in a similar manner to how 
we did it for the borders of the screen we can do it for the paddles. Check 
the ball's position against the position of each paddle and change its angle accordingly:

~~~ lua
function Ball:update(dt)
    ...
    if (self.x - self.r/2 <= paddle1.x + paddle1.w/2) and 
       (self.y >= paddle1.y - paddle1.h/2) and (self.y <= paddle1.y + paddle1.h/2) then
        self.angle = math.pi - self.angle
    end
end
~~~

The check first sees if the ball's x position is to the left of the right edge of the left paddle (!), 
and then on top of that checks if the ball's y position is inside the left paddle's
top and bottom edges. If all of those conditions are met then the ball is bounced back.

{% capture exercises_paddle_answer_21 %}
~~~ lua
if (self.x + self.r/2 >= paddle2.x - paddle1.w/2) and
   (self.y >= paddle2.y - paddle2.h/2) and (self.y <= paddle2.y + paddle2.h/2) then
    self.angle = math.pi - self.angle
end
~~~
{% endcapture %}

{% capture exercises_paddle_answer_22 %}
~~~ lua
function Ball:new(...)
    ...
    self.just_hit_paddle = false
    ...
end

function Ball:update(dt)
    ...
    if not self.just_hit_paddle then
        if (self.x - self.r/2 <= paddle1.x + paddle1.w/2) and
           (self.y >= paddle1.y - paddle1.h/2) and 
           (self.y <= paddle1.y + paddle1.h/2) then
            self.angle = math.pi - self.angle
            self.just_hit_paddle = true
            fg.timer:after(0.2, function() self.just_hit_paddle = false end)
        end

        if (self.x + self.r/2 >= paddle2.x - paddle1.w/2) and
           (self.y >= paddle2.y - paddle2.h/2) and 
           (self.y <= paddle2.y + paddle2.h/2) then
            self.angle = math.pi - self.angle
            self.just_hit_paddle = true
            fg.timer:after(0.2, function() self.just_hit_paddle = false end)
        end
    end
end
~~~
{% endcapture %}

{% accopen [exercises_paddle_2] [Exercises] %}
    1. Perform that check for the right paddle as well.
    {% aaccopen [exercises_paddle_answer_21] [Answer] %}
        {{ exercises_paddle_answer_21 | markdownify }}
    {% accclose %}
    <br>

    2. Sometimes if the ball hits a paddle on one of its top or bottom edges it will behave strangely. The reason this happens is because it keeps changing angle repeatedly, 
    since sommetimes the collision check is satisfied multiple times in a short time frame. How would you go about fixing this? (<strong>hint</strong>: create a {% text .just_hit_paddle %}
    boolean and use the <a href="/documentation/timer">Timer</a> module)
    {% aaccopen [exercises_paddle_answer_22] [Answer] %}
        The way to solve this is by completely ignoring the collision checks if the ball has just hit a paddle. When a collision actually happens, set .just_hit_paddle to true and then after
        some time, in this case 0.2 seconds, set it to false again. This prevents collisions between ball and paddle to happening too close to each other:<br><br>
        {{ exercises_paddle_answer_22 | markdownify }}
    {% accclose %}
{% accclose %}
<br>

{% title Game Loop %}

Now what the want to do is make it so that every time the ball reaches one of the sides of the screen, it is removed from the game and new ball is spawned.
A way of doing this is signaling that the current ball is dead and then when that happens spawn a new one. To do this though, we need some place to hold multiple balls
(doing this we additionally gain the ability to spawn multiple balls on the screen whenever we want):

~~~ lua
function Game:new()
    ...
    balls = {}
    table.insert(balls, Ball(fg.screen_width/2, fg.screen_height/2, {angle = math.pi/4}))
end

function Game:update(dt)
    ...
    for i = #balls, 1, -1 do
        balls[i]:update(dt)
        if balls[i].dead then 
            table.remove(balls, i) 
        end
    end
end
~~~

In the update function here we're traversing the balls list, updating each ball and removing the balls that have the {% text .dead %} attribute set to true.
We'll only set that attribute to true when a ball reaches one of the edges of the screen, like so:

~~~ lua
function Ball:new(...)
    ...
    self.dead = false
    ...
end

function Ball:update(dt)
    ...
    if self.x < 0 + self.r/2 then
        self.angle = math.pi - self.angle
        self.dead = true
    end
    if self.x > fg.screen_width - self.r/2 then
        self.angle = math.pi - self.angle
        self.dead = true
    end
    ...
    if self.dead then
        table.insert(balls, Ball(fg.screen_width/2, fg.screen_height/2))
    end
end
~~~

On top of setting the {% text .dead %} attribute to true, we then add a new ball to the center of the screen when it dies, so that the game continues. 
Even though the update function is run each frame, the condition inside the {% text if self.dead %} check will only be run once, because this ball will 
be removed from the balls list and not updated anymore after it's been set to die.

{% capture exercises_game_loop_1 %}
~~~ lua
function Game:draw()
    ...
    for _, ball in ipairs(balls) do 
        ball:draw()
    end
end
~~~
{% endcapture %}

{% capture exercises_game_loop_2 %}
~~~ lua
-- in Game.lua
function Game:new()
    ...
    level = 1
    ...
end

-- in Ball.lua
function Ball:update(dt)
    ...
    if self.dead then
        if self.x > fg.screen_width/2 then 
            level = level + 1 
        end
        if self.x < fg.screen_width/2 then
            level = level - 1
        end
        table.insert(balls, Ball(fg.screen_width/2, fg.screen_height/2))
    end
end
~~~
{% endcapture %}

{% capture exercises_game_loop_3 %}
~~~ lua
function Ball:update(dt)
    ...
    if self.dead then
        ...
        table.insert(balls, Ball(fg.screen_width/2, fg.screen_height/2, 
                    {angle = fg.utils.math.random(0, 2*math.pi)}))
    end
end
~~~
{% endcapture %}

{% accopen [exercises_game_loop] [Exercises] %}
    1. Draw the ball after the previous changes.
    {% aaccopen [exercises_game_loop_1] [Answer] %}
        {{ exercises_game_loop_1 | markdownify }}
    {% accclose %}
    <br>

    2. Create a scoring system for the game by creating a level variable that keeps track of the current level. 
    Every time the left player scores, add one to the level, every time the right player scores, subtract one.
    Later when we add AI this variable will control how hard it will be.
    {% aaccopen [exercises_game_loop_2] [Answer] %}
        Create a level variable. Increase it if the ball has died on right side of the screen (left player point), decrease otherwise (right player point):<br><br>
        {{ exercises_game_loop_2 | markdownify }}
    {% accclose %}
    <br>

    3. How would you make it so that every new ball is spawned at a random angle?
    {% aaccopen [exercises_game_loop_3] [Answer] %}
        Specify the new ball's angle. In this case, use the fg.utils.math.random function to pick an angle between 0 and 360 degrees. Another possible way is doing it directly
        on the ball's constructor, self.angle = fg.utils.math.random(0, 2*math.pi).<br><br>
        {{ exercises_game_loop_3 | markdownify }}
    {% accclose %}
{% accclose %}
<br>

{% title Curve %}

Next we're gonna add the ability for paddles to add some curve to the ball based on how fast the player moves it. Hitting the ball while moving the paddle up really fast should 
add some spinning down, while hitting it while moving the paddle down should add some spinning up. Before we can actually do that addition though, we need to figure out how fast the paddle is moving:

~~~ lua
function Paddle:new(...)
    ...
    self.last_y = 0
end

function Paddle:update(dt)
    ...
    self.v = self.last_y - self.y
    ...
    self.last_y = self.y
end
~~~

What these two lines do is simply take the current position of the paddle and subtract with its last position. The faster the player is moving the mouse, the higher this difference will be.
We can now use that velocity as a base for how much spinning we're gonna add to the ball. The way spinning will be added is by changing the ball's angle slightly:

~~~ lua
function Ball:new(...)
    ...
    self.angle_speed = 0
end

function Ball:update(dt)
    ...
    self.angle = self.angle + self.angle_speed*dt
    ...
    if (self.x - self.r/2 <= paddle1.x + paddle1.w/2) and 
       (self.y >= paddle1.y - paddle1.h/2) and (self.y <= paddle1.y + paddle1.h/2) then
        ...
        self.angle_speed = paddle1.v/96
    end
end
~~~

Whenever the ball hits the paddle its angle speed gets changed to {% text paddle.v/96 %}. This value was reached by trial and error until it felt nice, you may find
your own angle speed calculations that involve the paddle's velocity somehow. You can go as complex as you want with mathematical functions here, with the end goal of it feeling nice
to play.

{% capture exercises_curve_answer_1 %}
~~~ lua
function Paddle:update(dt)
    ...
    if (self.x + self.r/2 >= paddle2.x - paddle1.w/2) and
       (self.y >= paddle2.y - paddle2.h/2) and 
       (self.y <= paddle2.y + paddle2.h/2) then
        ...
        self.angle_speed = -paddle2.v/96
        ...
    end
~~~
{% endcapture %}

{% accopen [exercises_curve] [Exercises] %}
    1. Make it so that the other paddle can curve the ball as well.
    {% aaccopen [exercises_curve_answer_1] [Answer] %}
        {{ exercises_curve_answer_1 | markdownify }}
    {% accclose %}
    <br>

    2. What happens when the value dividing <code class="text">paddle.v</code> increases? And when it decreases?
    What is a decent interval for the angle speed value such that it doesn't spin too fast nor too slow?
    {% aaccopen [exercises_curve_answer_2] [Answer] %}
        When the value dividing paddle.v increases, the angle speed value decreases, meaning that the added spin from the paddle has a lower effect on the ball's trajectory.
        When the value decreases, the angle speed increases, meaning that the added spin has a higher effect. A decent interval is a number that ranges from -2 to 2. 
        Translating this to degrees, it's about 120 degrees per second to whichever side. You could make any function based on the paddle's velocity (like paddle.v*paddle.v, or
        sin(paddle.v), or sqrt(paddle.v) + log(paddle.v/2), ... feel free to get creative!), but you'd have to scale this function back to this range if you want it to behave
        in an acceptable manner. This range was discovered by trial and error, so your findings on what the range should be may vary depending on what type of gameplay you're looking for.
    {% accclose %}
{% accclose %}
<br>

{% title AI %}

And now for the last thing to make before we have completely functional Pong game, the AI. 
We're gonna do something very simple for the AI: make it follow the ball's y position. At first doing this is ezpz:

~~~ lua
-- in Paddle.lua
function Paddle:new(...)
    ...
    self.ai = settings.ai
    ...
end

function Paddle:update(dt)
    ...
    if self.ai then
        self.y = balls[1].y
    else
        self.y = love.mouse.getY()
    end
    ...
end

-- in Game.lua
function Game:new()
    ...
    paddle1 = Paddle(30, 50)
    paddle2 = Paddle(fg.screen_width - 30, 50, {ai = true})
end
~~~

But if you play this, the AI is pretty much invincible. We need to add some way for it to not follow the ball so closely all the time. 
To do that we're gonna add some maximum velocity to the AI controlled paddle:

~~~ lua
function Paddle:new(...)
    ...
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
    ...
end
~~~

Here we check the difference between the paddle's current y position and ball's y position. Then based on this difference we add a certain velocity (which is this difference, but could
be some other value calculated using this difference as a parameter) to the paddle's y position, but always limitting it by the paddle's maximum velocity. In this way, we get a nice
smooth motion towards the ball that is as slow/fast as we want it to be (but not higher than {% text max_v %}, based on the velocity calculated.

{% capture exercises_ai_answer_1 %}
~~~ lua
-- in Paddle.lua
function Paddle:update(dt)
    if self.ai then
        self.max_v = 175*level
        local dy = self.y - balls[1].y
        if dy < 0 then
            self.y = self.y - math.max((level+1.2)*dy, -self.max_v)*dt
        else
            self.y = self.y - math.min((level+1.2)*dy, self.max_v)*dt
        end
        ...
    else
    ...
end

-- in Ball.lua
function Ball:update(dt)
    ...
    if not self.just_hit_paddle then
        if (self.x - self.r/2 <= paddle1.x + paddle1.w/2) and
           (self.y >= paddle1.y - paddle1.h/2) and 
           (self.y <= paddle1.y + paddle1.h/2) then
            ...
            self.v.x = self.v.x*(1.07 + 0.01*level)
            ...
        end
        ...
    end
    ...
end
~~~
{% endcapture %}

{% capture exercises_ai_answer_2 %}
~~~ lua
-- in Paddle.lua
function Paddle:new(...)
    ...
    self.idle = false
    self.idle_position = 0
    fg.timer:every(0.6, function()
        self.idle_position = fg.screen_height/2 + 
                             math.random(-fg.screen_height/4, fg.screen_height/4)
    end)
end

function Paddle:update(dt)
    if self.ai then
        ...
        if self.idle then 
            dy = self.y - self.idle_position 
        end
        ...
    end
    ...
end

-- in Ball.lua
function Ball:update(dt)
    if not self.just_hit_paddle then
        if (self.x - self.r/2 <= paddle1.x + paddle1.w/2) and
           (self.y >= paddle1.y - paddle1.h/2) and 
           (self.y <= paddle1.y + paddle1.h/2) then
            ...
            paddle2.idle = false
            ...
        end

        if (self.x + self.r/2 >= paddle2.x - paddle1.w/2) and
           (self.y >= paddle2.y - paddle2.h/2) and 
           (self.y <= paddle2.y + paddle2.h/2) then
            ...
            paddle2.idle = true
            ...
        end
    end
    ...
    if self.dead then
        ...
        paddle2.idle = false
        table.insert(balls, Ball(fg.screen_width/2, fg.screen_height/2, 
                    {angle = fg.utils.math.random(0, 2*math.pi)}))
    end
end
~~~
{% endcapture %}

{% accopen [exercises_ai] [Exercises] %}
    1. How would you make it so that the AI's difficulty scales with the current level? (<strong>hint</strong>: change its max velocity as well as the rate at which its velocity is changed
    to catch up with the ball's position)
    {% aaccopen [exercises_ai_answer_1] [Answer] %}
        Initially bind the paddle's max velocity to the level according to some formula. Then do the same for the dy variable. Optionally, make it so that with each ball hit on either paddle,
        the ball's velocity is increased based on the current level, making each round harder the longer it goes on for.<br><br>
        {{ exercises_ai_answer_1 | markdownify }}
    {% accclose %}
    <br>

    2. Make the AI paddle behave in a more human-like manner by adding some randomicity to it. Whenever the ball is going towards the player and not back to the AI paddle, make it so that it
    moves about randomly following whatever pattern you think a normal human would when he's waiting for the ball to come back to his side.
    {% aaccopen [exercises_ai_answer_2] [Answer] %}
        Whenever the ball is moving away from the AI paddle, move it towards a variable named .idle_position. Add a timer that picks a new idle position around the y center of the game
        every few seconds. This will make it so that the AI paddle moves randomly around the center of the screen whenever it's waiting for the ball to bounce back, and then when it does
        bounce back it changes to the normal following behavior.<br><br>
        {{ exercises_ai_answer_2 | markdownify }}
    {% accclose %}
{% accclose %}
<br>

{% title Polish %}

You should have a completely functional Pong game by now. But it's kinda boring to look at... 
We can do a lot of stuff to make it look more interesting, some of them are described in this video: 

{% youtube Fy0aCDmgnxg %}
<br>

while a lot of them aren't. But the fact is that making a game feel nice to play and look at is highly about experimentation, trial and error. 
I'll outline some of the things you can do, but you're the one who should go a step further and do even more if you want to.

{% title Ball Rotation %}

The first thing we can add is ball rotation. Since the ball actually curves, 
it makes sense that it would spin around itself too. To do this, we code the following:

~~~ lua
function Ball:new(...)
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

Every frame we add to the ball's rotation its rotation speed, and when the ball hits a paddle we make 
sure to take into account that paddle's velocity as well. To draw the rotated rectangle:

~~~ lua
function Ball:draw()
    fg.utils.graphics.pushRotate(self.x, self.y, self.rotation)
    love.graphics.rectangle('fill', self.x - self.r/2, self.y - self.r/2, self.r, self.r)
    love.graphics.pop()
end
~~~

The {% text fg.utils.graphics.pushRotate %} call rotates whatever is drawn between it and {% text love.graphics.pop() %} by 
{% text self.rotation %} angles around point {% text self.x, self.y %}.

{% capture exercises_rotation_answer_1 %}
~~~ lua
function Ball:update(dt)
    ...
    if not self.just_hit_paddle then
        ...
        if (self.x + self.r/2 >= paddle2.x - paddle1.w/2) and
           (self.y >= paddle2.y - paddle2.h/2) and 
           (self.y <= paddle2.y + paddle2.h/2) then
            ...
            self.rotation_speed = paddle2.v/4
            ...
        end
    end
    ...
~~~
{% endcapture %}

{% capture exercises_rotation_answer_2 %}
~~~ lua
function Ball:update(dt)
    ...
    if self.y < 0 + self.r/2 then
        self.angle = -self.angle
        self.rotation_speed = self.rotation_speed/2
    end
    if self.y > fg.screen_height - self.r/2 then
        self.angle = -self.angle
        self.rotation_speed = self.rotation_speed/2
    end
    ...
end
~~~
{% endcapture %}

{% accopen [exercises_rotation] [Exercises] %}
    1. Make it so that the other paddle also adds rotation to the ball.
    {% aaccopen [exercises_rotation_answer_1] [Answer] %}
        {{ exercises_rotation_answer_1 | markdownify }}
    {% accclose %}
    <br>

    2. Make the ball's rotation be cut in half whenever it hits the top or bottom edge of the screen.
    {% aaccopen [exercises_rotation_answer_2] [Answer] %}
        {{ exercises_rotation_answer_2 | markdownify }}
    {% accclose %}
{% accclose %}
<br>

{% title Ball Trails %}

To make the ball look even better we can add trails. We'll do that by repeatedly spawning rectangles that quickly fade away at the ball's current position. 

~~~ lua
-- in BallTrail.lua
local BallTrail = fg.Object:extend('BallTrail')

function BallTrail:new(x, y, r, rotation)
    self.x = x
    self.y = y
    self.r = r + fg.utils.math.random(-4, 4)
    self.rotation = fg.utils.math.random(0, 2*math.pi)
    self.alpha = 0
    self.dead = false

    fg.timer:tween(0.02, self, {alpha = 255}, 'in-out-cubic')
    fg.timer:after(0.02, function()
        fg.timer:tween(0.4, self, {alpha = 0}, 'in-out-cubic')
        fg.timer:after(0.4, function() self.dead = true end)
    end)
end

function BallTrail:update(dt)

end

function BallTrail:draw()
    love.graphics.setColor(255, 255, 255, self.alpha)
    fg.utils.graphics.pushRotate(self.x, self.y, self.rotation)
    love.graphics.rectangle('fill', self.x - self.r/2, self.y - self.r/2, self.r, self.r)
    love.graphics.pop()
    love.graphics.setColor(255, 255, 255, 255)
end

return BallTrail
~~~

There are a few interesting things to notice here. One is the use of the [Timer](/documentation/timer) module. 
First we tween this trail's alpha to full color over {% number 0.02 %} seconds; then after those {% number 0.02 %} seconds we tween 
that same alpha to {% number 0 %} over {% number 0.4 %} seconds, giving the trail effect if we're spawning multiple of those near each other. 
After that same amount of time we also set the entity to die, doing the same as we did for the balls' death: removing dead entities
from the list that holds them.

~~~ lua
function Game:new()
    ...
    ball_trails = {}
    ...
end

function Game:update(dt)
    ...
    for i = #ball_trails, 1, -1 do
        ball_trails[i]:update(dt)
        if ball_trails[i].dead then 
            table.remove(ball_trails, i) 
        end
    end
    ...
end

function love.draw()
    ...
    for _, ball_trail in ipairs(ball_trails) do 
        ball_trail:draw() 
    end
    ...
end
~~~

After doing this we can finally actually spawn the trails:

~~~ lua
function Ball:new(...)
    ...
    fg.timer:every({0.02, 0.04}, function()
        table.insert(ball_trails, BallTrail(self.x, self.y, self.r, self.rotation))
    end)
end
~~~

This creates a new timer that will spawn a trail every {% number 0.02-0.04 %} seconds, or nearly every {% number 2-4 %} frames. Playing around with this number
will give you different trail effects. Playing around with how long a ball trail object takes to fade away will also make the trail look different. 
Scaling the trail down as it fades away makes it look even more different... All this means is that there are tons of ways of getting different trail effects, 
and that the one outlined here is only a very particular one.

{% capture exercises_trail_answer_1 %}
~~~ lua
local PaddleTrail = fg.Object:extend('PaddleTrail')

function PaddleTrail:new(x, y, w, h)
    self.x, self.y = x, y
    self.w = w + fg.utils.math.random(-4, 4)
    self.h = h + fg.utils.math.random(-4, 4)
    self.alpha = 0
    self.dead = false

    fg.timer:tween(0.02, self, {alpha = 255}, 'in-out-cubic')
    fg.timer:after(0.02, function()
        fg.timer:tween(0.2, self, {alpha = 0}, 'in-out-cubic')
        fg.timer:after(0.2, function() self.dead = true end)
    end)
end

function PaddleTrail:update(dt)

end

function PaddleTrail:draw()
    love.graphics.setColor(255, 255, 255, self.alpha)
    love.graphics.rectangle('fill', self.x - self.w/2, self.y - self.h/2, self.w, self.h)
    love.graphics.setColor(255, 255, 255, 255)
end

return PaddleTrail
~~~
{% endcapture %}

{% capture exercises_trail_answer_2 %}
~~~ lua
function Ball:new(...)
    ...
    self.trail_t = 0
    ...
end

function Ball:update(dt)
    ...
    self.trail_t = self.trail_t + dt
    if self.trail_t > (0.03 - math.abs(0.0125*self.angle_speed)) then
        self.trail_t = 0
        table.insert(ball_trails, BallTrail(self.x, self.y, self.r))
    end
    ...
end
~~~
{% endcapture %}

{% capture exercises_trail_answer_3 %}
~~~ lua
function Ball:new(...)
    ...
    self.trail_timer = fg.timer:every({0.02, 0.04}, function()
        table.insert(ball_trails, BallTrail(self.x, self.y, self.r))
    end)
end

function Ball:update(dt)
    ...
    if self.dead then
        ...
        fg.timer:cancel(self.trail_timer)
        ...
    end
end
~~~
{% endcapture %}

{% accopen [exercises_trail] [Exercises] %}
    1. Add trails to the paddles as well.
    {% aaccopen [exercises_trail_answer_1] [Answer] %}
        Paddle trails are extremely similar to the ball trails, since we're using pretty much the same fading functionality. The difference being a rectangle and that you
        may wanna change the tween times so it doesn't look as confusing:<br><br>
        {{ exercises_trail_answer_1 | markdownify }}
    {% accclose %}
    <br>

    2. Make it so that the trail spawning interval for the ball is tied to its angle speed. (<strong>hint</strong>: drop the use of timers and calculate the time needed on your own on the update
    function, since you can't get variable times using the Timer module)
    {% aaccopen [exercises_trail_answer_2] [Answer] %}
        Here we calculate the time needed based on some formula (you may come up with another) that uses the angle speed as a parameter. The adding of dt and then zeroing the trail_t variable
        is the basic timing construct that the Timer module also does internally for its calculations. The point here is that the Timer module is not as flexible to accept arbitrary intervals
        that change based on whatever, so you have to do it yourself:<br><br>
        {{ exercises_trail_answer_2 | markdownify }}
    {% accclose %}
    <br>

    3. Whenever a ball dies its trails still keep getting spawned even after it has been gone. Find a way of fixing this.
    {% aaccopen [exercises_trail_answer_3] [Answer] %}
        The trails stay alive because we're using fuccboiGDX's global timer and we're not telling that timer to die whenever the ball dies. To fix this,
        we save the id returned by fg.timer (every timer call returns an id so that we can use it like we're gonna do now) and then cancel it when the
        ball dies.
        {{ exercises_trail_answer_3 | markdownify }}
    {% accclose %}
{% accclose %}
<br>

{% title Ball Size %}

Another thing we can do is change the ball's size based on its velocity, as well as add some pulsing to its size so that it looks a bit more alive. The first one:

~~~ lua
function Paddle:update(dt)
    ...
    if (self.x - self.r/2 <= paddle1.x + paddle1.w/2) and 
       (self.y >= paddle1.y - paddle1.h/2) and (self.y <= paddle1.y + paddle1.h/2) then
        fg.timer:cancel('r_speed_add')
        fg.timer:tween('r_speed_add', 1.5, self, {r = 30 - math.abs(12.5*self.angle_speed)}, 
                       'in-out-cubic')
    end
    ...
end
~~~

What this does is create a tween that acts on the ball's radius through a formula that uses the angle speed as a parameter. This formula says that the higher the angle speed, the smaller
the radius. This makes it so that when the ball is turning a lot it looks smaller (and its trail looks smaller too since each trail is created using the current radius).

The second thing we can do, making the ball pulsate:

~~~ lua
function Ball:new(...)
    ...
    self.r_pulse = 0
    fg.timer:every({0.02, 0.04}, function()
        fg.timer:tween(0.02, self, {r_pulse = fg.utils.math.random(-4, 4)}, 'in-elastic')
    end)
end

function Ball:draw()
    fg.utils.graphics.pushRotate(self.x, self.y, self.rotation)
    local r = self.r + self.r_pulse
    love.graphics.rectangle('fill', self.x - r/2, self.y - r/2, r, r)
    love.graphics.pop()
end
~~~

Here we create a timer that tweens an additional radius to be added to the original radius between {% number -4 %} and {% number 4 %}. Doing this every
{% number 0.02-0.04 %} seconds, it gives a nice twitchy/pulsating effect to the ball. You could also make the intensity of this twitching be higher if the ball's velocity
is fast... Or make it higher/lower when it touches a border or a paddle. The possibilities are endless!

{% capture exercises_size_answer_1 %}
~~~ lua
function Paddle:new(...)
    ...
    self.w_pulse = 0
    self.h_pulse = 0
    fg.timer:every({0.02, 0.04}, function()
        fg.timer:tween(0.02, self, {w_pulse = fg.utils.math.random(-4, 4)}, 'in-elastic')
        fg.timer:tween(0.02, self, {h_pulse = fg.utils.math.random(-4, 4)}, 'in-elastic')
    end)
    ...
end

function Paddle:draw()
    local w, h = self.w + self.w_pulse, self.h + self.h_pulse
    love.graphics.rectangle('fill', self.x - w/2, self.y - h/2, w, h)
end
~~~
{% endcapture %}

{% accopen [exercises_size] [Exercises] %}
    1. Do the same for paddles and make them pulsate like the ball does.
    {% aaccopen [exercises_size_answer_1] [Answer] %}
        {{ exercises_size_answer_1 | markdownify }}
    {% accclose %}
{% accclose %}
<br>

{% title Challenges %}

There are things you can do to polish the game even more, but instead of just giving you the working code on how to do them, I'll pose them as challenges that you need to figure out
for yourself. Building up the necessary skills so you can search and do things on your own is important for game development, and that
building up can only happen when you're actually doing things without too much hand-holding.

1. Use either [love.graphics.print](https://www.love2d.org/wiki/love.graphics.print) or the [Text](/documentation/text) module to write the current level somewhere on the screen.

2. Adding particles effects is possible by using the [Particles](/documentation/particles) module or by creating particle objects and spawning them as you wish. 
If you go for the former, set it up according to the description on that page, create a particle system using the editor, 
and spawn this particle system whenever the ball hits the screen edges or a paddle. Remember that you're not using the engine and so you don't need to use
{% text fg.world:spawnParticles %}, only {% text fg.getPS %} and then handling the particle system on your own.

2. Adding camera shake whenever the ball hits something can be done by using the [Camera](/documentation/camera) module. Create a new camera instance, set it to follow the center of the screen
so that when you shake it it doesn't keep going offscreen, set attach/detach around everything in the {% text Game:draw %} function so that your shakes are applied to everything in the 
screen, and then use the {% call :shake %} call to make the screen shake.

3. Shader effects can be achieved by using [love.graphics.newShader](http://www.love2d.org/wiki/love.graphics.newShader). fuccboiGDX comes with a few default shaders located in 
{% text fuccboi/resources/shaders %}. Play around with them and see what kinds of effects you can create. The effect on the gif up there was achieved through the use
of 3 shaders in succession. Also, remember to use [canvases](https://www.love2d.org/wiki/Canvas) to apply screen wide shaders (all example shaders that come with fuccboiGDX are screen wide).
And to apply multiple shaders you'll need multiple canvases.
<br><br>

{% title The End %}

And that's it! If you finished all exercises and challenges you should have something that looks pretty similar to this:

{% img center /assets/curvemaster.gif %}

Hopefully you did even more and your version of it looks a lot better! In any case, you should also have a pretty good idea on how to read fuccboiGDX's documentation
and you should be able to start using it for your own games. You can find the full source code for the complete game (with the challenges finished) 
[here](https://github.com/adonaac/fuccboiGDX-tutorials/tree/master/advanced/CurveMaster).
<br><br>
