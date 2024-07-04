module Jekyll
    module StringFilters
      EXCEPTIONS = {
        "iMovie" => "imovie",
        "iTunesStore" => "itunes-store",
        "iTunesRemote" => "itunes-remote",
        "iTunesU" => "itunes-u"
      }
  
      def formatize(input)
        if EXCEPTIONS.key?(input)
          EXCEPTIONS[input]
        else
          input.gsub(/([A-Z])/, '-\1').downcase.sub(/^-/, '')
        end
      end
    end
  end
  
  Liquid::Template.register_filter(Jekyll::StringFilters)
  