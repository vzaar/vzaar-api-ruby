module Vzaar
  module Request
    class ProcessVideo < Base
      authenticated true
      http_verb Http::POST

      private

      def base_url
        '/api/videos'
      end

      def format_suffix
        nil
      end


      def data
        request_xml = %{
          <?xml version="1.0" encoding="UTF-8"?>
          <vzaar-api>
            <video>
              <guid>#{options[:guid]}</guid>
              <title>#{options[:title]}</title>
              <description>#{options[:description]}</description>
              <profile>#{options[:profile]}</profile>
        }

        if !options[:transcoding].nil?
          request_xml += %{
              <transcoding>#{options[:transcoding]}</transcoding>
          }
        end

        if options[:replace_id]
          request_xml += %{
              <replace_id>#{options[:replace_id]}</replace_id>
          }
        end

        if options[:profile] == 6 && options[:width] && options[:bitrate]
          request_xml += %{
              <encoding>
                <width>#{options[:width]}</width>
                <bitrate>#{options[:bitrate]}</bitrate>
              </encoding>
          }
        end

        request_xml += %{
            </video>
          </vzaar-api>
        }

        request_xml
      end

    end
  end
end
