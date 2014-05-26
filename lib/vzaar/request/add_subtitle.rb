module Vzaar
  module Request
    class AddSubtitle < Base
      endpoint "/api/subtitle/upload"
      resource "Status"
      http_verb :post
      authenticated true

      def xml_body
        <<-XML
          <?xml version="1.0" encoding="UTF-8"?>
          <vzaar-api>
            <subtitle>
              <language>#{options[:language]}</language>
              <video_id>#{options[:video_id]}</video_id>
              <body>#{options[:body]}</body>
            </subtitle>
          </vzaar-api>
        XML
      end
    end
  end
end
