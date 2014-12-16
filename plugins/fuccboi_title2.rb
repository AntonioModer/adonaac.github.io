module Jekyll
    class FuccboiTitle2 < Liquid::Tag
        
        def initialize(name, markup, tokens)
            @title = markup[0..-2]
            super
        end

        def render(context)
            %(<h5 id="#{@title.tr(" ", "_")}" data-magellan-destination="#{@title.tr(" ", "_")}">#{@title}</h5>)
        end
    end
end

Liquid::Template.register_tag('title2', Jekyll::FuccboiTitle2)
