module Vzaar
  module Request
    class AddSubtitle < Base
      endpoint "/api/subtitle/upload"
      resource "Status"
      http_verb :post
      authenticated true

      def xml_body
        <<-XML
          <?xml version="1.0" encoding="UTF-8"?>#{hash_to_xml(json_body)}
        XML
      end

      def json_body
        { "vzaar-api" => {
            "subtitle" => {
              "language" => options[:language],
              "video_id" => options[:video_id],
              "body" => sanitize_str(options[:body])
            }
          }
        }
      end
    end
  end
end
