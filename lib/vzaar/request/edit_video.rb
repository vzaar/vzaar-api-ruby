module Vzaar
  module Request
    class EditVideo < Video
      authenticated true
      http_verb :put
      resource "Video"

      # JC: duplicated, refactor
      def json_body
        get_opts.to_json
      end

      def xml_body
        request_xml = %{
          <?xml version="1.0" encoding="UTF-8"?>
          #{hash_to_xml(get_opts)}
        }

        request_xml
      end

      def get_opts
        { "vzaar-api" => {
            "video" => {
              "title" => options[:title],
              "seo_url" => options[:seo_url],
              "description" => options[:description],
              "private" => options[:private]
            }
          }
        }
      end
    end
  end
end
