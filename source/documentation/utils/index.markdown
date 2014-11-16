---
layout: page
title: Utils 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

<h3 id="description" data-magellan-destination="description">Description</h3>

The <code class="text">Utils</code> module contains a bunch of useful functions!
<br><br>

<h3 id="methods" data-magellan-destination="methods">Methods</h3>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">graphics.pushRotate</span>(x<span class="tag">[number]</span>, y<span class="tag">[number]</span>, angle<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   rotates everything around <code class="text">x, y</code> by <code class="text">angle</code> until <code class="text">love.graphics.pop()</code> is called
*   <code>x, y</code>: the pivot position to rotate everything around
*   <code>angle</code>: the amount to rotate things for
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">graphics.pushRotateScale</span>(x<span class="tag">[number]</span>, y<span class="tag">[number]</span>, angle<span class="tag">[number]</span>, scale_x<span class="tag">[number]</span>, scale_y<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   rotates everything around <code class="text">x, y</code> by <code class="text">angle</code> with <code class="text">scale_x, scale_y</code> until <code class="text">love.graphics.pop()</code> is called
*   <code>x, y</code>: the pivot position to rotate everything around
*   <code>angle</code>: the amount to rotate things for
*   <code>scale_x, scale_y</code>: the amount to scale things by
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">logic.equalsAll</span>(value<span class="tag">[any]</span>, values<span class="tag">[table]</span>)
</pre></td>
</table></div>

*   <code>boolean</code> returns true if all values inside <code class="text">values</code> equals <code class="text">v</code>
*   <code>value</code>: the value being checked
*   <code>values</code>: the values being checked against
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">logic.equalsAny</span>(value<span class="tag">[any]</span>, values<span class="tag">[table]</span>)
</pre></td>
</table></div>

*   <code>boolean</code> returns true if any of the values inside <code class="text">values</code> equals <code class="text">v</code> 
*   <code>value</code>: the value being checked
*   <code>values</code>: the values being checked against

~~~ lua
local l = mg.utils.logic
if l.equalsAny(self.damage_type, {'Earth', 'Fire', 'Ice', 'Wind'}) then
    castSpell(self.damage_type)
end
~~~
<br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">math.chooseWithProbability</span>(choices<span class="tag">[table]</span>, chances<span class="tag">[table]</span>)
</pre></td>
</table></div>

*   <code>any</code> returns a value from the <code class="text">choices</code> table, chosen with a probability given by the <code class="text">chances</code> table    
*   <code>choices</code>: a table containing values to be picked
*   <code>chances</code>: a table of equal size to <code class="text">choices</code> containing the probability of each value being picked

~~~ lua
-- 50% to print 2
-- 30% to print 'hhh'
-- 20% to print 3
print(chooseWithProbability({2, 'hhh', 3}, {0.5, 0.3, 0.2})
~~~
<br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">math.clamp</span>(value<span class="tag">[number]</span>, min<span class="tag">[number]</span>, max<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   clamps <code class="text">value</code> between <code class="text">min</code> and <code class="text">max</code> 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">math.isBetween</span>(value<span class="tag">[number]</span>, min<span class="tag">[number]</span>, max<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   <code>boolean</code> returns <code class="text">true</code> if <code class="text">value</code> is between <code class="text">min</code> and <code class="text">max</code>, <code class="text">false</code> otherwise 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">math.random</span>(min<span class="tag">[number]</span>, max<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   <code>number</code> returns a random floating point number between <code class="text">min</code> and <code class="text">max</code>, use Lua's <code class="text">math.random</code> for integers only
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">math.round</span>(number<span class="tag">[number]</span>, precision<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   <code>number</code>: the number being rounded
*   <code>precision</code>: the precision, in terms of number of decimal places, that <code class="text">number</code> is rounded to
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">table.contains</span>(table<span class="tag">[table]</span>, value<span class="tag">[any]</span>)
</pre></td>
</table></div>

*   <code>boolean</code> returns <code class="text">true</code> if <code class="text">value</code> is contained in <code class="text">table</code>, <code class="text">false</code> otherwise 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">table.copy</span>(table<span class="tag">[table]</span>)
</pre></td>
</table></div>

*   <code>table</code> returns the copied table. Since tables in Lua are always references this can be useful sometimes
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">table.random</span>(table<span class="tag">[table]</span>)
</pre></td>
</table></div>

*   <code>any</code> returns a random value from <code class="text">table</code> 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">table.toString</span>(table<span class="tag">[table]</span>)
</pre></td>
</table></div>

*   <code>string</code> returns a string representing the table, only <code class="text">keys</code>, <code class="text">numbers</code>, <code class="text">booleans</code>, <code class="text">strings</code> and <code class="text">tables</code> are copied, everything else is lost (including <code class="text">metatables</code>) 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">angleToDirection4</span>(angle<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   <code>string</code> returns a direction that best corresponds to <code class="text">angle</code>, all possible values are <code class="text">'right'</code>, <code class="text">'up'</code>, <code class="text">'left'</code>, <code class="text">'down'</code> 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">directionToAngle4</span>(direction<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   <code>number</code> returns an angle that best corresponds to <code class="text">direction</code>   
<br><br>
