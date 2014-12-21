---
layout: page
title: Timer 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Example %}

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

{% title Description %}

The {% text fg.Timer %} module handles timers and tweens. It's an enhanced version of 
[hump.timer](http://vrld.github.io/hump/#hump.timer), with a few function name changes and with that 
added ability of timer/tween tagging. A global {% text Timer %} is initialized automatically and can 
be used from {% text fg.timer %}, but you may also create your own new instances by doing {% text timer = fg.Timer() %}.
Having your own instances is useful if some of your entities rely on tagging, since tags block 
timer/tween creation when a tag already exists, so using the global {% text Timer %} for it is not going to work.

Timer/tween creation methods have tags enabled. Tags provide a way of identifying a certain tween so 
that it can be cancelled if necessary. For instance, this code:

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

The effect that the HP bar has of only actually decreasing after a while is achieved because of tags. 
The main tween {% string 'change_hp' %} is done every time the player takes damage and it correponds 
to the front layer of the HP bar. Every time {% call :changeHP %} is called, if another {% string 'change_hp' %}
tween is happening, it is cancelled and then immediately continued. If the {% call :cancel %} call didn't exist, 
there would be multiple tweens changing a single variable and it would look buggy.

The back layer, controlled by {% string change_hp_back_after %} and {% string 'change_hp_back_tween' %} happens 
after {% number 0.2 %} seconds of the main tween. This explains why there's a lag between taking damage and the 
HP bar actually decreasing. And similarly, these tweens are also cancelled on {% call :changeHP %} call, this is 
to avoid the same visual bugs that would occur from multiple tweens acting on one variable. Additionally, this 
makes it so that the HP bar will only decrease after {% number 0.2 %} seconds of the last damage received (since 
the {% string 'change_hp_back_after' %} call is cancelled), giving it an even nicer lagging effect whenever the player
is repeatedly damage in small bursts.
<br>

{% title Methods %}

{% method new %}

*   creates a new {% text Timer %} instance 
<br><br>

{% method update dt number %}

*   {% param dt %}: delta value passed from the main loop to update the timer
<br><br>

{% method after tag string[optional] delay number action function %}

*   calls {% text action %} after {% text delay %} seconds, if {% text tag %} is already registered then 
cancels previously registered {% text after %} calls
*   {% param tag %}: the identifier for this {% text after %} call, the call is not tagged if this is omitted
*   {% param delay %}: the amount of seconds from this call after which {% text action %} will be called
*   {% param action %}: the function to be called
<br><br>

{% method cancel tag string %}

*   cancels the timer/tween attached to {% text tag %} 
<br><br>

{% method clear %}

*   cancels all timers/tweens and removes all tags
<br><br>

{% method destroy %}

*   cancels all timers/tweens, removes all tags and dereferences the timer internal object
<br><br>

{% method during tag string[optional] duration number action function after function[optional] %}

*   calls {% text action %} every frame for {% text duration %} seconds, and then {% text after %} after 
{% text duration %} seconds, if {% text tag %} is already registered then cancels previously registered
{% text during %} calls
*   {% param tag %}: the identifier for this {% text during %} call, the call is not tagged if this is omitted
*   {% param duration %}: the amount of seconds {% text action %} will be called for
*   {% param action %}: the function to be called
*   {% param after %}: the function to be called after {% text duration %} seconds, optional and does nothing if omitted
<br><br>

{% method every tag string[optional] delay number action function count number[optional] %}

*   calls {% text action %} every {% text delay %} seconds for {% text count %} times, if {% text tag %} is 
already registered then cancels previously registered {% text every %} calls
*   {% param tag %}: the identifier for this {% text every %} call, the call is not tagged if omitted
*   {% param delay %}: the amount of seconds between each {% text action %} call, can also be a table with two numbers in it, in which case a random
delay between those two numbers is chosen each time (first number must be smaller than the second)
*   {% param action %}: the function to be called
*   {% param count %}: the maximum amount of times {% text action %} is called, defaults to infinite if omitted
<br><br>

{% method tween tag string[optional] duration number table table tween_table table tween_method string after function[optional] %}

*   tweens the attributes specified in {% text tween_table %} from {% text table %} to the values specified in {% text tween_table %} 
using {% text tween_method %}, calls {% text after %} when the tween is done
*   {% param tag %}: the identifier for this {% param tween %} call, the call is not tagged if omitted
*   {% param duration %}: the duration in seconds of the tween
*   {% param table %}: the table that is being tweened
*   {% param tween_table %}: the values specifying which attributes and to what values those attributes will be changed
*   {% param tween_method %}: the tween method used for the tween
*   {% param after %}: the function to be called after {% text duration %} seconds, optional and does nothing if omitted

Refer to [hump.timertween](http://vrld.github.io/hump/#hump.timertween) for more information.
<br><br>
