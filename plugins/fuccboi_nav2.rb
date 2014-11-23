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
            output = "<ul class='nav2'>"
            @elements.each do |t|
                output += "<li><a href='##{t[0]}'>#{t[1]}</a></li>"
            end
            output += "</ul>"
        end
    end
end

Liquid::Template.register_tag('nav2', Jekyll::FuccboiNav2)
