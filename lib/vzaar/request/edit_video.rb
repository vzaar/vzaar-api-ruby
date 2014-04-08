module Vzaar
  module Request
    class EditVideo

      attr_reader :options

      def initialize(options)
        @options = options
      end

      def xml
        <<-XML
          <?xml version="1.0" encoding="UTF-8"?>
          <vzaar-api>
            <video>
              <title>#{options[:title]}</title>
              <description>#{options[:description]}</description >
            </video>
          </vzaar-api>
        XML
      end

    end
  end
end
