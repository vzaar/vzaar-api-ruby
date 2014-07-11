module Vzaar
  module Request
    class LinkUpload < Base
      endpoint "/api/upload/link"
      authenticated true
      http_verb :post
      resource "LinkUpload"

      def xml_body
        <<-XML
          <?xml version="1.0" encoding="UTF-8"?>#{hash_to_xml(json_body)}
        XML
      end

      def json_body
        { "vzaar-api" => {
            link_upload: {
              key: options[:key],
              guid: options[:guid],
              url: options[:url],
              encoding_params: {
                title: options[:title],
                description: options[:description],
                size_id: options[:profile],
                bitrate: options[:bitrate],
                width: options[:width],
                replace_id: options[:replace_id],
                transcoding: options[:transcoding]
              }
            }
          }
        }
      end
    end
  end
end
