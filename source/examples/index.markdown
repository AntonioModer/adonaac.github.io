---
layout: page
title: examples 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Animation %}

[Animation](documentation/animation)

{% title2 Animation from Spritesheet %}

Loads an animation from a spritesheet:

~~~ lua
-- parameters: sprite sheet, frame width, frame height, animation delay in seconds
animation = fg.Animation(love.graphics.newImage('spritesheet.png'), 32, 32, 0.1)
animation:update(dt)
animation:draw(x, y)
~~~

{% title2 Animation from Texture Atlas %}

Loads an animation from a texture atlas:

~~~ lua
-- parameters: texture atlas, starting x, y position (top-left corner of the first frame) 
--             of the animation on the atlas, frame width, frame height, animation delay, number of frames
animation = fg.Animation(love.graphics.newImage('textureatlas.png'), 128, 64, 32, 32, 0.1, 8)
animation:update(dt)
animation:draw(x, y)
~~~

{% title2 Changing an Animation's Delay %}

Changes an animation's delay for all of its frames:

~~~ lua
-- where new delay is some number in seconds
for i = 1, animation.size do
    animation:setDelay(i, new_delay)
end
~~~
<br><br>

{% title Area %}

[Area](documentation/area)

{% title2 Creating an Area %}

Creates an area, which is a level/world where everything happens:

~~~ lua
-- parameters: area name, x, y position (top-left corner) of the area
fg.world:createArea('New_Area', 0, 0)
~~~

{% title2 Activating an Area %}

Activates an area, enabling its updating and drawing:

~~~ lua
fg.world.areas['New_Area']:activate()
~~~

{% title2 Deactivating an Area %}

Deactivates an area, disabling its updating and drawing:

~~~ lua
fg.world.areas['New_Area']:deactivate()
~~~
<br><br>

{% title Camera %}

[Camera](documentation/camera)

{% title2 Camera Following %}

~~~ lua
-- parameters: the target being a table with .x, .y fields, 
--             a table with follow style, lerp and lead settings
fg.world.camera:follow(player, {follow_style = 'lockon', lerp = 1, lead = {x = 2, y = 0}})
~~~

{% title2 Camera Shake %}

~~~ lua
-- parameters: intensity in pixels, duration in seconds
fg.world.camera:shake(5 0.5)
~~~
<br><br>

{% title Collision %}

[Collision](documentation/collision), [PhysicsBody](documentation/physicsbody)

{% title2 Physics Collisions %}

A physics enabled entity that collides with other physics enabled entities of class {% string 'OtherClass1' %} and {% string 'OtherClass2' %}. 
The {% text onCollisionEnter %} method gets called whenever one of the objects from those classes enters a collision with this one.

~~~ lua
local Player = fg.Class('Player', 'Entity')
Player:implement(fg.PhysicsBody)

Player.enter = {'OtherClass1', 'OtherClass2'}

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

function Player:onCollisionEnter(other, contact)
    if other.tag == 'OtherClass1' then
        print('Collided with ' .. other.object)
    elseif other.tag == 'OtherClass2' then
        print('Collided with ' .. other.object)
    end
end
~~~
<br><br>

{% title Gamestate %}

[Gamestate](documentation/gamestate)

{% title2 Gamestate Changing %}

Changes between menu and game gamestates:

~~~ lua
-- in Game.lua
function Game:enter()
    print('Entered game state!')
end

-- in Menu.lua
function Menu:enter()
    print('Entered menu state!')
end

-- in main.lua
function love.load()
    ... 
    game = Game()
    menu = Menu()

    fg.Gamestate.registerEvents()
    fg.Gamestate.switch(menu) --> 'Entered menu state!'
    fg.Gamestate.switch(game) --> 'Entered game state!'
end
~~~
<br><br>

{% title Input %}

[Input](documentation/input)

{% title2 Input %}

Handling input normally:

~~~ lua
function Game:new()
    -- parameters: the key constant, the action name
    fg.input:bind('a', 'print_stuff')
    fg.input:bind('o', 'print_stuff')
    -- if the action name is a function (an action) then that
    -- will get called whenever the key constant is pressed
    fg.input:bind('f1', function() love.event.push('q') end)
end

function Game:update(dt)
    if fg.input:pressed('print_stuff') then
        print('stuff only on the pressed frame')
    end
    if fg.input:down('print_stuff') then
        print('stuff as long as a or o is held down')
    end
end
~~~

{% title2 Gamepad Input %}

Handling gamepad input:

~~~ lua
function Game:new()
    fg.input:bind('s', 'down')
    fg.input:bind('dpdown', 'down')
    fg.input:bind('leftx', 'horizontal')
end

function Game:update(dt)
    if fg.input:down('down') then
        print('dpads down key or the s key are being held')
    end
    -- Some gamepad keys return values from -1 to 1 or from 0 to 1,
    -- in those cases you need to check for a value instead of a boolean:
    if fg.input:down('horizontal') < 0 then
        print('left stick is being held to the left')
    else print('left stick is being held to the right') end
end
~~~
<br><br>

{% title Layers %}

[Layer](documentation/render#Layer)

{% title2 Creating a Layer %}

Creates a new layer:

~~~ lua
fg.world:addLayer('New_Layer', {parallax_scale = 1})
~~~

{% title2 Object to Layer %}

Adds an object to a layer. Objects created with the {% text fg.Class %} call are automatically
added to the {% string 'Default' %} layer if no {% text .layer %} class or instance attribute is defined.

~~~ lua
fg.world:addToLayer('New_Layer', object)
~~~

{% title2 Shader to Layer %}

Adds a shader to a layer and sends information to it:

~~~ lua
-- parameters: layer name, shader name, shader vertex path, shader fragment path
fg.world:addShaderToLayer('New_Layer', 'Outline', 'resources/shaders/default.vert', 'resources/shaders/outline.frag')

-- in some update function
-- parameters: layer name, shader name, variable name, value
fg.world:sendToShader('New_Layer', 'Outline', 'thickness', 2)
~~~

{% title2 Sorting Layers %}

You can specifiy how layers are sorted between themselves (i.e. layer 1 is drawn before layer 2, and therefore all objects in layer 1 are 
drawn before all objects in layer 2) as well as how the objects inside each layer are sorted.

~~~ lua
-- Sorts layers between themselves
-- parameters: a table of layer names
fg.world:setLayerOrder({'Back', 'Middle', 'Default', 'Front', 'Effects'})

-- Sorts objects inside a layer
-- in some update function
-- parameters: layer name, ordering function 
fg.world:sortLayerRenderOrder('New_Layer', function(a, b) return a.y < b.y end)
~~~
<br><br>

{% title Loading %}

[Loader](documentation/loader)

{% title2 Loading Resources with LÖVE %}

~~~ lua
image = love.graphics.newImage('image.png')
sound = love.audio.newSource('sound.ogg')
~~~

{% title2 Loading Resources with Loader %}

~~~ lua
function Game:new()
    -- parameters: table to hold assets, asset name, asset path
    fg.Loader.newImage(fg.Assets, 'image', 'image.png')
    fg.Loader.newSource(fg.Assets, 'sound', 'sound.png')

    local finished_loading = false
    fg.Loader.start(function()
        finished_loading = true
        -- Do things after everything's been loaded
    end)
end

function Game:update(dt)
    if finished_loading then 
        -- update your game
    else
        -- load all assets into fg.Assets, doing it over multiple frames
        fg.Loader.update()
        print('% loaded = ' .. fg.Loader.loadedCount/fg.Loader.resourceCount)
    end
end
~~~
<br><br>

{% title Objects %}

[Area](documentation/area), [Class](documentation/class), [Entity](documentation/entity), [World](documentation/world)

{% title2 Creating a Normal Class %}

~~~ lua
MyClass = fg.Object:extend('MyClass')

function MyClass:new()

end
~~~

{% title2 Creating an Engine Class  %}

~~~ lua
MyClass = fg.Class('MyClass', 'Entity')

function MyClass:new(area, x, y, settings)
    MyClass.super.new(self, area, x, y, settings)
end

function MyClass:update(dt)

end

function MyClass:draw()

end
~~~

{% title2 Creating a Physics Enabled Class  %}

~~~ lua
MyClass = fg.Class('MyClass', 'Entity')
MyClass:implement(fg.PhysicsBody)

function MyClass:new(area, x, y, settings)
    MyClass.super.new(self, area, x, y, settings)
    self:physicsBodyNew(area, x, y, settings)
end

function MyClass:update(dt)
    self:physicsBodyUpdate(dt)
end

function MyClass:draw()
    self:physicsBodyDraw()
end
~~~

{% title2 Creating an Engine Object %}

Creates a new entity of type {% string 'MyClass' %} with {% text .x = 0, .y = 0, .attribute_1 = 1, .attribute_2 = 4 %}:

~~~ lua
fg.world:createEntity('MyClass', 0, 0, {attribute_1 = 1, attribute_2 = 4})
~~~

Creates a new entity of type {% string 'MyClass' %} and returns it immediately. Usually you don't need to take care
of engine objects manually because the engine does all updating/drawing/destroying/etc for you, but sometimes
this is needed for various random reasons. Physics enabled entities **CAN'T** be created with this call or several bugs
may happen. See the [PhysicsBody](documentation/physicsbody), [Area](documentation/area) and [World](documentation/world) sections
for more information.

~~~ lua
object = fg.world:createEntityImmediate('MyClass', 0, 0, {attribute_1 = 1, attribute_2 = 4})
~~~

{% title2 Destroying Objects %}

To destroy an object just set the {% text .dead %} attribute to true and the object will be deleted
and removed from the engine at the end of the current frame.

~~~ lua
-- somewhere in MyClass.lua
self.dead = true
~~~

{% title2 Getting Specific Objects from an Area %}

Gets all entities that the {% text .attack_state %} attribute set to {% string 'ranged super laser beem' %}:

~~~ lua
-- parameters are: key to look for, value in that key to look for
entities = fg.world:getEntitiesBy('attack_state', 'ranged super laser beem')
~~~

Gets all entities that satisfy the condition of having less than {% number 5 %} on the {% text .hp %} attribute:

~~~ lua
entities = fg.world:getEntitiesWhere(function(object) if object.hp < 5 then return true end end)
~~~

{% title2 Object Parenting %}

To pass a reference of yourself to a child object, adding a reference to {% text self %} when creating it does the job:

~~~ lua
-- somewhere in Player.lua
fg.world:createEntity('Projectile', self.x, self.y, {velocity = 100, angle = self.angle, player_reference = self})

-- somewhere in Projectile.lua
-- kills the projectile if the parent is dead
if self.player_reference.dead then 
    self.dead = true
end
~~~
<br><br>

{% title Particles %}

[Particles](documentation/particles)

{% title2 Spawning Particles %}

Provided you've already created the {% text ExplosionParticles.lua %} file on the particles editor (as described [here](/documentation/particles#Description)):

~~~ lua
-- parameters: particle system name, x, y position
fg.world:spawnParticles('ExplosionParticles', 400, 400)
~~~

{% title2 Manual Particles %}

You can also not use the editor and create particles manually. In this example we create a {% text Particles %} class and then we spawn it:

~~~ lua
-- in Particles.lua
local Particles = fg.Class('Particles', 'Entity')

function Particles:new(area, x, y, settings)
    Particles.super.new(self, area, x, y, settings)

    local settings = settings or {}
    self.velocity = settings.velocity or math.random(50, 150)
    self.angle = settings.angle or math.random(0, 2*math.pi)

    self.radius = self.area.fg.utils.math.random(2, 6)

    self.timer = self.area.fg.Timer()
    local r = self.area.fg.utils.math.random(0.5, 1)
    -- Decrease the velocity of the particle over 0.5-1 seconds
    self.timer:tween(r, self, {velocity = 0}, 'in-out-cubic')
    -- Decrease the radius of the particle over 0.5-1 seconds
    self.timer:tween(r, self, {radius = 0}, 'in-out-cubic')
    -- Kill the particle after it reaches 0 velocity
    self.timer:after(r, function() self.dead = true end)
end

function Particles:update(dt)
    self.timer:update(dt)
    self.x = self.x + self.velocity*math.cos(self.angle)*dt
    self.y = self.y + self.velocity*math.sin(self.angle)*dt
end

function Particles:draw()
    love.graphics.circle('fill', self.x, self.y, self.radius)
end

-- in Projectile.lua
function Projectile:onCollisionEnter(other, contact)
    if other.tag == 'Solid' then
        for i = 1, 8 do
            fg.world:createEntity('Particles', self.x, self.y, 
                                 {velocity = math.random(100, 200), 
                                  angle = math.random(0, 2*math.pi)})
        end
    end
end
~~~
<br><br>

{% title Random %}

{% title2 Debug Drawing %}

Debug drawing modes are available through {% text fg.debug_draw %}. When set to true it will draw blue lines showing physics bodies:

~~~ lua
-- set the F1 key to toggle debug drawing
fg.input:bind('f1', function() fg.debug_draw = not fg.debug_draw end)
~~~

{% title Serialization %}

[Serial](documentation/serial)

{% title2 Save Method %}

All objects that want to be saved need to implement a {% call :save %} method that returns the information to be saved:

~~~ lua
function Player:save()
    return {
        x = self.x, y = self.y, w = self.h, h = self.h,
        hp = self.hp, modifiers = {speed = self.speed, damage = self.damage, range = self.range},
        items = {self.items[1].name, self.items[2].name, self.items[3].name},
    }
end
~~~

{% title2 Saving and Loading an Area %}

Entire areas can be saved and loaded through the {% call :saveArea %} and {% call :loadArea %} calls. When saving, only
objects that implement the {% call :save %} method will be saved:

~~~ lua
-- parameters: save filename, the area to save, classes that shouldn't be saved
fg.Serial:saveArea('save_filename', fg.world.areas['Level_1'], {'Player', 'Particles'})

-- parameters: save filename, the area to load objects to
fg.Serial:loadArea('save_filename', fg.world.areas['Level_1'])
~~~
<br><br>

{% title Shaders %}

[Render](documentation/render), [Shader](http://love2d.org/wiki/Shader)

{% title2 Applying Shaders to a Layer %}

~~~ lua
fg.world:addShaderToLayer('New_Layer', 'Outline', 'resources/shaders/default.vert', 'resources/shaders/outline.frag')
fg.world:sendToShader('New_Layer', 'Outline', 'thickness', 2)
~~~

{% title2 Applying Shaders in an Object %}

~~~ lua
function Player:new(...)
    ...
    self.some_shader = love.graphics.newShader('some_shader_path.frag')
end

function Player:draw()
    love.graphics.setShader(self.some_shader)
    love.graphics.draw(self.image, self.x, self.y)
    love.graphics.setShader()
end
~~~
<br><br>

{% title Sound %}

[Sound](documentation/sound)

{% title2 Playing a Sound %}

~~~ lua
fg.Sound.play('sound.ogg')
~~~
<br><br>

{% title Text %}

[Text](documentation/text)

{% title2 Programming Text %}

Makes the words {% text WAVES WAVES WAVES %} wavy and with an increasinly red color to the right.
See [Text](documentation/text) for more information.

~~~ lua
text = fg.Text('[WAVES WAVES WAVES](wavy; increasingRed)', {
    font = love.graphics.newFont('Super Cool Font.ttf', 60)
    increasingRed = function(dt, dc) love.graphics.setColor(c.position*10, 128, 128) end
    wavyInit = function(c) c.t = 0 end,
    wavy = function(dt, c)
        c.t = c.t + dt
        c.y = c.y + 100*math.cos(c.position/4 + 4*c.t)*dt
    end
})
~~~
<br><br>

{% title Tilemap %}

[Tilemap](documentation/tilemap)

{% title2 Loading a Tilemap with One Tileset %}

Loads a tilemap normally:

~~~ lua
-- parameters: x, y position of th etilemap, tile width, tile height, tileset image, tile grid
tilemap = fg.Tilemap(0, 0, 32, 32, love.graphics.newImage('tileset.png'), {
    {1, 1, 0, 0, 0, 0, 0, 1, 1, 1},
    {1, 1, 0, 0, 0, 0, 0, 1, 1, 1},
    {1, 1, 0, 1, 0, 0, 0, 1, 1, 1},
    {1, 1, 1, 1, 0, 0, 0, 1, 1, 1},
})
~~~

{% title2 Loading a Tilemap with Multiple Tilesets %}

Loads a tilemap that uses multiple images:

~~~ lua
-- parameters: x, y position of the tilemap, tile width, tile height, tileset image, tile grid
tilemap = fg.Tilemap(0, 0, 32, 32, {love.graphics.newImage('tileset_1.png'), 
                                    love.graphics.newImage('tileset_2.png')}, {
    {1, 1, 0, 0, 0, 0, 0, 1, 1, 1},
    {1, 1, 0, 0, 0, 0, 0, 1, 1, 1},
    {1, 1, 0, 1, 0, 0, 0, 1, 1, 1},
    {1, 1, 1, 1, 0, 0, 0, 1, 1, 1},
})
~~~

{% title2 Loading a Tiled Tilemap %}

Loads a tilemap from Tiled:

~~~ lua
-- parameters: x, y position of the tilemap, path to the lua file exported from Tiled
tilemap = fg.Tilemap(0, 0, 'maps/tiled_map')
~~~
<br><br>

{% title Timing %}

[HitFrameStop](documentation/area#hitFrameStopAdd), [Timer](documentation/timer), [Tween](documentation/timer#)

{% title2 Hit Frame Stop %}

Stops updating objects from certain classes for a few frames. Useful for doing effects where everything but a few animations
completely freeze before hitting something.

~~~ lua
-- parameters: number of frames to stop everything for, 
--             which classes to stop, in this case all classes except particles,
--             an action to be performed after the 10 frames are over 
fg.world:hitFrameStopAdd(10, {'All', except = {'Particles'}}, function() print(1) end)
~~~     

{% title2 Timing %}

Prints {% number 1 %} after 2 seconds, {% number 2 %} every 1 second and {% number 3 %} every frame for 5 seconds:

~~~ lua
-- parameters: duration/time, action
fg.timer:after(2, function() print(1) end)
fg.timer:every(1, function() print(2) end)
fg.timer:during(5, function() print(3) end)
~~~

{% title2 Tweening %}

Tweens the {% text x, y %} position of self to {% number 500, 500 %} for 2 seconds using the {% string 'in-out-cubic' %} tween method:

~~~ lua
-- parameters: duration, table to act upon, target values, tween method
fg.timer:tween(2, self, {x = 500, y = 500}, 'in-out-cubic')
~~~
