---
layout: page
title: Tilemap 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

<h3 id="example" data-magellan-destination="example">Example</h3>

~~~ lua
-- create a tilemap, parameters are: x, y (center) position, tile width and height, tileset image, tilemap data
tilemap = mg.Tilemap(400, 300, 32, 32, love.graphics.newImage('tileset.png'), {
    {1, 1, 1, 1, 1, 1},
    {1, 1, 0, 0, 1, 1},
    {1, 1, 0, 0, 1, 1},
    {1, 1, 1, 1, 1, 1},
})

-- set the tileset's auto tiling rules
tilemap:setAutoTileRules({6, 14, 12, 2, 10, 8, 7, 15, 13, 3, 11, 9})

-- auto tile based on the auto tiling rules
tilemap:autoTile()

-- if using the engine then generate box2d collision solids
-- and add the tilemap to the 'Default' layer so it can be drawn
mg.world:generateCollisionSolids(tilemap)
mg.world:addToLayer('Default', tilemap)
~~~

Using the code above the and the below tileset:

{% img center /assets/tileset.png %}

We get something like this (blue lines are collision solid's debug drawing):

{% img center /assets/tilemap.png %}

<h3 id="description" data-magellan-destination="description">Description</h3>

The <code class="text">mg.Tilemap</code> deals with everything related to creating, manipulating and drawing a map made of tiles.
It has support for [autotiling](http://www.saltgames.com/2010/a-bitwise-method-for-applying-tilemaps/) with simple and advanced rule sets, as well as
automatic box2d collision solid generation, if you're using the <code class="text">engine</code>. Right now the only way to specify the map's data is by hand,
but in the future I'll add Tiled support as well as a custom editor.
<br><br>

<h3 id="methods" data-magellan-destination="methods">Methods</h3>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">new</span>(x<span class="tag"><span class="tag">[number]</span></span>, y<span class="tag"><span class="tag">[number]</span></span>, tile_width<span class="tag"><span class="tag">[number]</span></span>, tile_height<span class="tag"><span class="tag">[number]</span></span>, tileset<span class="tag">[Image]</span>, tile_data<span class="tag">[table]</span>) 
</pre></td>
</table></div>

*   <code>x, y</code>: the center position of the map
*   <code>tile_size_x, tile_size_y</code>: the width and height of the tiles in this tileset
*   <code>tileset</code>: the tileset image
*   <code>tile_data</code>: the 2D array containing the tile map data
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">draw</span>()
</pre></td>
</table></div>

*   draws the tilemap, if using the <code class="text">engine</code>, use <code class="atrm">.world:addToLayer(layer_name, tilemap)</code> instead
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">autoTile</span>(auto_tile_rules<span class="tag">[table]</span>, extended_rules<span class="tag">[table]</span>)
</pre></td>
</table></div>

The autotiling function follows the technique explained in [this tutorial](http://www.saltgames.com/2010/a-bitwise-method-for-applying-tilemaps/).
The <code class="text">auto_tile_rules</code> table is a table where the position of each number corresponds to the tile number based on the tileset, while 
the value of each number corresponds to its "bit-value", the sum of its neighbors following the <code class="number">1-2-4-8</code> scheme. So, for instance, for the image from the first
example:

{% img center /assets/tileset.png %}

We have the following rule set:

~~~ lua
{6, 14, 12, 2, 10, 8, 7, 15, 13, 3, 11, 9}
~~~

The array position <code class="number">1</code> has the value <code class="number">6</code>, meaning, the tileset tile <code class="number">1</code> (top left most) has a value of
<code class="number">6</code>, which corresponds to a neighbor on the right and down, which is exactly when that tile is used. Similarly, the array position <code class="number">7</code>
has the value <code class="number">7</code>, meaning, bottom left most tile has a value that corresponds to a neighbor up, right and down, which is also exactly what that particular tile
is used. When you're using your own tilesets in your own games, coming up with this simple list of correspondencies is your first job before calling the <code class="atrm">:autoTile</code> 
method. This simple list is the <code class="text">auto_tile_rules</code> table.

Sometimes, though, tiles will collide with one another in terms of their bit-value. For instance, the below tileset is an example of this:

{% img center /assets/tileset2.png %}

Tiles <code class="number">13</code>, <code class="number">15</code> and <code class="number">8</code> all have a bit-value of <code class="number">15</code> (neighbors up, down, left and right), 
while tiles <code class="number">16</code>, <code class="number">18</code> and <code class="number">10</code> all have a bit-value of <code class="number">11</code> (neighbors up, left and right).
Using a single table for this, like in the previous example, isn't enough. That's where the <code class="text">extended_rules</code> table comes in. Revisting the code from the first example on this
page, it would look something like this:

~~~ lua
tilemap = mg.Tilemap(400, 300, 32, 32, love.graphics.newImage('tileset.png'), {
    {1, 1, 1, 1, 1, 1},
    {1, 1, 0, 0, 1, 1},
    {1, 1, 0, 0, 1, 1},
    {1, 1, 1, 1, 1, 1},
})
tilemap:setAutoTileRules({6, 14, 12, 2, 10, 8, 7, 15, 13, 3, 11, 9}, {
    {tile = 13, bit_value = 15, left = {1, 2}, right = {8, 9, 15}, up = {1, 7}, down = {8, 11}},
    {tile = 15, bit_value = 15, left = {7, 8, 13}, right = {2, 3}, up = {3, 9}, down = {8, 11}},
    {tile = 16, bit_value = 11, left = {4, 5}, right = {11, 12, 18}, up = {1, 7}, down = nil},
    {tile = 18, bit_value = 11, left = {10, 11, 16}, right = {5, 6}, up = {3, 9}, down = nil},
})
tilemap:autoTile()
mg.world:generateCollisionSolids(tilemap)
mg.world:addToLayer('Default', tilemap)
~~~


The <code class="text">extended_rules</code> should have additional information about the bit-value colliding tiles, such that the algorithm can tell where each one should go 
with certainty. This information is given as a table with these attributes: 

*   <code>tile</code>: the tile value being specified
*   <code>bit_value</code>: the bit-value of the tile
*   <code>left</code>: a table containing all possible values of tiles that can be to the left of this tile
*   <code>right</code>: a table containing all possible values of tiles that can be to the right of this tile
*   <code>up</code>: a table containing all possible values of tiles that can be above this tile
*   <code>down</code>: a table containing all possible values of tiles that can be below this tile
<br><br>

The autotiling algorithm will then first check the <code class="text">auto_tile_rules</code> table to see if the current tile being analyzed maps to something there.
In case it does, it will pick that value and then check the <code class="text">extended_rules</code> table to see if any tables there have that same bit-value. If they do,
it will look through their direction attributes as well as the neighborhood tiles of the current tile being analyzed so see if they match and then if they do it will finally pick
that tile. Using the new code example above and the new tileset, something like this would be generated:

{% img center /assets/tilemap2.png %}

The new corners are correctly placed because the tables in the <code class="text">extended_rule</code> table specify which tiles can be neighbors to each one of those new corners.
If only the simple rules were used, then the right corner would be placed as the left corner, because the algorithm would have no way of knowing which is which (test it)!
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
