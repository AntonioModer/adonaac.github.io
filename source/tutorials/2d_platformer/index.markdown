---
layout: page
title: 2D Platformer 
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

This tutorial will teach you about some of the basic features of the Mogamett Engine through building a 2D platformer.

{% img center /assets/2dplatformer.gif %}

You should have the engine [downloaded](/downloads/mogamett.zip) and [setup](/snippets#main_template) properly.
<br><br>

<h3 id="player_creation" data-magellan-destination="player_creation">Player Creation</h3>

The first thing we're gonna do is create a basic Player class. Since we want to use the engine and get box2d physics out of the box,
we want it to be a physics entity. Using the [physics entity template](/snippets#physics_template), we get something like this:

~~~ lua
-- in Player.lua
Player = mg.class('Player', mg.Entity)
Player:include(mg.PhysicsBody)

function Player:init(world, x, y, settings)
    mg.Entity.init(self, world, x, y, settings)
    self:physicsBodyInit(world, x, y, settings)
end

function Player:update(dt)
    self:physicsBodyUpdate(dt)
end

function Player:draw()
    self:physicsBodyDraw()
end
~~~

To understand everything that's going on with that code: [Class](/documentation/class), [Collision](/documentation/collision), [Entity](/documentation/entity) and 
[PhysicsBody](/documentation/physicsbody). 

With that in mind, to spawn a player we do this:

~~~ lua
-- in main.lua
function love.load()
    mg = require ...

    require 'Player'

    mg.init()
    mg.world:createEntity('Player', 400, 300)
end
~~~

Exactly what's happening here is that every class you create with the <code class="text">mg.class</code> call can be spawned by the <code class="text">mg.world:createEntity</code> call, 
since that class gets automatically added to the engine (see more about this [here](/documentation/world#creation_methods)). If you run all the above you should see a blue square on the 
center of the screen. These are the player's physics body's debug drawing lines. You can turn off debug drawing by doing <code class="text">mg.debug_draw = false</code>.
<br><br>

<h3 id="animations_and_movement" data-magellan-destination="animations_and_movement">Animations and Movement</h3>

Squares aren't that interesting, though, so adding some visuals to the player would be nice. To do this we're gonna use the following sprite:

{% img center /assets/idle.png %}

Using the [Animation](/documentation/animation) module we can quickly create an animation from a spritesheet. In this case we have a single sprite, but it can
also be used for just loading single images:

~~~ lua
function Player:init(world, x, y, settings)
    mg.Entity.init(self, world, x, y, settings)
    self:physicsBodyInit(world, x, y, settings)

    self.idle = mg.Animation(love.graphics.newImage('idle.png'), 32, 32, 0)
end

function Player:update(dt)
    self:physicsBodyUpdate(dt)
    self.idle:update(dt)
end

function Player:draw()
    self.idle:draw(self.x - self.idle.frame_width/2, self.y - self.idle.frame_height/2)
end
~~~

LÖVE's draw function works by specifying the top left position of the image, so when we draw our animation we have to make sure to offset it by its width and height, since
positions are always the center of an object (at least if you're using the <code class="text">engine</code>). If you run the above you should see the player sprite on top of
blue square. 

<dl class="accordion" data-accordion>
<dd>
<a href="#panel1">Exercises</a>
<div id="panel1" class="content">
<ol>
    <li> The physics body of the player doesn't really match his sprite's width and height. How would you go about changing it so it does? (<strong>hint</strong>: 
         <a href="/documentation/physicsbody#methods">PhysicsBody constructor's settings</a>)
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel2">Answer</a>
        <div id="panel2" class="content answer">
            Something like:
            <br><br>
<div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
<a href="#n2" name="n2">2</a>
<a href="#n3" name="n3">3</a>
<a href="#n4" name="n4">4</a>
<a href="#n5" name="n5">5</a>
<a href="#n6" name="n6">6</a>
<a href="#n7" name="n7">7</a>
</pre></td>
  <td class="code"><pre><span class="comment">-- in main.lua</span>
mg.world:createEntity(<span class="string"><span class="delimiter">'</span><span class="string">Player</span><span class="delimiter">'</span></span>, <span class="integer">400</span>, <span class="integer">300</span>, <span class="map"><span class="delimiter">{</span><span class="key">w</span> = <span class="integer">16</span>, <span class="key">h</span> = <span class="integer">28</span><span class="delimiter">}</span></span>)

<span class="comment">-- in Player.lua</span>
<span class="keyword">function</span> Player:<span class="function">draw</span>()
    self.idle:draw(self.x - self.idle.frame_width/<span class="integer">2</span>, 
                   self.y - self.idle.frame_height/<span class="integer">2</span> - <span class="integer">2</span>)
<span class="keyword">end</span>
</pre></td>
</tr></table>
</div>
        </div>
        </dd>
        </dl>
        <br>
    </li>

    <li> What's another way of accessing an animation's width and height? (<strong>hint</strong>: 
         <a href="/documentation/animation#methods">Animation methods</a>)
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel3">Answer</a>
        <div id="panel3" class="content answer">
        For an animation, :getWidth/Height are the same as .frame_width/height:
        <br><br>
<div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
</pre></td>
  <td class="code"><pre>self.idle:draw(self.x - self.idle:getWidth()/<span class="integer">2</span>, self.y - self.idle:getHeight()/<span class="integer">2</span>)
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

Now that we have an image attached to our player body, we can try making it move. We're going to do this by using the [Input](/documentation/input) module. In a platformer, 
we mainly move left and right, so first let's bind those keys to actions:

~~~ lua
function Player:init(...)
    ...
    mg.input:bind('a', 'move_left')
    mg.input:bind('d', 'move_right')
    ...
end
~~~

And then we can check if that action is being pressed:

~~~ lua
function Player:update(dt)
    ...
    if mg.input:down('move_left') then

    end
    if mg.input:down('move_right') then

    end
    ...
end
~~~

To actually make the character move we just insert the movement code into each one of those <code class="text">ifs</code>. Since we're using box2d, making an object move has to
be done through its [Body](http://www.love2d.org/wiki/Body). A very misinformed argument that a lot of people make when talking about physics engines is that they seem to make games feel sluggish, slow
and with a lack of control. That is only true if you only move your bodies by applying forces to them. We're not going to do that! Instead, we'll set its velocity directly, using the 
<code class="atrm">:setLinearVelocity</code> call. In this way, you can do velocity and acceleration calculations yourself, and then only apply the final velocity to the body. 
This gives you as much control as you need over how an object moves. See more on this [here](http://www.iforce2d.net/b2dtut/constant-speed).

~~~ lua
function Player:update(dt)
    ...
    if mg.input:down('move_left') then
        local vx, vy = self.body:getLinearVelocity()
        self.body:setLinearVelocity(-150, vy)
    end
    if mg.input:down('move_right') then
        local vx, vy = self.body:getLinearVelocity()
        self.body:setLinearVelocity(150, vy)
    end
    ...
end
~~~~

Because we only want to set the x component, we first need to get the body's current velocity to use it on the component we don't want changed (in this case the y component). In any case,
if you run the above you'll notice that the player never stops moving to one side or the other. This is because you're setting the body's linear velocity to <code class="number">150</code> or
<code class="number">-150</code> and never decreasing it. To fix that, we add damping:

~~~ lua
function Player:update(dt)
    ...
    if mg.input:down('move_left') then
        local vx, vy = self.body:getLinearVelocity()
        self.body:setLinearVelocity(-150, vy)
    end
    if mg.input:down('move_right') then
        local vx, vy = self.body:getLinearVelocity()
        self.body:setLinearVelocity(150, vy)
    end
    if not mg.input:down('move_left') and not mg.input:down('move_right') then
        local vx, vy = self.body:getLinearVelocity()
        self.body:setLinearVelocity(0.8*vx, vy)
    end
    ...
end
~~~

What we're doing here is simply multiplying the player's x velocity by <code class="number">0.8</code> every frame if he's not moving left nor right. This gives it a nice stopping motion that isn't
too abrupt nor too slow. Different values will have different effects, for instance, <code class="number">0.95</code> will feel very slow, while <code class="number">0.5</code> will feel very abrupt.

Now that we have proper movement we could add a running animation:

{% img center /assets/run.png %}

And to load this animation:

~~~ lua
function Player:init(...)
    ...
    self.idle = mg.Animation(love.graphics.newImage('idle.png'), 32, 32, 0)
    self.run = mg.Animation(love.graphics.newImage('run.png'), 32, 32, 0.1)
end
~~~

The <code class="number">0.1</code> value is the amount of time passed between each frame change. For the velocity we have now (<code class="number">150</code>), this value feels pretty nice.

If you run the game, you'll notice nothing has changed, though. That's because you're neither updating the animation nor drawing it. But we have multiple animations now, how do we know when to 
update/draw each one? A way is adding a variable that will hold the current animation state, and change that state based on some criteria. Something like this:

~~~ lua
function Player:init(world, x, y, settings)
    ...
    self.animation_state = 'idle'
    self.idle = mg.Animation(love.graphics.newImage('idle.png'), 32, 32, 0)
    self.run = mg.Animation(love.graphics.newImage('run.png'), 32, 32, 0.1)
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
    self[self.animation_state]:draw(self.x - self[self.animation_state].frame_width/2, 
                                    self.y - self[self.animation_state].frame_height/2 - 2)
end
~~~

<code class="atrm">.animation_state</code> can either be <code class="string">'idle'</code> or <code class="string">'run'</code>, which are the same names as the ones we 
have for our variables holding the animations. This is why <code class="text">self[self.animation_state]</code> is a valid way of accessing the current animation. We set the
current animation by simply checking the player's x velocity: if it's lower than <code class="number">25</code> we set it to idle, otherwise the player's running.

<dl class="accordion" data-accordion>
<dd>
<a href="#panel4">Exercises</a>
<div id="panel4" class="content">
<ol>
    <li> So far the player can only look to the right. How would you change the code so that he's also capable of looking to the left? (<strong>hint</strong>: 
    create a variable named direction that can be either <code class="string">'left'</code> or <code class="string">'right'</code> and use <a href="http://www.love2d.org/wiki/love.graphics.draw">
    draw's scaling parameter</a> with -1 on the x component to flip the current image)

        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel5">Answer</a>
        <div id="panel5" class="content answer">
        The most interesting part of this is the flip. Whenever you scale something by -1 it flips around the point that thing is being drawn at, in this case,
        the top left of the sprite. Naturally, the character is mirrored around this point and therefore moves to the left. To fix this, instead of subtracting half the sprite's width, we add it.
        <br><br>
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
</pre></td>
  <td class="code"><pre><span class="keyword">function</span> Player:<span class="function">init</span>(...)
    ...
    self.direction = <span class="string"><span class="delimiter">'</span><span class="string">right</span><span class="delimiter">'</span></span>
    ...
<span class="keyword">end</span>

<span class="keyword">function</span> Player:<span class="function">update</span>(dt)
    ...
    <span class="keyword">if</span> mg.input:down(<span class="string"><span class="delimiter">'</span><span class="string">move_left</span><span class="delimiter">'</span></span>) <span class="keyword">then</span>
        self.direction = <span class="string"><span class="delimiter">'</span><span class="string">left</span><span class="delimiter">'</span></span>
        ...
    <span class="keyword">end</span>
    <span class="keyword">if</span> mg.input:down(<span class="string"><span class="delimiter">'</span><span class="string">move_right</span><span class="delimiter">'</span></span>) <span class="keyword">then</span>
        self.direction = <span class="string"><span class="delimiter">'</span><span class="string">right</span><span class="delimiter">'</span></span>
        ...
    <span class="keyword">end</span>
    ...
<span class="keyword">end</span>

<span class="keyword">function</span> Player:<span class="function">draw</span>()
    ...
    <span class="keyword">if</span> self.direction == <span class="string"><span class="delimiter">'</span><span class="string">right</span><span class="delimiter">'</span></span> <span class="keyword">then</span>
        self[self.animation_state]:draw(
            self.x - self[self.animation_state].frame_width/<span class="integer">2</span>, 
            self.y - self[self.animation_state].frame_height/<span class="integer">2</span> - <span class="integer">2</span>)
    <span class="keyword">else</span>
        self[self.animation_state]:draw(
            self.x + self[self.animation_state].frame_width/<span class="integer">2</span>, 
            self.y - self[self.animation_state].frame_height/<span class="integer">2</span> - <span class="integer">2</span>, 
            <span class="integer">0</span>, <span class="integer">-1</span>, <span class="integer">1</span>)
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

<h3 id="tilemap" data-magellan-destination="tilemap">Tilemap</h3>

We have a character that moves left and right, with animations and everything. But in a platformer we also need to be able to jump! But how to jump without gravity?
You can't. So we should add some gravity to the [physics world](http://www.love2d.org/wiki/World):

~~~ lua
-- in main.lua
function love.load()
    ...
    mg.world.world:setGravity(0, 20*32)
    ...
end
~~~

The character also looks pretty small on the screen. We can fix that by zooming the camera in:

~~~ lua
-- in main.lua
function love.load()
    ...
    mg.world.camera:zoomTo(2)
    ...
end
~~~

If you run the game now you'll see that the character looks bigger and that he falls down. But he falls offscreen! Since we added gravity, the world is just behaving like we told it to, however
there's nothing holding the character in place so he'll just keep falling forever. Something we can do to fix this is define a map. Using the [Tilemap](/documentation/tilemap) module, we can
create a tilemap that is able to collide with world objects pretty easily. The tileset we're going to use is this one:

{% img center /assets/tileset-normal.png %}

And the code to create the map:

~~~ lua
function love.load()
    ...
    tilemap = mg.Tilemap(400, 420, 32, 32, love.graphics.newImage('tiles.png'), {
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1},
        {1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1},
        {1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1},
        {1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1},
        {1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    }
    tilemap:setAutoTileRules({6, 14, 12, 2, 10, 8, 7, 15, 13, 3, 11, 9})
    tilemap:autoTile()
    mg.world:generateCollisionSolids(tilemap)
    mg.world:addToLayer('Default', tilemap)
    ...
end
~~~

If you can get the player to spawn inside the thingy, then you'll see that the player will collide with the map and not fall off the screen anymore.

<dl class="accordion" data-accordion>
<dd>
<a href="#panel6">Exercises</a>
<div id="panel6" class="content">
<ol>
    <li> Why is the tilemap only using 1s and 0s? What happens if you use other numbers? Which numbers can actually be used? And how does all this relate to the
    <code class="atrm">:autoTile</code> call and to the <code class="atrm">:setAutoTileRules</code> call? (<strong>hint</strong>: <a href="/documentation/tilemap">Tilemap</a> module)
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel7">Answer</a>
        <div id="panel7" class="content answer">
            The tilemap is only using 1s and 0s because the auto tile call will set the tiles automatically based on the auto tile rules. The possible values are however
            many tiles your tileset has, in this case it's 12. Any value other than 0 will be recognized as an active tile and changed by the :autoTile call. If that call isn't made
            then the numbers will correspond to whatever tile has that number from the tileset. The numbers from the tileset are read in a top-down, left-right manner. So top left is 1,
            top right is 6, bottom left is 7 and bottom right is 12.
        </div>
        </dd>
        </dl>
    </li>
    <br>

    <li> What does the <code class="atrm">:generateCollisionSolids</code> method do? (<strong>hint</strong>: <a href="/documentation/world#tilemap_methods">World's tilemap methods</a>)
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel8">Answer</a>
        <div id="panel8" class="content answer">
            It automatically generates world collision solids based on the collision data from the tilemap. Collision data is generated by default to match all non 0 tiles, but can
            be changed using the :setCollisionData method.
            See <a href="/documentation/tilemap">Tilemap</a> and <a href="/documentation/world#tilemap_methods">World's tilemap methods</a>. 
        </div>
        </dd>
        </dl>
    </li>
</ol>
</div>
</dd>
</dl>
<br>

<h3 id="jump" data-magellan-destination="jump">Jump!</h3>

Now that we have gravity in, we can add the jump. Jumping is actually fairly simple... Since we're using box2d all we have to do is set the y velocity component to a negative value and the body 
will go up in the air; gravity will pull the body down, so you get a pretty decent jump arc effortlessly:

~~~ lua
function Player:init(...)
    ...
    mg.input:bind(' ', 'jump')
    ...
end

function Player:update(dt)
    ...
    if mg.input:pressed('jump') then
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
is adding a <code class="atrm">.jumping</code> boolean. Whenever the player presses the jump button we set this to true, and then set the animation based on if this is true or not.
If the player is falling (y velocity > 0), then we set the animation to be the falling one instead. This can all be done like this:

~~~ lua
function Player:init(...)
    ...
    self.jumping = false
    self.jump = mg.Animation(love.graphics.newImage('jump.png'), 32, 32, 0)
    self.fall = mg.Animation(love.graphics.newImage('fall.png'), 32, 32, 0)
    ...
end

function Player:update(dt)
    ...
    if mg.input:pressed('jump') then
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

Running this, you'll notice one problem: after the player jumps he never changes to another animation. This happens because <code class="atrm">self.jumping</code> is set to true but never
set to false again. We want to set it to false when the player hits the ground. To do that, we'll use Mogamett's [Collision](/documentation/collision) system. First, set the player to
generate a collision callback whenever he enters collision with a [Solid](/documentation/solid):

~~~ lua
Player = mg.class('Player', mg.Entity)
Player:include(mg.PhysicsBody)

Player.static.enter = {'Solid'}

function Player:init(...)
...
~~~

Then, we define the collision callback function and set the jumping boolean to false whenever the collided object is a Solid:

~~~ lua
function Player:onCollisionEnter(object, contact)
    if object.class.name == 'Solid' then
        self.jumping = false
    end
end
~~~

And now whenever you jump, the jumping boolean is set to true, and then whenever you enter contact with a solid again (in a jump this usually happens when you hit the ground again)
it will be set to false and the animation state can go back to normal.

Another simple problem that happens and has to do with jumping: if you keep pressing the movement key near a wall you'll get stuck midair. This has to do with how box2d handles its
object's friction. It can be easily fixed by doing:

~~~ lua
function Player:init(...)
    mg.Entity.init(self, world, x, y, settings)
    self:physicsBodyInit(world, x, y, settings)

    self.fixture:setFriction(0)
    ...
end
~~~

Objects with 0 friction will always slide and not get stuck on each other. I really recommend reading [box2d's manual](http://www.box2d.org/manual.html) 
as well as most tutorials [here](http://www.iforce2d.net/b2dtut/) to learn how box2d behaves better.

<dl class="accordion" data-accordion>
<dd>
<a href="#panel9">Exercises</a>
<div id="panel9" class="content">
<ol>
    <li> If you press space multiple times, the player will jump multiple times. How would you go about limitting the number of jumps the player can perform? 
    (<strong>hint</strong>: create a <code class="atrm">.max_jumps</code> variable and a <code class="atrm">.jumps_left</code> variable)
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel10">Answer</a>
        <div id="panel10" class="content answer">
            The .max_jumps variable has the maximum number of jumps the player can perform. Set it to 1. The .jumps_left variable initially has the maximum number of jumps, which is also 1.
            When the player jumps, decrease the .jumps_left variable, and before each jump add a check to see if the number of jumps left is higher than 1.
            When the player reaches the ground, set the .jumps_left variable to .max_jumps, since the player needs to be able to jump again.
            <br><br>
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
  <td class="code"><pre><span class="keyword">function</span> Player:<span class="function">init</span>(...)
    ...
    self.max_jumps = <span class="integer">1</span>
    self.jumps_left = self.max_jumps
    ...
<span class="keyword">end</span>

<span class="keyword">function</span> Player:<span class="function">update</span>(dt)
    ...
    <span class="keyword">if</span> mg.input:pressed(<span class="string"><span class="delimiter">'</span><span class="string">jump</span><span class="delimiter">'</span></span>) <span class="keyword">then</span>
        <span class="keyword">if</span> self.jumps_left &gt; <span class="integer">0</span> <span class="keyword">then</span>
            <span class="keyword">local</span> <span class="local-variable">vx</span>, <span class="local-variable">vy</span> = self.body:getLinearVelocity()
            self.body:setLinearVelocity(vx, <span class="integer">-250</span>)
            self.jumping = <span class="predefined-constant">true</span>
            self.jumps_left = self.jumps_left - <span class="integer">1</span>
        <span class="keyword">end</span>
    <span class="keyword">end</span>
    ...
<span class="keyword">end</span>

<span class="keyword">function</span> Player:<span class="function">onCollisionEnter</span>(object, contact)
    <span class="keyword">if</span> object.class.name == <span class="string"><span class="delimiter">'</span><span class="string">Solid</span><span class="delimiter">'</span></span> <span class="keyword">then</span>
        self.jumping = <span class="predefined-constant">false</span>
        self.jumps_left = self.max_jumps
    <span class="keyword">end</span>
<span class="keyword">end</span>
</pre></td>
</tr></table>
</div>
            With this setup you can easily create double or triple jumps. Simply set the .max_jumps variable to 2 or 3. :-)
        </div>
        </dd>
        </dl>
    </li>
    <br>

    <li> You'll notice that jumping and hitting a Solid (like the sides of the map) before you start falling changes your animation. This happens because the jumping boolean
    is set to false whenever you hit any Solid, its position not being accounted for. How would you fix this so that the animation only gets reset when you hit solids below you?

        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel11">Answer</a>
        <div id="panel11" class="content answer">

        Check the player's bottom position with the solid's top position, if it's less, then the player is above the ground.
        <br><br>
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
</pre></td>
  <td class="code"><pre><span class="keyword">function</span> Player:<span class="function">onCollisionEnter</span>(object, contact)
    <span class="keyword">if</span> object.class.name == <span class="string"><span class="delimiter">'</span><span class="string">Solid</span><span class="delimiter">'</span></span> <span class="keyword">then</span>
        <span class="keyword">local</span> <span class="local-variable">solid_top</span> = object.y - object.h/<span class="integer">2</span>
        <span class="keyword">local</span> <span class="local-variable">player_bottom</span> = self.y + self.h/<span class="integer">2</span> - <span class="integer">4</span>
        <span class="keyword">if</span> solid_top &gt; player_bottom <span class="keyword">then</span>
            self.jumping = <span class="predefined-constant">false</span>
            self.jumps_left = self.max_jumps
        <span class="keyword">end</span>
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

    <li> Right now when the player jumps he never stops midair. Something that lots of platformers do is let the player control the jump height a bit. 
    How would you do this? (<strong>hint</strong>: use mg.input:released)

        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel12">Answer</a>
        <div id="panel12" class="content answer">
            When the player releases the jump key and he is still moving up, set its y velocity component to 0: 
            <br><br>
<div><table class="CodeRay"><tr>
  <td class="line-numbers"><pre><a href="#n1" name="n1">1</a>
<a href="#n2" name="n2">2</a>
<a href="#n3" name="n3">3</a>
<a href="#n4" name="n4">4</a>
<a href="#n5" name="n5">5</a>
<a href="#n6" name="n6">6</a>
<a href="#n7" name="n7">7</a>
</pre></td>
  <td class="code"><pre><span class="keyword">function</span> Player:<span class="function">update</span>(dt)
    ...
    <span class="keyword">if</span> mg.input:released(<span class="string"><span class="delimiter">'</span><span class="string">jump</span><span class="delimiter">'</span></span>) <span class="keyword">then</span>
        <span class="keyword">local</span> <span class="local-variable">vx</span>, <span class="local-variable">vy</span> = self.body:getLinearVelocity()
        <span class="keyword">if</span> vy &lt; <span class="integer">0</span> <span class="keyword">then</span> self.body:setLinearVelocity(vx, <span class="integer">0</span>) <span class="keyword">end</span>
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

    <li> Having all this done, there's another problem: tapping the space key makes the player only jump slightly. Another thing that lots of platformers do
    is set a minimum jump height. How would you even do that? (<strong>hint</strong>: use the <a href="/documentation/timer">Timer</a> module)

        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel13">Answer</a>
        <div id="panel13" class="content answer">

        This one is a bit more complicated, that's why it's the last exercise! There are certainly multiple ways of solving this problem, but this was the one I found.
        To add a minimum jump height we have to keep track of how long has it been since the player pressed the jump button and then only after a certain amount of time,
        let the player release the jump button. Of course, the player can actually release it before our time, but we have to make sure the actual physics body doesn't know this.
        To do this we add a .jump_press_time variable: when the jump key is pressed, this variable holds the time it was pressed. Then, when the jump key is released we take the
        difference between the current time and the time jump was pressed. If it's more than some threshold value, we stop jumping. This should be obvious: if the player is above
        our desired minimum height and he releases the jump key, he should stop jumping normally. The tricky condition comes if the player is below our minimum jump height (= the difference
        is less than our threshold): we have to make sure that the jump is only stopped after enough time has passed... This is done is line 21.
        <br><br>


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
</pre></td>
  <td class="code"><pre><span class="keyword">function</span> Player:<span class="function">update</span>(dt)
    ...
    <span class="keyword">if</span> mg.input:pressed(<span class="string"><span class="delimiter">'</span><span class="string">jump</span><span class="delimiter">'</span></span>) <span class="keyword">then</span>
        <span class="keyword">if</span> self.jumps_left &gt; <span class="integer">0</span> <span class="keyword">then</span>
            <span class="keyword">local</span> <span class="local-variable">vx</span>, <span class="local-variable">vy</span> = self.body:getLinearVelocity()
            self.body:setLinearVelocity(vx, <span class="integer">-250</span>)
            self.jumping = <span class="predefined-constant">true</span>
            self.jumps_left = self.jumps_left - <span class="integer">1</span>
            self.jump_press_time = love.timer.getTime()
        <span class="keyword">end</span>
    <span class="keyword">end</span>
    ...
    <span class="keyword">if</span> mg.input:released(<span class="string"><span class="delimiter">'</span><span class="string">jump</span><span class="delimiter">'</span></span>) <span class="keyword">then</span>
        <span class="keyword">local</span> <span class="local-variable">stopJump</span> = <span class="keyword">function</span>()
            self.jump_press_time = <span class="integer">0</span>
            <span class="keyword">local</span> <span class="local-variable">vx</span>, <span class="local-variable">vy</span> = self.body:getLinearVelocity()
            <span class="keyword">if</span> vy &lt; <span class="integer">0</span> <span class="keyword">then</span> self.body:setLinearVelocity(vx, <span class="integer">0</span>) <span class="keyword">end</span>
        <span class="keyword">end</span>
        <span class="keyword">local</span> <span class="local-variable">dt</span> = love.timer.getTime() - self.jump_press_time
        <span class="keyword">if</span> dt &gt;= <span class="float">0.125</span> <span class="keyword">then</span> stopJump()
        <span class="keyword">else</span> mg.timer:after(<span class="float">0.125</span> - dt, <span class="keyword">function</span>() stopJump() <span class="keyword">end</span>) <span class="keyword">end</span>
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

<h3 id="camera_and_background" data-magellan-destination="camera_and_background">Camera and Background</h3>

So far as the player moves in space, nothing else moves with him. We can fix that by using the [Camera](/documentation/camera) module.
The camera module has some advanced features that are of use to any game at all. Since we're using the <code class="text">engine</code>, we'll use instantiated camera
inside the World class to follow the player around:

~~~ lua
function Player:init(...)
    ...
    mg.world.camera:follow(self, {lerp = 1, follow_style = 'platformer'})
    ...
end
~~~

You can add <code class="text">mg.world.camera.debug_draw = true</code> to see the camera's debug drawing information. You should see some information about the follow style, lerp and lead values
as well as the camera's deadzone. For a platformer it's a thin but tall window around the player, meaning that if the player jumps the camera doesn't follow him directly as not to bother whoever
is watching the screen too much. Play around with different lerp and lead values, as well as tracking styles to see what they all do. More information about all of this can be found in the 
[Camera module page](/documentation/camera).

<dl class="accordion" data-accordion>
<dd>
<a href="#panel14">Exercises</a>
<div id="panel14" class="content">
<ol>
    <li> Using Mogamett's camera module, what are the basic concepts behind the implementation of most of the features presented in this video? (<strong>hint</strong>: 
    <a href="/documentation/camera#attributes">Camera's attributes</a>)<br><br>
<div class="embed-video-container center"><iframe width="480" height="360" src="http://www.youtube.com/embed/aAKwZt3aXQM " frameborder="0" allowfullscreen=""></iframe></div>
<br>
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel15">Answer</a>
        <div id="panel15" class="content answer">
        Using tha Camera's .target attribute. To make the camera move/focus towards certain objects, calculate the middle point between the target objects (usually player + something else)
        and then set the .target attribute to that point every frame. That attribute usually takes an entire object, but it really only uses the .x and .y attributes, so you can simply pass
        a named table as well, like this: {x = (player.x + desired_target.x)/2, y = (player.y + desired_target.y)/2}. We can achieve the "leading" behavior for the rocket part near the end
        by playing with the .follow_lead attribute, which places the camera in front of the target based on its velocity. For a smooth camera movement we can play with the lerp value.
        For the player not leaving a certain area of the screen we can use custom deadzones.
        </div>
        </dd>
        </dl>
    </li>
</ol>
</div>
</dd>
</dl>
<br>

Now for the last part: backgrounds. So far the back of the screen is completely black, let's fix that by using these images:

{% img center /assets/bg-back.png %}
{% img center /assets/bg-mid.png %}

Mogamett supports the creation of [Background](/documentation/background) objects, which are just images with <code class="atrm">.x, .y</code> attributes. The <code class="text">engine</code>
also uses the concepts of layers. Each layer has objects added to it, and then you can apply certain operations to each layer. So far you can only set their draw order and parallax value, 
but in the future things like applying certain shaders to certain layers will be possible. In any case, we wanna create two new layers with different parallax values, one for the back background
and one for the front one. After that, we wanna add both images in a position that covers most of our tilemap, like this:

~~~ lua
function love.load()
    ...
    mg.world:addLayer('BG1', 0.8)
    mg.world:addToLayer('BG1', mg.Background(320, 300, love.graphics.newImage('bg_back.png')))
    mg.world:addLayer('BG2', 0.9)
    mg.world:addToLayer('BG2', mg.Background(320, 320, love.graphics.newImage('bg_mid.png')))
    mg.world:setLayerOrder({'BG1', 'BG2', 'Default'})
    ...
end
~~~

The <code class="number">0.8</code> and <code class="number">0.9</code> values correspond to that layer's parallax scale. Closer to <code class="number">1</code> means closer to the screen,
closer to <code class="number">0</code> means further away. The <code class="atrm">:setLayerOrder</code> method receives a table of string, each string representing a layer name. It will then
save that table, so that when the drawing operations are done, it draw the layers according to it. In this case, <code class="string">'BG1'</code> is drawn first (because it's the back background),
then <code class="string">'BG2'</code>, and then the <code class="string">'Default'</code> layer where everything with an unspecified layer name goes to.

<dl class="accordion" data-accordion>
<dd>
<a href="#panel18">Exercises</a>
<div id="panel18" class="content">
<ol>
    <li> Add multiple backgrounds offset perfectly (without one image being drawn on top of another) so that the black universe behind it all can't ever be seen.
        <dl class="accordion" data-accordion>
        <dd>
        <a href="#panel19">Answer</a>
        <div id="panel19" class="content answer">
        The background's width is 640 and height is 308, so other backgrounds have to be offset by those amounts in different directions.<br><br>
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
</pre></td>
  <td class="code"><pre><span class="keyword">function</span> love.<span class="function">load</span>()
    ...
    bg_back = love.graphics.newImage(<span class="string"><span class="delimiter">'</span><span class="string">bg_back.png</span><span class="delimiter">'</span></span>)
    bg_mid = love.graphics.newImage(<span class="string"><span class="delimiter">'</span><span class="string">bg_mid.png</span><span class="delimiter">'</span></span>)
    mg.world:addLayer(<span class="string"><span class="delimiter">'</span><span class="string">BG1</span><span class="delimiter">'</span></span>, <span class="float">0.8</span>)
    mg.world:addToLayer(<span class="string"><span class="delimiter">'</span><span class="string">BG1</span><span class="delimiter">'</span></span>, mg.Background(<span class="integer">-320</span>, <span class="integer">300</span>, bg_back))
    mg.world:addToLayer(<span class="string"><span class="delimiter">'</span><span class="string">BG1</span><span class="delimiter">'</span></span>, mg.Background(<span class="integer">320</span>, <span class="integer">300</span>, bg_back))
    mg.world:addToLayer(<span class="string"><span class="delimiter">'</span><span class="string">BG1</span><span class="delimiter">'</span></span>, mg.Background(<span class="integer">960</span>, <span class="integer">300</span>, bg_back))
    mg.world:addToLayer(<span class="string"><span class="delimiter">'</span><span class="string">BG1</span><span class="delimiter">'</span></span>, mg.Background(<span class="integer">-320</span>, <span class="integer">608</span>, bg_back))
    mg.world:addToLayer(<span class="string"><span class="delimiter">'</span><span class="string">BG1</span><span class="delimiter">'</span></span>, mg.Background(<span class="integer">320</span>, <span class="integer">608</span>, bg_back))
    mg.world:addToLayer(<span class="string"><span class="delimiter">'</span><span class="string">BG1</span><span class="delimiter">'</span></span>, mg.Background(<span class="integer">960</span>, <span class="integer">608</span>, bg_back))
    mg.world:addLayer(<span class="string"><span class="delimiter">'</span><span class="string">BG2</span><span class="delimiter">'</span></span>, <span class="float">0.9</span>)
    mg.world:addToLayer(<span class="string"><span class="delimiter">'</span><span class="string">BG2</span><span class="delimiter">'</span></span>, mg.Background(<span class="integer">-320</span>, <span class="integer">320</span>, bg_mid))
    mg.world:addToLayer(<span class="string"><span class="delimiter">'</span><span class="string">BG2</span><span class="delimiter">'</span></span>, mg.Background(<span class="integer">320</span>, <span class="integer">320</span>, bg_mid))
    mg.world:addToLayer(<span class="string"><span class="delimiter">'</span><span class="string">BG2</span><span class="delimiter">'</span></span>, mg.Background(<span class="integer">960</span>, <span class="integer">320</span>, bg_mid))
    mg.world:addToLayer(<span class="string"><span class="delimiter">'</span><span class="string">BG2</span><span class="delimiter">'</span></span>, mg.Background(<span class="integer">-320</span>, <span class="integer">628</span>, bg_mid))
    mg.world:addToLayer(<span class="string"><span class="delimiter">'</span><span class="string">BG2</span><span class="delimiter">'</span></span>, mg.Background(<span class="integer">320</span>, <span class="integer">628</span>, bg_mid))
    mg.world:addToLayer(<span class="string"><span class="delimiter">'</span><span class="string">BG2</span><span class="delimiter">'</span></span>, mg.Background(<span class="integer">960</span>, <span class="integer">628</span>, bg_mid))
    mg.world:setLayerOrder(<span class="map"><span class="delimiter">{</span><span class="string"><span class="delimiter">'</span><span class="string">BG1</span><span class="delimiter">'</span></span>, <span class="string"><span class="delimiter">'</span><span class="string">BG2</span><span class="delimiter">'</span></span>, <span class="string"><span class="delimiter">'</span><span class="string">Default</span><span class="delimiter">'</span></span><span class="delimiter">}</span></span>)
<span class="keyword">end</span>
</pre></td>
</tr></table>
</div>
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

<h3 id="the_end" data-magellan-destination="the_end">The End</h3>

And that's it! We've covered quite a bit of functionality that Mogamett provides. If you finished all the exercises you should also have a good idea on how to read Mogamett's documentation
and how to figure out things for yourself. And you should also have a small game that plays something like this:

{% img center /assets/2dplatformer.gif %}
