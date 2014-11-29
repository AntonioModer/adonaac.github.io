module Jekyll
    class FuccboiNav3 < Liquid::Tag
        
        def initialize(name, markup, tokens)
            @elements = markup.scan(/\S+/)
            super
        end

        def render(context)
            output = "<ul class='nav2'>"
            @elements.each do |t|
                output += "<li><a href='##{t}'>#{t}</a></li>"
            end
            output += "</ul>"
        end
    end
end

Liquid::Template.register_tag('nav3', Jekyll::FuccboiNav3)
