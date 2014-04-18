module Vzaar
  module Request
    class EditVideo < Video
      authenticated true
      http_verb Http::PUT
      resource "Video"

      def xml_body
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
