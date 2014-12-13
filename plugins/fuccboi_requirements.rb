module Jekyll
    class FuccboiRequirements < Liquid::Tag

        def initialize(name, markup, tokens)
            @elements = markup.split(/\[([^\]]+)\]/)
            print(@elements[0], @elements[1])
            super
        end

        def render(context)
            output = ''

            output += ''
            return output
        end
    end
end

Liquid::Template.register_tag('requirements', Jekyll::FuccboiRequirements)
