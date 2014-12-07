module Jekyll
    class FuccboiAttribute < Liquid::Tag
        
        def initialize(name, markup, tokens)
            elements = markup.scan(/\S+/)
            @id = elements[0]
            @elements = elements[1 .. -1] 
            super
        end

        def render(context)
            method = "<div id='#{@id}' data-magellan-destination='#{@id}'></div><div><table class='CodeRay'><td class='code'><pre>"
            for i in (0..(@elements.length-1)).step(2) do
                method += ".<span class='annotation'>#{@elements[i]}</span><span class='tag'>[#{@elements[i+1]}]</span>, "
            end
            if @elements.length > 1 
                method = method[0..-3]
            end
            method += "</pre></td></table></div>"
        end
    end
end

Liquid::Template.register_tag('attribute', Jekyll::FuccboiAttribute)
