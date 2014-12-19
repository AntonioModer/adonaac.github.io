---
layout: page
title: 2D Platformer 
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

{% img center /assets/2dplatformer.gif %}

This tutorial will teach you about some of the basic features of the engine through building a 2D platformer.
You should have fuccboiGDX [downloaded](/downloads/fuccboi.zip) and [set up](/tutorials#Getting_Started) properly.
<br><br>

{% title Player Creation %}

The first thing we're gonna do is create a basic Player class. Since we want to use the engine and get box2d physics out of the box,
we want it to be a physics entity. Using the [physics entity template](/examples#Physics_Template), we get something like this:

~~~ lua
-- in Player.lua
local Player = fg.Class('Player', 'Entity')
Player:implement(fg.PhysicsBody)

function Player:new(area, x, y, settings)
    Player.super.new(self, area, x, y, settings)
    self:physicsBodyNew(area, x, y, settings)
end

function Player:update(dt)
    self:physicsBodyUpdate(dt)
end

function Player:draw()
    self:physicsBodyDraw()
end

return Player
~~~

To understand everything that's going on with that code: [Class](/documentation/class), [Collision](/documentation/collision), 
[Entity](/documentation/entity) and [PhysicsBody](/documentation/physicsbody). 

With that in mind, to spawn a player we do this:

~~~ lua
-- in Game.lua
Player = require 'Player'

function Game:new()
    fg.world:createEntity('Player', fg.screen_width/2, fg.screen_height/2)
end
~~~

Exactly what's happening here is that every class you create with the {% text mg.Class %} call can be spawned by the {% text fg.world:createEntity %} call, 
since that class gets automatically added to the engine (see more about this [here](/documentation/world#Creation_Methods)). If you run all the above you should see a blue square on the 
center of the screen. These are the player's physics body's debug drawing lines. You can turn off debug drawing by doing {% text fg.debug_draw = false %}.

Another thing to note here is that {% text fg.world:createEntity %} is an alias for {% text fg.world.areas['Default']:createEntity %}, since the engine works
through areas/levels. It just happens that the {% string 'Default' %} one is created automatically and has aliases created for each one of its methods for simplicity. 
You can learn more about areas [here](/documentation/area).
<br><br>

{% title Animations and Movement %}

Squares aren't that interesting, though, so adding some visuals to the player would be nice. To do this we're gonna use the following sprite:

{% img center /assets/idle.png %}

Using the [Animation](/documentation/animation) module we can quickly create an animation from a spritesheet. In this case we have a single sprite, but it can
also be used for just loading single images:

~~~ lua
function Player:new(area, x, y, settings)
    Player.super.new(self, area, x, y, settings)
    self:physicsBodyNew(area, x, y, settings)

    self.idle = fg.Animation(love.graphics.newImage('idle.png'), 32, 32, 0)
end

function Player:update(dt)
    self:physicsBodyUpdate(dt)
    self.idle:update(dt)
end

function Player:draw()
    self:physicsBodyDraw()
    self.idle:draw(self.x, self.y, 0, 1, 1, self.idle.frame_width/2, self.idle.frame_height/2)
end
~~~

LÖVE's draw function works by specifying the top left position of the image, so when we draw our animation we have to make sure 
to offset it by its width and height (the last 2 parameters), since positions are always the center of an object. If you run the 
above you should see the player sprite on top of the blue square. 

{% capture exercises_size_answer_1 %}
~~~ lua
-- in Game.lua
function Game:new()
    fg.world:createEntity('Player', fg.screen_width/2, fg.screen_height/2, 
                         {w = 16, h = 28})
end

-- in Player.lua
function Player:draw()
    self:physicsBodyDraw()
    self.idle:draw(self.x, self.y, 0, 1, 1, 
                   self.idle.frame_width/2, self.idle.frame_height/2 + 2)
end
~~~
{% endcapture %}

{% capture exercises_size_answer_2 %}
~~~ lua
function Player:draw()
    ...
    self.idle:draw(self.x, self.y, 0, 1, 1, 
                   self.idle:getWidth()/2, self.idle:getHeight()/2)
end
~~~
{% endcapture %}

{% accopen [exercises_size] [Exercises] %}
    1. The physics body of the player doesn't really match his sprite's width and height. How would you go about changing it so it does? (<strong>hint</strong>: 
    <a href="/documentation/physicsbody#methods">PhysicsBody constructor's settings</a>)
    {% aaccopen [exercises_size_answer_1] [Answer] %}
        {{ exercises_size_answer_1 | markdownify }}
    {% accclose %}
    <br>

    2. What's another way of accessing an animation's width and height? (<strong>hint</strong>: 
    <a href="/documentation/animation#methods">Animation methods</a>)
    {% aaccopen [exercises_size_answer_2] [Answer] %}
        For an animation, :getWidth/Height are the same as .frame_width/height:<br><br>
        {{ exercises_size_answer_2 | markdownify }}
    {% accclose %}
{% accclose %}
<br>

Now that we have an image attached to our player body, we can try making it move. We're going to do this by using the [Input](/documentation/input) module. 
In a platformer, we mainly move left and right, so first let's bind those keys to actions:

~~~ lua
function Player:new(...)
    ...
    fg.input:bind('a', 'move_left')
    fg.input:bind('d', 'move_right')
    ...
end
~~~

If you want to use a gamepad then you can do it by using {% string 'dpleft' %} and {% string 'dpright' %} on top of {% string 'a' %} and {% string 'd' %}:

~~~ lua
function Player:new(...)
    ...
    fg.input:bind('a', 'move_left')
    fg.input:bind('d', 'move_right')
    fg.input:bind('dpleft', 'move_left')
    fg.input:bind('dpright', 'move_right')
    ...
end
~~~

And then we can check if that action is being pressed:

~~~ lua
function Player:update(dt)
    ...
    if fg.input:down('move_left') then

    end
    if fg.input:down('move_right') then

    end
    ...
end
~~~

To actually make the character move we just insert the movement code into each one of those {% text ifs %}. Since we're using box2d, making an object move has to
be done through its [Body](http://www.love2d.org/wiki/Body). A very misinformed argument that a lot of people make when talking about physics engines is that they seem to make 
games feel sluggish, slow and with a lack of control. That is only true if you only move your bodies by applying forces to them. We're not going to do that! Instead, we'll set 
its velocity directly, using the {% call :setLinearVelocity %} call. In this way, you can do velocity and acceleration calculations yourself, and then only apply 
the final velocity to the body. This gives you as much control as you need over how an object moves. See more on this [here](http://www.iforce2d.net/b2dtut/constant-speed).

~~~ lua
function Player:update(dt)
    ...
    if fg.input:down('move_left') then
        local vx, vy = self.body:getLinearVelocity()
        self.body:setLinearVelocity(-150, vy)
    end
    if fg.input:down('move_right') then
        local vx, vy = self.body:getLinearVelocity()
        self.body:setLinearVelocity(150, vy)
    end
    ...
end
~~~

Because we only want to set the x component, we first need to get the body's current velocity to use it on the component we don't want changed (in this case the y component). In any case,
if you run the above you'll notice that the player never stops moving to one side or the other. This is because you're setting the body's linear velocity to {% number 150 %} or
{% number -150 %} and never decreasing it. To fix that, we add damping:

~~~ lua
function Player:update(dt)
    ...
    if fg.input:down('move_left') then
        local vx, vy = self.body:getLinearVelocity()
        self.body:setLinearVelocity(-150, vy)
    end
    if fg.input:down('move_right') then
        local vx, vy = self.body:getLinearVelocity()
        self.body:setLinearVelocity(150, vy)
    end
    if not fg.input:down('move_left') and not fg.input:down('move_right') then
        local vx, vy = self.body:getLinearVelocity()
        self.body:setLinearVelocity(0.8*vx, vy)
    end
    ...
end
~~~

What we're doing here is simply multiplying the player's x velocity by {% number 0.8 %} every frame if he's not moving left nor right. This gives it a nice stopping motion that isn't
too abrupt nor too slow. Different values will have different effects, for instance, {% number 0.95 %} will feel very slow, while {% number 0.5 %} will feel very abrupt.

Now that we have proper movement we could add a running animation:

{% img center /assets/run.png %}

And to load this animation:

~~~ lua
function Player:new(...)
    ...
    self.idle = fg.Animation(love.graphics.newImage('idle.png'), 32, 32, 0)
    self.run = fg.Animation(love.graphics.newImage('run.png'), 32, 32, 0.18)
end
~~~

The {% number 0.18 %} value is the amount of time passed between each frame change. For the velocity we have now ({% number 150 %}), this value feels pretty nice.

If you run the game, you'll notice nothing has changed, though. That's because you're neither updating the animation nor drawing it. But we have multiple animations now, how do we know when to 
update/draw each one? A way is adding a variable that will hold the current animation state, and change that state based on some criteria. Something like this:

~~~ lua
function Player:new(...)
    ...
    self.animation_state = 'idle'
    self.idle = fg.Animation(love.graphics.newImage('idle.png'), 32, 32, 0)
    self.run = fg.Animation(love.graphics.newImage('run.png'), 32, 32, 0.18)
end

function Player:update(dt)
    ...
    local vx, vy = self.body:getLinearVelocity()
    if math.abs(vx) < 25 then self.animation_state = 'idle'
    else self.animation_state = 'run' end
    self[self.animation_state]:update(dt)
end

function Player:draw()
    ...
    self[self.animation_state]:draw(self.x, self.y, 0, 1, 1, 
                                    self[self.animation_state].frame_width/2, 
                                    self[self.animation_state].frame_height/2 + 2)
end
~~~

{% text .animation_state %} can either be {% string 'idle' %} or {% string 'run' %}, which are the same names as the ones we 
have for our variables holding the animations. This is why {% text self[self.animation_state] %} is a valid way of accessing the current animation. We set the
current animation by simply checking the player's x velocity: if it's lower than {% number 25 %} we set it to idle, otherwise the player is running.

{% capture exercises_run_answer_1 %}
~~~ lua
function Player:new(...)
    ...
    fg.input:bind('leftx', 'move_horizontal')
end

function Player:update(dt)
    ...
    local x = fg.input:down('move_horizontal')
    if x then
        if x < 0 then 
            local vx, vy = self.body:getLinearVelocity()
            self.body:setLinearVelocity(-150, vy)
        elseif x > 0 then
            local vx, vy = self.body:getLinearVelocity()
            self.body:setLinearVelocity(150, vy)
        end
    else
        local vx, vy = self.body:getLinearVelocity()
        self.body:setLinearVelocity(48*dt*vx, vy)
    end
    ...
end
~~~
{% endcapture %}

{% capture exercises_run_answer_2 %}
~~~ lua
function Player:new(...)
    ...
    self.direction = 'right'
    ...
end

function Player:update(dt)
    ...
    if fg.input:down('move_left') then
        self.direction = 'left'
        ...
    end
    if fg.input:down('move_right') then
        self.direction = 'right'
        ...
    end
    ...
end

function Player:draw()
    ...
    if self.direction == 'right' then
        self[self.animation_state]:draw(self.x, self.y, 0, 1, 1, 
                                        self[self.animation_state].frame_width/2, 
                                        self[self.animation_state].frame_height/2 + 2)
    elseif self.direction == 'left' then
        self[self.animation_state]:draw(self.x, self.y, 0, -1, 1, 
                                        self[self.animation_state].frame_width/2, 
                                        self[self.animation_state].frame_height/2 + 2)
    end
end
~~~
{% endcapture %}

{% accopen [exercises_run] [Exercises] %}
    1. Make it so that the player can also be moved by using the gamepad's left stick.
    {% aaccopen [exercises_run_answer_1] [Answer] %}
        The analog buttons of a gamepad (sticks and L2/R2) return numbers instead of booleans. In the case of the left stick, there's a number going from -1 to 1
        for the horizontal position of the stick as well as the vertical one. We're only interested in the horizontal position (left, right) so we only care about
        the 'leftx' button. We bind this and then check to see if its pressed. If it is, we move the player normally, if isn't then we apply damping.<br><br>
        {{ exercises_run_answer_1 | markdownify }}
    {% accclose %}
    <br>

    2. So far the player can only look to the right. How would you change the code so that he's also capable of looking to the left? (<strong>hint</strong>: 
    create a variable named direction that can be either {% string 'left' %} or {% string 'right' %} and use <a href="http://www.love2d.org/wiki/love.graphics.draw">
    draw's scaling parameter</a> with -1 on the x component to flip the current image)
    {% aaccopen [exercises_run_answer_2] [Answer] %}
        The most interesting part of this is the flip. Whenever you scale something by -1 it flips around the point that thing is being drawn at, in this case,
        the top left of the sprite. Naturally, the character is mirrored around this point and therefore moves to the left. To fix this, instead of subtracting half the sprite's width, we add it.
        <br><br>
        {{ exercises_run_answer_2 | markdownify }}
    {% accclose %}
{% accclose %}
<br>


{% title Tilemap %}

We have a character that moves left and right, with animations and everything. But in a platformer we also need to be able to jump! But how to jump without gravity?
You can't. Well, you can but you'd just go up endlessly until you hit something, and if there's nothing to hit then you'd just die because you'd freeze as you go up in the sky.
So we should add some gravity to the [physics world](http://www.love2d.org/wiki/World) to prevent this from happening:

~~~ lua
function Game:new()
    ...
    fg.world.box2d_world:setGravity(0, 20*32)
    ...
end
~~~

The character also looks pretty small on the screen. We can fix that by scaling the screen up and doubling the screen size:

~~~ lua
function Game:new()
    ...
    fg.screen_scale = 2
    fg.setScreenSize(960, 720)
    ...
end
~~~

If you run the game now you'll see that the character looks bigger and that he falls down. But he falls offscreen! Since we added gravity, the world is just behaving like we told it to, however
there's nothing holding the character in place so he'll just keep falling forever. Something we can do to fix this is define a map. Using the [Tilemap](/documentation/tilemap) module, we can
create a tilemap that is able to collide with world objects pretty easily. The tileset we're going to use is this one:

{% img center /assets/tileset-normal.png %}

And the code to create the map:

~~~ lua
function Game:new()
    ...
    tilemap = fg.Tilemap(400, 420, 32, 32, love.graphics.newImage('tileset-normal.png'), {
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1},
        {1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1},
        {1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1},
        {1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1},
        {1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    })
    tilemap:setAutoTileRules({6, 14, 12, 2, 10, 8, 7, 15, 13, 3, 11, 9})
    tilemap:autoTile()
    fg.world:generateCollisionSolids(tilemap)
    fg.world:addToLayer('Default', tilemap)
    ...
end
~~~

If you can get the player to spawn inside the thingy, then you'll see that it will collide with the map and not fall off the screen anymore.

{% accopen [exercises_tilemap] [Exercises] %}
    1. Why is the tilemap only using 1s and 0s? What happens if you use other numbers? Which numbers can actually be used? And how does all this relate to the
    {% call :autoTile %} and to the {% call :setAutoTileRules %} call? (<strong>hint</strong>: <a href="/documentation/tilemap">Tilemap</a> module)
    {% aaccopen [exercises_tilemap_answer_1] [Answer] %}
        The tilemap is only using 1s and 0s because the auto tile call will set the tiles automatically based on the auto tile rules. The possible values are however
        many tiles your tileset has, in this case it's 12. Any value other than 0 will be recognized as an active tile and changed by the :autoTile call. If that call isn't made
        then the numbers will correspond to whatever tile has that number from the tileset. The numbers from the tileset are read in a top-down, left-right manner. So top left is 1,
        top right is 6, bottom left is 7 and bottom right is 12.
    {% accclose %}
    <br>

    2. What does the {% call :generateCollisionSolids %} method do? (<strong>hint</strong>: <a href="/documentation/area#Creation_Methods">Area's creation methods</a>)
    {% aaccopen [exercises_tilemap_answer_2] [Answer] %}
        It automatically generates world collision solids based on the collision data from the tilemap. Collision data is generated by default to match all non 0 tiles, but can
        be changed using the :setCollisionData method.
    {% accclose %}
{% accclose %}
<br>

{% title Jump %}

Now that we have gravity in, we can add the jump. Jumping is actually fairly simple... Since we're using box2d all we have to do is set the y velocity component to a negative value and the body 
will go up in the air; gravity will pull the body down, so you get a pretty decent jump arc effortlessly:

~~~ lua
function Player:new(...)
    ...
    fg.input:bind(' ', 'jump')
    fg.input:bind('fdown', 'jump')
    ...
end

function Player:update(dt)
    ...
    if fg.input:pressed('jump') then
        local vx, vy = self.body:getLinearVelocity()
        self.body:setLinearVelocity(vx, -250)
    end
    ...
end
~~~

If you run the above you can now jump by pressing space. Play around with different impulse and gravity values until you get something that feels right. 

We can also add jumping and falling animations to the player. We're gonna use these sprites:

{% img center /assets/jump.png %}
{% img center /assets/fall.png %}

On top of just adding the animations, we need to figure out a way to make sure that the right animations play when the player is jumping. One way of doing this
is adding a {% text .jumping %} boolean. Whenever the player presses the jump button we set this to true, and then set the animation based on if this is true or not.
If the player is falling (y velocity > 0), then we set the animation to be the falling one instead. This can all be done like this:

~~~ lua
function Player:new(...)
    ...
    self.jumping = false
    self.jump = fg.Animation(love.graphics.newImage('jump.png'), 32, 32, 0)
    self.fall = fg.Animation(love.graphics.newImage('fall.png'), 32, 32, 0)
    ...
end

function Player:update(dt)
    ...
    if fg.input:pressed('jump') then
        ...
        self.jumping = true
        ...
    end
    ...
    local vx, vy = self.body:getLinearVelocity()
    if math.abs(vx) < 25 then self.animation_state = 'idle'
    else self.animation_state = 'run' end
    if self.jumping then self.animation_state = 'jump' end
    if vy > 5 then self.animation_state = 'fall' end
    self[self.animation_state]:update(dt)
end
~~~

Running this, you'll notice one problem: after the player jumps he never changes to another animation. This happens because {% text self.jumping %} is set to true but never
set to false again. We want to set it to false when the player hits the ground. To do that, we'll use fuccboiGDX's [Collision](/documentation/collision) system. First, set the player to
generate a collision callback whenever he enters collision with a [Solid](/documentation/solid):

~~~ lua
Player = fg.Class('Player', 'Entity')
Player:implement(fg.PhysicsBody)

Player.enter = {'Solid'}

function Player:new(...)
...
~~~

Then, we define the collision callback function and set the jumping boolean to false whenever the collided object is a Solid:

~~~ lua
function Player:onCollisionEnter(other, contact)
    if other.tag == 'Solid' then
        self.jumping = false
    end
end
~~~

And now whenever you jump, the jumping boolean is set to true, and then whenever you enter contact with a solid again (in a jump this usually happens when you hit the ground again)
it will be set to false and the animation state can go back to normal.

Another simple problem that happens and has to do with jumping: if you keep pressing the movement key near a wall you'll get stuck midair. This has to do with how box2d handles its
object's friction. It can be easily fixed by doing:

~~~ lua
function Player:new(...)
    Player.super.new(self, area, x, y, settings)
    self:physicsBodyNew(area, x, y, settings)

    self.fixture:setFriction(0)
    ...
end
~~~

Objects with 0 friction will always slide and not get stuck on each other. I really recommend reading [box2d's manual](http://www.box2d.org/manual.html) 
as well as most tutorials [here](http://www.iforce2d.net/b2dtut/) to learn how box2d behaves better.

{% capture exercises_jump_answer_1 %}
~~~ lua
function Player:new(...)
    ...
    self.max_jumps = 1
    self.jumps_left = self.max_jumps
    ...
end

function Player:update(dt)
    ...
    if fg.input:pressed('jump') then
        if self.jumps_left > 0 then
            self.jumping = true
            local vx, vy = self.body:getLinearVelocity()
            self.body:setLinearVelocity(vx, -250)
            self.jumps_left = self.jumps_left - 1
        end
    end
    ...
end

function Player:onCollisionEnter(other, contact)
    if other.tag == 'Solid' then
        self.jumping = false
        self.jumps_left = self.max_jumps
    end
end
~~~
{% endcapture %}

{% capture exercises_jump_answer_2 %}
~~~ lua
function Player:onCollisionEnter(other, contact)
    if other.tag == 'Solid' then
        local solid_top = other.object.y - other.object.h/2
        local player_bottom = self.y + self.h/2 - 4
        if solid_top > player_bottom then
            self.jumping = false
            self.jumps_left = self.max_jumps
        end
    end
end
~~~
{% endcapture %}

{% capture exercises_jump_answer_3 %}
~~~ lua
function Player:update(dt)
    ...
    if fg.input:released('jump') then
        local vx, vy = self.body:getLinearVelocity()
        if vy < 0 then self.body:setLinearVelocity(vx, 0) end
    end
    ...
end
~~~
{% endcapture %}

{% capture exercises_jump_answer_4 %}
~~~ lua
function Player:update(dt)
    ...
    if fg.input:pressed('jump') then
        if self.jumps_left > 0 then
            self.jumping = true
            local vx, vy = self.body:getLinearVelocity()
            self.body:setLinearVelocity(vx, -250)
            self.jumps_left = self.jumps_left - 1
            self.jump_press_time = love.timer.getTime()
        end
    end
    if fg.input:released('jump') then
        local stopJump = function()
            self.jump_press_time = 0
            local vx, vy = self.body:getLinearVelocity()
            if vy < 0 then self.body:setLinearVelocity(vx, 0) end
        end
        local dt = love.timer.getTime() - self.jump_press_time
        if dt >= 0.125 then stopJump()
        else fg.timer:after(0.125 - dt, function() stopJump() end) end
    end
    ...
end
~~~
{% endcapture %}

{% accopen [exercises_jump] [Exercises] %}
    1. If you press space multiple times, the player will jump multiple times. How would you go about limitting the number of jumps the player can perform? 
    (<strong>hint</strong>: create a {% text .max_jumps %} variable and a {% text .jumps_left %} variable)
    {% aaccopen [exercises_jump_answer_1] [Answer] %}
        The .max_jumps variable has the maximum number of jumps the player can perform. Set it to 1. The .jumps_left variable initially has the maximum number of jumps, which is also 1.
        When the player jumps, decrease the .jumps_left variable, and before each jump add a check to see if the number of jumps left is higher than 1.
        When the player reaches the ground, set the .jumps_left variable to .max_jumps, since the player needs to be able to jump again. <br><br>
        {{ exercises_jump_answer_1 | markdownify }}
    {% accclose %}
    <br>

    2. You'll notice that jumping and hitting a Solid (like the sides of the map) before you start falling changes your animation. This happens because the jumping boolean
    is set to false whenever you hit any Solid, its position not being accounted for. How would you fix this so that the animation only gets reset when you hit solids below you?
    {% aaccopen [exercises_jump_answer_2] [Answer] %}
        Check the player's bottom position with the solid's top position, if it's less, then the player is above the ground. <br><br>
        {{ exercises_jump_answer_2 | markdownify }}
    {% accclose %}
    <br>

    3. Right now when the player jumps he never stops midair. Something that lots of platformers do is let the player control the jump height a bit. 
    How would you do this? (<strong>hint</strong>: use {% text fg.input:released %})
    {% aaccopen [exercises_jump_answer_3] [Answer] %}
        When the player releases the jump key and he is still moving up, set its y velocity component to 0: <br><br>
        {{ exercises_jump_answer_3 | markdownify }}
    {% accclose %}
    <br>

    4. Having all this done, there's another problem: tapping the space key makes the player only jump slightly. Another thing that lots of platformers do
    is set a minimum jump height. How would you even do that?!? (<strong>hint</strong>: use the <a href="/documentation/timer">Timer</a> module)
    {% aaccopen [exercises_jump_answer_4] [Answer] %}
        This one is a bit more complicated, that's why it's the last exercise! There are certainly multiple ways of solving this problem, but this was the one I found.
        To add a minimum jump height we have to keep track of how long has it been since the player pressed the jump button and then only after a certain amount of time,
        let the player release the jump button. Of course, the player can actually release it before our time, but we have to make sure the actual physics body doesn't know this.
        To do this we add a .jump_press_time variable: when the jump key is pressed, this variable holds the time it was pressed. Then, when the jump key is released we take the
        difference between the current time and the time jump was pressed. If it's more than some threshold value, we stop jumping. This should be obvious: if the player is above
        our desired minimum height and he releases the jump key, he should stop jumping normally. The tricky condition comes if the player is below our minimum jump height (= the difference
        is less than our threshold): we have to make sure that the jump is only stopped after enough time has passed... This is done is line 20. <br><br>
        {{ exercises_jump_answer_4 | markdownify }}
    {% accclose %}
{% accclose %}
<br>

{% title Camera and Background %}

So far as the player moves in space, nothing else moves with him. We can fix that by using the [Camera](/documentation/camera) module.
The camera module has some advanced features that are of use to any game at all. Since we're using the {% text engine %}, we'll use instantiated camera
inside the World class to follow the player around:

~~~ lua
function Player:new(...)
    ...
    fg.world.camera:follow(self, {lerp = 1, follow_style = 'platformer'})
    ...
end
~~~

You can add {% text fg.world.camera.debug_draw = true %} to see the camera's debug drawing information. You should see some information about the follow style, lerp and lead values
as well as the camera's deadzone. For a platformer it's a thin but tall window around the player, meaning that if the player jumps the camera doesn't follow him directly as not to bother whoever
is watching the screen too much. Play around with different lerp and lead values, as well as tracking styles to see what they all do. More information about all of this can be found in the 
[Camera module page](/documentation/camera).

{% accopen [exercises_camera] [Exercises] %}
    1. Using fuccboiGDX's camera module, what are the basic concepts behind the implementation of most of the features presented in this video? (<strong>hint</strong>: 
    <a href="/documentation/camera#Attributes">Camera's attributes</a>)<br><br>
<div class="embed-video-container center"><iframe width="480" height="360" src="http://www.youtube.com/embed/aAKwZt3aXQM " frameborder="0" allowfullscreen=""></iframe></div>
<br>
    {% aaccopen [exercises_camera_answer_1] [Answer] %}
        Using tha Camera's .target attribute. To make the camera move/focus towards certain objects, calculate the middle point between the target objects (usually player + something else)
        and then set the .target attribute to that point every frame. That attribute usually takes an entire object, but it really only uses the .x and .y attributes, so you can simply pass
        a named table as well, like this: {x = (player.x + desired_target.x)/2, y = (player.y + desired_target.y)/2}. We can achieve the "leading" behavior for the rocket part near the end
        by playing with the .follow_lead attribute, which places the camera in front of the target based on its velocity. For a smooth camera movement we can play with the lerp value.
        For the player not leaving a certain area of the screen we can use custom deadzones.
    {% accclose %}
{% accclose %}
<br>

Now for the last part: backgrounds. So far the back of the screen is completely black, let's fix that by using these images:

{% img center /assets/bg-back.png %}
{% img center /assets/bg-mid.png %}

fuccboiGDX supports the creation of [Background](/documentation/background) objects, which are just images with {% text x, y %} attributes. The {% text engine %}
also uses the concepts of layers. Each layer has objects added to it, and then you can apply certain operations to each layer.
We wanna create two new layers with different parallax values, one for the back background
and one for the front one. After that, we wanna add both images in a position that covers most of our tilemap, like this:

~~~ lua
function Game:new()
    ...
    fg.world:addLayer('BG1', {parallax_scale = 0.8})
    fg.world:addToLayer('BG1', fg.Background(380, 260, love.graphics.newImage('bg-back.png')))
    fg.world:addLayer('BG2', {parallax_scale = 0.9})
    fg.world:addToLayer('BG2', fg.Background(440, 270, love.graphics.newImage('bg-mid.png')))
    fg.world:setLayerOrder({'BG1', 'BG2', 'Default'})
    ...
end
~~~

The {% number 0.8 %} and {% number 0.9 %} values correspond to that layer's parallax scale. Closer to {% number 1 %} means closer to the screen,
closer to {% number 0 %} means further away. The {% call :setLayerOrder %} method receives a table of strings, each string representing a layer name. It will then
save that table, so that when the drawing operations are done, it draws all layers according to the order specified. In this case, {% string 'BG1' %} is drawn first (because it's the back background),
then {% string 'BG2' %}, and then the {% string 'Default' %} layer where everything with an unspecified layer name goes to.
<br>

{% title The End %}

And that's it! We've covered quite a bit of functionality that fuccboiGDX provides. If you finished all the exercises you should also have a good idea on how to read fuccboiGDX's documentation
and how to figure out things for yourself. And you should also have a small game that plays something like this:

{% img center /assets/2dplatformer.gif %}

You can find the full source code the complete game [here](https://github.com/adonaac/fuccboiGDX-tutorials/tree/master/advanced/2DPlatformer).
