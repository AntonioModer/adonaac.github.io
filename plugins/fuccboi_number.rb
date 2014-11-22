module Jekyll
    class FuccboiNumber < Liquid::Tag
        
        def initialize(name, markup, tokens)
            @text = markup[0..-2]
            super
        end

        def render(context)
            %(<code class="number">#{@text}</code>)
        end
    end
end

Liquid::Template.register_tag('number', Jekyll::FuccboiNumber)
