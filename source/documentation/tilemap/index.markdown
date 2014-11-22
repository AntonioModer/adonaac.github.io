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

~~~

Using the code above the and the below tileset:

{% img center /assets/tileset.png %}

We get something like this (blue lines are collision solid's debug drawing):

{% img center /assets/tilemap.png %}

{% title Description %}

The {% text fg.Tilemap %} module deals with everything related to creating, manipulating and drawing a map made of tiles.
It has support for [autotiling](http://www.saltgames.com/2010/a-bitwise-method-for-applying-tilemaps/) with simple and advanced rule sets, as well as
automatic box2d collision solid generation, if you're using the {% text engine %}. You can also load Tiled maps directly:

~~~ lua

~~~
<br><br>

{% title Methods %}

{% method new x number y number tile_width number tile_height number images table tile_grid table settings table %}

*   {% param x, y %}: the center position of the map
*   {% param tile_width, tile_height %}: the width and height of the tiles in this tileset
*   {% param images %}: the tileset image
*   {% param tile_grid %}: the 2D array containing the tile map data
*   {% param settings %}: a table containing related settings, all values are optional

Possible settings:

*   {% param padding %}: horizontal and vertical padding in pixels between each tile
<br><br>

{% method draw %}

*   draws the tilemap, if using the {% text engine %}, use {% call .world:addToLayer(layer_name, tilemap) %} instead
<br><br>

{% method autoTile auto_tile_rules table extended_rules table %}

The autotiling function follows the technique explained in [this tutorial](http://www.saltgames.com/2010/a-bitwise-method-for-applying-tilemaps/).
The {% text auto_tile_rules %} table is a table where the position of each number corresponds to the tile number based on the tileset, while 
the value of each number corresponds to its "bit-value", the sum of its neighbors following the {% number 1-2-4-8 %} scheme explained in the linked tutorial. 
So, for instance, for the image from the first example:

{% img center /assets/tileset.png %}

We have the following rule set:

~~~ lua
{6, 14, 12, 2, 10, 8, 7, 15, 13, 3, 11, 9}
~~~

The array position {% number 1 %} has the value {% number 6 %}, meaning, the tileset tile {% number 1 %} (top left most) has a value of
{% number 6 %}, which corresponds to a neighbor on the right and down, which is exactly when that tile is used. Similarly, the array position {% number 7 %}
has the value {% number 7 %}, meaning, the bottom left most tile has a value that corresponds to a neighbor up, right and down, which is also exactly what that particular tile
is used. When you're using your own tilesets in your own games, coming up with this simple list of correspondencies is your first job before calling the {% call :autoTile %}
method. This simple list is the {% text auto_tile_rules %} table.

Sometimes, though, tiles will collide with one another in terms of their bit-value. For instance, the below tileset is an example of this:

{% img center /assets/tileset2.png %}

Tiles {% number 13 %}, {% number 15 %} and {% number 8 %} all have a bit-value of {% number 15 %} (neighbors up, down, left and right), 
while tiles {% number 16 %}, {% number 18 %} and {% number 10 %} all have a bit-value of {% number 11 %} (neighbors up, left and right).
Using a single table for this, like in the previous example, isn't enough. That's where the {% text extended_rules %} table comes in. 

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

-- Auto tile, collision solids and drawing
tilemap:autoTile()
fg.world:generateCollisionSolids(tilemap)
fg.world:addToLayer('Default', tilemap)
~~~

The {% text extended_rules %} table should have additional information about the bit-value colliding tiles, such that the algorithm can tell where each one should go 
with certainty. This information is given as a table with these attributes: 

*   {% param tile %}: the tile value being specified
*   {% param bit_value %}: the bit-value of the tile
*   {% param left %}: a table containing all possible values of tiles that can be to the left of this tile
*   {% param right %}: a table containing all possible values of tiles that can be to the right of this tile
*   {% param up %}: a table containing all possible values of tiles that can be above this tile
*   {% param down %}: a table containing all possible values of tiles that can be below this tile
<br><br>

The autotiling algorithm will then first check the <code class="text">auto_tile_rules</code> table to see if the current tile being analyzed maps to something there.
In case it does, it will pick that value and then check the <code class="text">extended_rules</code> table to see if any tables there have that same bit-value. If they do,
it will look through their direction attributes as well as the neighborhood tiles of the current tile being analyzed so see if they match and then if they do it will finally pick
that tile. Using the new code example above and the new tileset, something like this would be generated:

{% img center /assets/tilemap2.png %}

The new corners are correctly placed because the tables in the <code class="text">extended_rule</code> table specify which tiles can be neighbors to each one of those new corners.
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">changeTile</span>(x<span class="tag"><span class="tag">[number]</span></span>, y<span class="tag"><span class="tag">[number]</span></span>, n<span class="tag"><span class="tag">[number]</span></span>)
</pre></td>
</table></div>

*   <code>x, y</code>: the position to change  
*   <code>n</code>: the number of the tile to change this position to  
<br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">removeTile</span>(x<span class="tag"><span class="tag">[number]</span></span>, y<span class="tag"><span class="tag">[number]</span></span>)
</pre></td>
</table></div>

*   <code>x, y</code>: the position to remove 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">setAutoTileRules</span>(auto_tile_rules<span class="tag">[table]</span>, extended_rules<span class="tag">[table]</span>)
</pre></td>
</table></div>

*   sets new autotiling rules, see the full explanation on the <code class="atrm">:autoTile</code> method 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">setCollisionData</span>(collision_data<span class="tag">[table]</span>)
</pre></td>
</table></div>

Sets new collision data for when <code class="atrm">.world:generateCollisionSolids</code> is called. Collision data is automatically generated
to match the tile data given to the constructor, however, in some types of games (anything that is top-down), only some tiles should actually collide, so
that's when you should use this method.

*   <code>collision_data</code>: a table containing the numbers <code class="number">1</code> (collision) or <code class="number">0</code> (no collision) to be used
for generating collision solids, width and height should be exactly the same as the one passed to the constructor
<br><br>

<h3 id="attributes" data-magellan-destination="attributes">Attributes</h3>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">tile_size_x</span><span class="tag">[number]</span>, .<span class="annotation">tile_size_y</span><span class="tag">[number]</span>
</pre></td>
</table></div>

*    the width and height of tiles in this tilemap   
<br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">w</span><span class="tag">[number]</span>, .<span class="annotation">h</span><span class="tag">[number]</span>
</pre></td>
</table></div>

*   the width and height of the tilemap itself, in terms of world units. Divide by <code class="atrm">.tile_size_x/y</code> to get it in terms of tiles
<br><br>
