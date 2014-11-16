---
layout: page
title: Entity 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

<h3 id="description" data-magellan-destination="description">Description</h3>

The <code class="text">mg.Entity</code> is the base class that all <code class="text">engine</code> classes should inherit from. It has basic attributes that are used by all
systems in <code class="text">mg.world</code>.
<br><br>

<h3 id="attributes" data-magellan-destination="attributes">Attributes</h3>

<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">x</span><span class="tag">[number]</span>, <span class="annotation">.y</span><span class="tag">[number]</span>
</pre></td>
</table></div>

*   the position of the entity, in world coordinates
<br><br>


<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">dead</span><span class="tag">[boolean]</span>
</pre></td>
</table></div>

*   if the entity is dead, dead entities get automatically removed from the world at the end of the frame
<br><br>


<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">id</span><span class="tag">[number]</span>
</pre></td>
</table></div>

*   the unique identifier of the entity 
<br><br>


<div><table class="CodeRay">
<td class="code"><pre>
.<span class="annotation">world</span><span class="tag">[World]</span>
</pre></td>
</table></div>

*   a reference to the world the entity is manipulated by 
<br><br>
