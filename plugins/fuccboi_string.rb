module Jekyll
    class FuccboiString < Liquid::Tag
        
        def initialize(name, markup, tokens)
            @text = markup[0..-2]
            super
        end

        def render(context)
            %(<code class="string">#{@text}</code>)
        end
    end
end

Liquid::Template.register_tag('string', Jekyll::FuccboiString)
