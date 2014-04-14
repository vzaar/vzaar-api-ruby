module Vzaar
  module Request
    class LinkUpload < Base
      endpoint "/api/link_upload"
      http_verb Http::POST

      def json
        #TODO
      end

      def xml
        <<-XML
          <?xml version="1.0" encoding="UTF-8"?>
          <vzaar-api>
            <link_upload>
              <key>#{options[:key]}</key>
              <guid>#{options[:guid]}</guid>
              <url>#{options[:url]}</url>
            </link_upload>
          </vzaar-api>
        XML
      end

    end
  end
end
