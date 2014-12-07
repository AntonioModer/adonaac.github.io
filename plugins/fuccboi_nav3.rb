module Jekyll
    class FuccboiNav3 < Liquid::Tag
        
        def initialize(name, markup, tokens)
            @elements = markup.scan(/\S+/)
            super
        end

        def render(context)
            output = ""
            @elements.each do |t|
                output += "<li data-magellan-arrival='#{t}' class='nav'><a href='##{t}'>#{t}</a></li>"
            end
            return output
        end
    end
end

Liquid::Template.register_tag('nav3', Jekyll::FuccboiNav3)
