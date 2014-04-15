module Vzaar
  module Request
    class LinkUpload < Base
      endpoint "/api/upload/link"
      authenticated true
      http_verb Http::POST
      resource "LinkUpload"

      def json_body
        h = {
          vzaar_api: {
            link_upload: {
              key: options[:key],
              guid: options[:guid],
              url: options[:url]
            }
          }
        }
        JSON.generate(h)
      end

      def xml_body
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
