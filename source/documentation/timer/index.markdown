---
layout: page
title: Timer 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

<h3 id="example" data-magellan-destination="example">Example</h3>

~~~ lua
-- prints 2 after 2 seconds from this call have passed
timer:after(2, function() print(2) end)

-- changes the value of some boolean every 1 second, but does it only 5 times
timer:every(1, function() some_boolean = not some_boolean end, 5)

-- prints 'SPAM' every frame for 5 seconds
timer:during(5, function() print('SPAM') end)

-- tweens the x, y position of self to 500, 500 for 2 seconds using the 'in-out-cubic' tween method
timer:tween(2, self, {x = 500, y = 500}, 'in-out-cubic')
~~~
<br>

<h3 id="description" data-magellan-destination="description">Description</h3>

The <code class="text">mg.Timer</code> module handles timers and tweens. It's an enhanced version of [hump.timer](http://vrld.github.io/hump/#hump.timer), with a new
function name changes and with that added ability of timer/tween tagging. A global <code class="text">Timer</code> is initialized automatically and can be used from 
<code class="text">mg.timer</code>, but you may also create your own new instances by doing <code class="text">timer = mg.Timer()</code>. Having your own instances is useful if 
some of your entities types rely on tagging, since tags block timer/tween creation when a tag already exists, so using the global <code class="text">Timer</code> for it is not going to work.

Timer/tween creation methods have tags enabled. Tags provide a way of identifying a certain tween so that it can be cancelled if necessary. For instance, this code:

~~~ lua
function HPBar:changeHp()
    -- Cancel all HP bar related tweens
    self.timer:cancel('change_hp')
    self.timer:cancel('change_hp_back_after')
    self.timer:cancel('change_hp_back_tween')

    -- Tween the front layer of the HP bar
    self.timer:tween('change_hp', 0.2, self, 
                    {x_offset = self.w*(player.hp/player.max_hp)}, 'in-out-cubic')

    -- Tween the back layer (lighter color) of the HP bar after 0.2 seconds
    self.timer:after('change_hp_back_after', 0.2, function()
        self.timer:tween('change_hp_back_tween', 0.2, self, 
                        {x_offset_back = self.w*(player.hp/player.max_hp)}, 'in-out-cubic')
    end)
end
~~~

Does this:

{% img center /assets/hpbar.gif %}

The effect that the HP bar has of only actually decreasing after a while is achieved because of tags. The main tween <code class="string">'change_hp'</code> is done
every time the player takes damage and it correponds to the front layer of the HP bar. Every time <code class="atrm">:changeHP</code> is called, if another <code class="string">'change_hp'</code> tween is happening,
it is cancelled and then immediately continued. If the <code class="atrm">:cancel</code> call didn't exist, there would be multiple tweens changing a single variable and it would look buggy.

The back layer, controlled by <code class="string">'change_hp_back_after'</code> and <code class="string">'change_hp_back_tween'</code> happens after <code class="number">0.2</code> seconds of the main tween.
This explains why there's a lag between taking damage and the HP bar actually decreasing. And similarly, these tweens are also cancelled on <code class="atrm">:changeHp</code> call,
this is to avoid the same visual bugs that would occur from multiple tweens acting on one variable. Additionally, this makes it so that the HP bar will only decrease after 
<code class="number">0.2</code> seconds of the last damage received (since the <code class="string">'change_hp_back_after'</code> call is cancelled), giving it an even nicer lagging effect whenever the player
is repeatedly damage in small bursts.

<h3 id="methods" data-magellan-destination="methods">Methods</h3>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">new</span>()
</pre></td>
</table></div>

*   creates a new <code class="text">Timer</code> instance 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">update</span>(dt<span class="tag">[number]</span>)
</pre></td>
</table></div>

*   <code>dt</code>: delta value passed from the main loop to update the timer
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">after</span>(tag<span class="tag">[string]</span><span class="tag">[optional]</span>, delay<span class="tag">[number]</span>, action<span class="tag">[function]</span>)
</pre></td>
</table></div>

*   calls <code class="text">action</code> after <code class="text">delay</code> seconds, if <code class="text">tag</code> is already registered then does nothing
*   <code>tag</code>: the identifier for this <code class="text">after</code> call, the call is not tagged if this is omitted
*   <code>delay</code>: the amount of seconds from this call after which <code class="text">action</code> will be called
*   <code>action</code>: the function to be called
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">cancel</span>(tag<span class="tag">[string]</span>)
</pre></td>
</table></div>

*   cancels the timer/tween attached to <code class="text">tag</code> 
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">clear</span>()
</pre></td>
</table></div>

*   cancels all timers/tweens and removes all tags
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">destroy</span>()
</pre></td>
</table></div>

*   cancels all timers/tweens, removes all tags and dereferences the timer internal object
<br><br>



<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">during</span>(tag<span class="tag">[string]</span><span class="tag">[optional]</span>, duration<span class="tag">[number]</span>, action<span class="tag">[function]</span>, after<span class="tag">[function]</span><span class="tag">[optional]</span>)
</pre></td>
</table></div>

*   calls <code class="text">action</code> every frame for <code class="text">duration</code> seconds, and then <code class="text">after</code> after <code class="text">duration</code> seconds, if <code class="text">tag</code> is already registered
then does nothing
*   <code>tag</code>: the identifier for this <code class="text">during</code> call, the call is not tagged if this is omitted
*   <code>duration</code>: the amount of seconds <code class="text">action</code> will be called for
*   <code>action</code>: the function to be called
*   <code>after</code>: the function to be called after <code class="text">duration</code> seconds, optional and does nothing if omitted
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">every</span>(tag<span class="tag">[string]</span><span class="tag">[optional]</span>, delay<span class="tag">[number]</span>, action<span class="tag">[function]</span>, count<span class="tag">[number]</span><span class="tag">[optional]</span>)
</pre></td>
</table></div>

*   calls <code class="text">action</code> every <code class="text">delay</code> seconds for <code class="text">count</code> times, if <code class="text">tag</code> is already registered then does nothing
*   <code>tag</code>: the identifier for this <code class="text">every</code> call, the call is not tagged if omitted
*   <code>delay</code>: the amount of seconds between each <code class="text">action</code> call
*   <code>action</code>: the function to be called
*   <code>count</code>: the maximum amount of times <code class="text">action</code> is called, defaults to infinite if omitted
<br><br>

<div><table class="CodeRay">
<td class="code"><pre>
:<span class="annotation">tween</span>(tag<span class="tag">[string]</span><span class="tag">[optional]</span>, duration<span class="tag">[number]</span>, table<span class="tag">[table]</span>, tween_table<span class="tag">[table]</span>, tween_method<span class="tag">[string]</span>, after<span class="tag">[function]</span><span class="tag">[optional]</span>)
</pre></td>
</table></div>

*   tweens the attributes specified in <code class="text">tween_table</code> from <code class="text">table</code> to the values specified in <code class="text">tween_table</code> using <code class="text">tween_method</code>, calls <code class="text">after</code> 
when the tween is done
*   <code>tag</code>: the identifier for this <code class="text">tween</code> call, the call is not tagged if omitted
*   <code>duration</code>: the duration in seconds of the tween
*   <code>table</code>: the table that is being tweened
*   <code>tween_table</code>: the values specifying which attributes and to what values those attributes will be changed
*   <code>tween_method</code>: the tween method used for the tween
*   <code>after</code>: the function to be called after <code class="text">duration</code> seconds, optional and does nothing if omitted

Refer to [hump.timertween](http://vrld.github.io/hump/#hump.timertween) for more information.
<br><br>
