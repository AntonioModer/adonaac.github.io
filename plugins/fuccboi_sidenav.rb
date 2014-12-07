module Jekyll
    class FuccboiSidenav < Liquid::Tag

        def initialize(name, markup, tokens)
            @elements = markup.scan(/\S+/)
            super
        end

        def render(context)
            output = ''
            @elements.each do |t|
                output += '<li data-magellan-arrival="' + t + '"><a href="#' + t + '">' + t + '</a></li>'
            end
            return output
        end
    end
end

Liquid::Template.register_tag('sidenav', Jekyll::FuccboiSidenav)
