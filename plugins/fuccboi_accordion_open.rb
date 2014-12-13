module Jekyll
    class FuccboiAccOpen < Liquid::Tag

        def initialize(name, markup, tokens)
            elements = markup.split(/\[([^\]]+)\]/).select{|x| x.length >= 1}
            @elements = []
            elements.each do |el|
                @elements.push(el)
            end
            super
        end

        def render(context)
            output = ''
            output += '<dl class="accordion" data-accordion><dd><a href="#' + @elements[0] + '">' + @elements[2] + '</a><div id="' + @elements[0] + '" class="content">'
        end
    end
end

Liquid::Template.register_tag('accopen', Jekyll::FuccboiAccOpen)
