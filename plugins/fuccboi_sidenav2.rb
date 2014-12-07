module Jekyll
    class FuccboiSidenav2 < Liquid::Tag

        def initialize(name, markup, tokens)
            @elements = markup.split(/\[([^\]]+)\]/).select{|x| x.length > 1}
            super
        end

        def render(context)
            output = ''
            @elements.each do |t|
                output += '<li data-magellan-arrival="' + t.tr(" ", "_") + '"><a href="#' + t.tr(" ", "_") + '">' + t + '</a></li>'
            end
            return output
        end
    end
end

Liquid::Template.register_tag('sidenav2', Jekyll::FuccboiSidenav2)
