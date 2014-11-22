module Jekyll
    class FuccboiParam < Liquid::Tag

        def initialize(name, markup, tokens)
            @text = markup[0..-2]
            super
        end

        def render(context)
            %(<code>#{@text}</code>)
        end
    end
end

Liquid::Template.register_tag('param', Jekyll::FuccboiParam)
