module Jekyll
    class FuccboiAccClose < Liquid::Tag

        def initialize(name, markup, tokens)
            elements = markup.split(/\[([^\]]+)\]/)
            @elements = []
            elements.each do |el|
                @elements.push(el)
            end
            super
        end

        def render(context)
            output = ''
            output += '</div></dd></dl>'
        end
    end
end

Liquid::Template.register_tag('accclose', Jekyll::FuccboiAccClose)
