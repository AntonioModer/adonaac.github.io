module Jekyll
    class FuccboiMethodd < Liquid::Tag

        def initialize(name, markup, tokens)
            elements = markup.scan(/\S+/)
            @method_name = elements[0]
            @elements = elements[1 .. -1]
            super
        end

        def render(context)
            method = "<div id='#{@method_name}' data-magellan-destination='#{@method_name}'></div><div><table class='CodeRay'><td class='code'><pre>"
            method += ".<span class='annotation'>" + @method_name + "</span>("
            for i in (0..(@elements.length-1)).step(2) do
                method += "#{@elements[i]}<span class='tag'>[#{@elements[i+1]}]</span>, "
            end
            if @elements.length > 1 
                method = method[0..-3]
            end
            method += ")</pre></td></table></div>"
        end
    end
end

Liquid::Template.register_tag('methodd', Jekyll::FuccboiMethodd)
