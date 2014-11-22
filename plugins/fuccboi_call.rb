module Jekyll
    class FuccboiCall < Liquid::Tag
        
        def initialize(name, markup, tokens)
            @text = markup[0..-2]
            super
        end

        def render(context)
            %(<code class="atrm">#{@text}</code>)
        end
    end
end

Liquid::Template.register_tag('call', Jekyll::FuccboiCall)
