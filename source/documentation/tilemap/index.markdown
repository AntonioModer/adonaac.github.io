---
layout: page
title: Tilemap 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Example %}

~~~ lua
-- create a new tilemap, parameters are: x, y (center position), tile width and height, tileset image, tilemap data
local tilemap = fg.Tilemap(240, 180, 64, 64, love.graphics.newImage('tileset.png'), {
    {1, 1, 1, 1, 1, 1},
    {1, 1, 0, 0, 1, 1},
    {1, 1, 0, 0, 1, 1},
    {1, 1, 1, 1, 1, 1},
})

-- set the tileset's auto tiling rules
tilemap:setAutoTileRules({6, 14, 12, 2, 10, 8, 7, 15, 13, 3, 11, 9})

-- auto tile based on auto tiling rules
tilemap:autoTile()

-- if using the engine add the tilemap to the 'Default' layer so it can be drawn
-- and generate box2d collision solids
fg.world:addToLayer('Default', tilemap)
fg.world.areas['Default']:generateCollisionSolids(tilemap)
~~~

Using the code above the and the below tileset:

{% img center /assets/tileset.png %}

We get something like this (blue lines are collision solid's debug drawing):

{% img center /assets/tilemap.png %}

{% title Description %}

The {% text fg.Tilemap %} module deals with everything related to creating, manipulating and drawing a map made 
of tiles. It has support for [autotiling](http://www.saltgames.com/2010/a-bitwise-method-for-applying-tilemaps/) 
with simple and advanced rule sets, as well as automatic box2d collision solid generation, if you're using the 
{% text engine %}. You can also load Tiled maps directly:

~~~ lua
-- The third argument points to the path of the .lua map exported by Tiled
local tilemap = fg.Tilemap(0, 0, 'maps/tiled_map')
~~~
<br>

{% title Methods %}

{% method new x number y number tile_width number tile_height number tileset Image tile_grid table settings table %}

*   {% param x, y %}: the center position of the map
*   {% param tile_width, tile_height %}: the width and height of each tile in this tileset
*   {% param tileset %}: the tileset image
*   {% param tile_grid %}: the 2D array containing tile map data
*   {% param settings %}: a table containing related settings, all values are optional

Possible settings:

*   {% param area %}: the area/level this tilemap belongs to, defaults to the {% string Default %} area created by the engine
*   {% param padding %}: horizontal and vertical padding in pixels between each tile

It's also possible to use multiple tilesets for one tilemap. In this case, the number identifiers for the tiles
in the subsequent tilesets continue from the last tile of the first, i.e. if the first tileset has 100 tiles,
the first tile in the second tileset is the number 101.

{% method new x number y number tile_width number tile_height number tilesets table[Image] tile_grid table settings table %}

*   {% param tilesets %}: a table containing the tileset images 

And finally you can just load a Tiled map by passing in its path:

{% method new x number y number tiled_map_path string %}

*   {% param tiled_map_path %}: the path to the .lua file exported by Tiled containing the map specifications 
<br><br>

{% method draw %}

*   draws the tilemap, if using the {% text engine %}, use {% call .world:addToLayer(layer_name, tilemap) %} 
instead
<br><br>

{% method autoTile auto_tile_rules table extended_rules table %}

The autotiling function follows the technique explained in 
[this tutorial](http://www.saltgames.com/2010/a-bitwise-method-for-applying-tilemaps/). The 
{% text auto_tile_rules %} table is a table where the position of each number corresponds to the tile number 
based on the tileset, while the value of each number corresponds to its "bit-value", the sum of its neighbors 
following the {% number 1-2-4-8 %} scheme explained in the linked tutorial.  So, for instance, for the image 
from the first example:

{% img center /assets/tileset.png %}

We have the following rule set:

~~~ lua
{6, 14, 12, 2, 10, 8, 7, 15, 13, 3, 11, 9}
~~~

The array position {% number 1 %} has the value {% number 6 %}, meaning, the tileset tile {% number 1 %} 
(top left most) has a value of {% number 6 %}, which corresponds to a neighbor on the right and down, 
which is exactly when that tile is used. Similarly, the array position {% number 7 %} has the value 
{% number 7 %}, meaning, the bottom left most tile has a value that corresponds to a neighbor up, right and 
down, which is also exactly what that particular tile is used. When you're using your own tilesets in your 
own games, coming up with this simple list of correspondencies is your first job before calling the 
{% call :autoTile %} method. This simple list is the {% text auto_tile_rules %} table.

Sometimes, though, tiles will collide with one another in terms of their bit-value. For instance, the below 
tileset is an example of this:

{% img center /assets/tileset2.png %}

Tiles {% number 13 %}, {% number 15 %} and {% number 8 %} all have a bit-value of {% number 15 %} 
(neighbors up, down, left and right), while tiles {% number 16 %}, {% number 18 %} and {% number 10 %} 
all have a bit-value of {% number 11 %} (neighbors up, left and right). Using a single table for this, 
like in the previous example, isn't enough. That's where the {% text extended_rules %} table comes in. 

~~~ lua
-- Create a new tilemap
tilemap = fg.Tilemap(400, 300, 64, 64, love.graphics.newImage('tileset.png'), {
    {1, 1, 1, 1, 1, 1},
    {1, 1, 0, 0, 1, 1},
    {1, 1, 0, 0, 1, 1},
    {1, 1, 1, 1, 1, 1},
})

-- Set auto tiling rules
tilemap:setAutoTileRules({6, 14, 12, 2, 10, 8, 7, 15, 13, 3, 11, 9}, {
    -- Extended rules
    {tile = 13, bit_value = 15, left = {1, 2}, right = {8, 9, 15}, up = {1, 7}, down = {8, 11}},
    {tile = 15, bit_value = 15, left = {7, 8, 13}, right = {2, 3}, up = {3, 9}, down = {8, 11}},
    {tile = 16, bit_value = 11, left = {4, 5}, right = {11, 12, 18}, up = {1, 7}, down = nil},
    {tile = 18, bit_value = 11, left = {10, 11, 16}, right = {5, 6}, up = {3, 9}, down = nil},
})
~~~

The {% text extended_rules %} table should have additional information about the bit-value colliding tiles, 
such that the algorithm can tell where each one should go with certainty. This information is given as a 
table with these attributes: 

*   {% param tile %}: the tile value being specified
*   {% param bit_value %}: the bit-value of the tile
*   {% param left %}: a table containing all possible values of tiles that can be to the left of this tile
*   {% param right %}: a table containing all possible values of tiles that can be to the right of this tile
*   {% param up %}: a table containing all possible values of tiles that can be above this tile
*   {% param down %}: a table containing all possible values of tiles that can be below this tile
<br><br>

The autotiling algorithm will then first check the {% text auto_tile_rules %}  table to see if the current 
tile being analyzed maps to something there. In case it does, it will pick that value and then check the 
{% text extended_rules %} table to see if any tables there have that same bit-value. If they do, it will look 
through their direction attributes as well as the neighborhood tiles of the current tile being analyzed so see 
if they match and then if they do it will finally pick that tile. Using the new code example above and the new 
tileset, something like this would be generated:

{% img center /assets/tilemap2.png %}

The new corners are correctly placed because the tables in the {% text extended_rule %} table specify which 
tiles can be neighbors to each one of those new corners.
<br>

{% method changeTile x number y number n number %}

*   {% param x, y %}: the position to change  
*   {% param n %}: the number of the tile to change this position to  
<br>

{% method removeTile x number y number %}

*   {% param x, y %}: the position to remove
<br><br>

{% method setAutoTileRules auto_tile_rules table extended_rules table %}

*   sets new autotiling rules, see the full explanation on the method {% call :autoTile %}
<br><br>

{% method setCollisionData collision_data table %}

Sets new collision data for when {% call .world.areas[...]:generateCollisionSolids %} is called. 
Collision data is automatically generated to match the tile data given to the constructor, however, 
in some types of games (anything that is top-down), only some tiles should actually collide, so that's 
when you should use this method.

*   {% param collision_data %}: a table containing the numbers {% number 1 %} (collision) or {% number 0 %} 
(no collision) to be used for generating collision solids, width and height should be exactly the same as the 
one from the tile_data table passed to the constructor
<br><br>

{% title Attributes %}

{% attribute area area Area %}

*   the area/level linked to this tilemap so it can be drawn/updated 
<br><br>

{% attribute tile_size tile_width number tile_height number %}

*   the width and height of tiles in this tilemap   
<br>

{% attribute tilemap_size w number h number %}

*   the width and height of the tilemap itself
<br><br>

{% attribute position x number y number %}
*   the center position of the tilemap
<br><br>

{% attribute corners x1 number y1 number x2 number y2 number %}
*   the top left and bottom right corners of the map
<br><br>

{% title Tiled %}

~~~ lua
-- create a tilemap from a Tiled map
local tilemap = fg.Tilemap(0, 0, 'maps/tiled_map')

-- if using the engine add the tilemap to the 'Default' layer so it can be drawn
-- generate box2d collision solids,
-- and create all entities defined in the Tiled map
fg.world:addToLayer('Default', tilemap)
fg.world.areas['Default']:generateCollisionSolids(tilemap)
fg.world.areas['Default']:createEntities(tilemap)
~~~

Tiled maps need to be defined with two main things in mind when it comes to the {% text engine %}:
the collision layer and the map objects. For the collision layer all you need to do in Tiled is
create a tile layer that has the property {% text collision %} set to true.

{% img center /assets/properties-collision.png %}

This will make it so that for that layer, any tile that is set (not empty) will act as a collision
tile for the {% call :generateCollisionSolids %} call. You can either set this property on your main
layer or you can just create another specific collision layer which you'll fill with whatever collision
tiles you want. 

Another way of creating collision solids is to create an object layer and to add [Solid](/documentation/Solid)
objects to it. Adding objects from the engine (and from your game) to Tiled is pretty straightforward, since
all you need to define is the name of the class (in this case Solid), implement that class in your game 
(the Solid is already implement in the engine) and then add special properties if you want. 

{% img center /assets/objects-solid.png %}
{% img center /assets/properties-solid.png %}

When {% call :createEntities %} is called, all objects defined in the map's object layer will be automatically
created, having their {% call .x, .y %} parameters filled in using their position on Tiled's map, and having
any additional information (width, height, custom properties) being passed via the {% call .settings %} table.
If a class type is defined in Tiled but isn't registered in the {% text engine %} (see [Class](/documentation/class)) 
then errors will occur and your entities will not get created.

If you want to use Tiled + {% text fg.Tilemap %} without using the {% text engine %} then you can access 
the already parsed Tiled map's information through (i.e. {% text tilemap.objects %}):

{% attribute objects objects table %}

*   a table of objects, each following Tiled's Lua exported format
<br><br>

{% attribute tile_grid tile_grid table %}

*   a 2D array containing the tile layer's data. Each number = id of that tile and for tilemaps
with multiple tilesets, the id of tiles in the next tilesets carry from the last, meaning the id
of the first tile in a second tileset, if the first tileset has 100 tiles, will be 101.
<br><br>

{% attribute solid_grid solid_grid table %}

*   a 2D array containing collision data (1 is collision, 0 is not)
<br><br>

{% attribute tiled_data tiled_data table %}

*   the raw exported Tiled Lua file, same as {% text tiled_data = require('maps/tiled_map') %}
<br><br>
