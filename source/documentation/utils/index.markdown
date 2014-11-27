---
layout: page
title: utils 
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Methods %}

{% methodd graphics.pushRotate x number y number angle number %}

*   rotates everything around {% text x, y %} by {% text angle %} until {% text love.graphics.pop() %} is called
*   {% param x, y %}: the pivot position to rotate everything around
*   {% param angle %}: the amount to rotate things for
<br><br>

{% methodd graphics.pushRotateScale x number y number angle number scale_x number scale_y number %}

*   rotates everything around {% text x, y %} by {% text angle %} with {% text scale_x, scale_y %} 
until {% text love.graphics.pop() %} is called
*   {% param x, y %}: the pivot position to rotate everything around
*   {% param angle %}: the amount to rotate things for
*   {% param scale_x, scale_y %}: the amount to scale things by
<br><br>

{% methodd math.chooseWithProbability choices table chances table %}

*   returns a value from the {% text choices %} table, chosen with a probability given by the {% text chances %} table    
*   {% param choices %}: a table containing values to be picked
*   {% param chances %}: a table of equal size to {% text choices %} containing the probability of each value being picked

~~~ lua
-- 50% to print 2
-- 30% to print 'hhh'
-- 20% to print 3
print(chooseWithProbability({2, 'hhh', 3}, {0.5, 0.3, 0.2})
~~~
<br>

{% methodd math.clamp value number min number max number %}

*   clamps {% text value %} between {% text min %} and {% text max %} 
<br><br>

{% methodd math.isBetween value number min number max number %}

*   returns {% text true %} if {% text value %} is between {% text min %} and {% text max %}, {% text false %} otherwise 
<br><br>

{% methodd math.random min number max number %}

*   returns a random floating point number between {% text min %} and {% text max %}, use Lua's {% text math.random %} for integers only
<br><br>

{% methodd math.round number number precision number %}

*   returns a number rounded to {% text precision %} decimal points
*   {% param number %}: the number being rounded
*   {% param precision %}: the precision, in terms of number of decimal places, that {% text number %} is rounded to
<br><br>


{% methodd table.copy table table %}

*   returns the copied table. Since tables in Lua are always references this can be useful sometimes!
<br><br>

{% methodd table.random table table %}

*   returns a random value from {% text table %} 
<br><br>

{% methodd angleToDirection4 angle number %}

*   returns a direction that best corresponds to {% text angle %}, all possible returned values are 
{% string 'right' %}, {% string 'up' %}, {% string 'left' %} and {% string 'down' %} 
<br><br>

{% methodd directionToAngle4 direction string %}

*   returns an angle that corresponds to {% text direction %}, all possible direction values are
{% string 'right' %}, {% string 'up' %}, {% string 'left' %} and {% string 'down' %} 
<br><br>
