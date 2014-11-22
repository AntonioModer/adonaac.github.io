module Jekyll
    class FuccboiText < Liquid::Tag
        
        def initialize(name, markup, tokens)
            @text = markup[0..-2]
            super
        end

        def render(context)
            %(<code class="text">#{@text}</code>)
        end
    end
end

Liquid::Template.register_tag('text', Jekyll::FuccboiText)
