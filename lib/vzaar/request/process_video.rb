module Vzaar
  module Request
    class ProcessVideo < Base
      endpoint '/api/videos'
      authenticated true
      http_verb :post
      resource "ProcessedVideo"

      private

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
        raise Vzaar::Error, "Guid required to process video." unless options[:guid]

        h = options.dup.delete_if { |k,v| v.nil? }

        if include_encoding_options?
          width = h.delete(:width)
          bitrate = h.delete(:bitrate)

          h[:encoding] = {width: width, bitrate: bitrate}
        end

        { vzaar_api: {
            video: h
          }
        }
      end

      def include_encoding_options?
        options[:profile] == 6 && options[:width] && options[:bitrate]
      end
    end
  end
end
