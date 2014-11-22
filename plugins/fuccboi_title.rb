module Jekyll
    class FuccboiTitle < Liquid::Tag
        
        def initialize(name, markup, tokens)
            @title = markup[0..-2]
            super
        end

        def render(context)
            %(<h3 id="#{@title}" data-magellan-destination="#{@title}">#{@title}</h3>)
        end
    end
end

Liquid::Template.register_tag('title', Jekyll::FuccboiTitle)
