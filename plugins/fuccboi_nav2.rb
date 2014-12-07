module Jekyll
    class FuccboiNav2 < Liquid::Tag
        
        def initialize(name, markup, tokens)
            elements = markup.split(/\[([^\]]+)\]/).select{|x| x.length > 1}
            @elements = []
            elements.each do |el|
                @elements.push([el.split[0], el.split[1 .. -1].join(" ")])
            end
            super
        end

        def render(context)
            output = ""
            @elements.each do |t|
                output += "<li data-magellan-arrival='#{t[0].tr(" ", "_")}' class='nav'><a href='##{t[0].tr(" ", "_")}'>#{t[1]}</a></li>"
            end
            return output
        end
    end
end

Liquid::Template.register_tag('nav2', Jekyll::FuccboiNav2)
