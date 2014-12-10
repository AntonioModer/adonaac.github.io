---
layout: page
title: Serial
subtitle:
comments: true
sharing: false
footer: true
sidebar: false 
---

{% title Example %}

~~~ lua
-- saves a level
fg.Serial:saveArea('save_filename', fg.world.areas['Level_1'])

-- loads a level
fg.Serial:loadArea('save_filename', fg.world.areas['Level_1'])

-- saves an object if it implements a save function
fg.Serial:saveObject('save_filename', entity)

-- loads an object
data = fg.Serial:loadObject('save_filename')
fg.Serial:loadObject('save_filename', fg.world.areas['Level_1'])

-- simple table serialization
local a = {1, '2', function() print(3) end}
fg.Serial.serialize('save_filename', a)
~~~

{% title Description %}

The {% text fg.Serial %} module handles data saving and loading. You can serialize tables normally, save
and load objects or save and load {% text engine %} areas. It uses [Ser](https://github.com/gvx/Ser) internally
for the serialization call. All files are saved to a specific folder as defined by [LÖVE's filesystem module](https://love2d.org/wiki/love.filesystem),
so you don't need to specify paths when saving your data.
<br><br>

{% title Methods %}

{% method loadArea filename string area Area[optional] %}

*   {% param filename %}: the name of the file that contains the saved data
*   {% param area %}: a reference to the area that the saved objects should be loaded to, if omitted will return the loaded data as a table (not as the rebuilt area)
<br><br>

{% method loadObject filename string area Area[optional] %}

*   {% param filename %}: the name of the file that contains the saved data
*   {% param area %}: the name of the area to load this object to, if omitted will return the loaded data as a table (not as the rebuilt object)
<br><br>

{% method saveArea filename string area Area dropped_classes table[string][optional] %}

*   {% param filename %}: the name of the file to save data to
*   {% param area %}: the area to get the data from
*   {% param dropped_classes %}: a table of strings saying which classes of objects shouldn't be saved, if omitted all objects that implement a {% call :save %} method will be saved

~~~ lua
-- don't save instances of class Player and Particles
fg.Serial:saveArea('save_filename', fg.world.areas['Level_1'], {'Player', 'Particles'})
~~~

{% method saveObject filename string object table %}

*   {% param filename %}: the name of the file to save data to
*   {% param object %}: the object to get the data from, must implement a {% call :save %} method 
<br><br>

{% method serialize filename string table table %}

*   [ser's](https://github.com/gvx/Ser) main serialization function
*   {% param filename %}: the name of the file to save data to
*   {% param table %}: the table to get the save data from 
<br><br>

{% title Saving and Loading %}

So that objects can be saved and loaded, either individually or through areas, they need to implement a {% call :save %} method.
This method needs to simply return a table containing the information that is supposed to be saved, without containing any type
of custom userdata or references to other objects that might contain custom userdata. The table returned from this function is
what will get passed to [Ser's](https://github.com/gvx/Ser) serialize function and then stored in a file.

~~~ lua
function Player:save()
    return {
        x = self.x, y = self.y, w = self.w, h = self.h,
        hp = self.hp, modifiers = {speed = 1.5, damage = 2, range = 3},
        items = {self.items[1].name, self.items[2].name, self.items[3].name},
    }
end
~~~

Loading an object will simply take the table returned from the save method and store in the file and pass it as the
{% text settings %} table on object creation. In the particular case of the example above it would do this automatically:

~~~ lua
local object = fg.Serial.loadObject('Player')
fg.world:createEntity('Player', object.x, object.y, {w = object.w, h = object.h, hp = object.hp, ...})
~~~

And so when creating the constructor of your class you need to keep the save method in mind. For instance, the items
table contains a list of strings with item names, but my Player class' {% text .items %} table actually holds references
to {% text Item %} objects, but I can't save those objects directly. So I pass strings, and then on the Player class'
constructor I recreate the objects:

~~~ lua
function Player:new(area, x, y, settings)
    ...
    self.items = {}
    -- Recreate items from Item class if settings.items is set
    for _, v in ipairs(settings.items or {}) do
        table.insert(self.items, Item(v))
    end
end
~~~
