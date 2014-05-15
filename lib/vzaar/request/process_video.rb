module Vzaar
  module Request
    class ProcessVideo < Base
      endpoint '/api/videos'
      authenticated true
      http_verb :post
      resource "ProcessedVideo"

      private

      def json_body
        h = {
          "vzaar_api" =>  {
            "video" =>  {
              "guid" =>  options[:guid],
              "title" =>  options[:title],
              "description" =>  options[:description],
              "profile" =>  options[:profile],
              "transcoding" =>  options[:transcoding],
              "replace_id" => options[:replace_id]
            }
          }
        }.delete_if { |k,v| v.nil? }

        if include_encoding_options?
          return h.merge({ "encoding" => {
                             "width" => options[:width],
                             "bitrate" => options[:bitrate]
                           }
                         })
        end
        h
      end

      def include_encoding_options?
        options[:profile] == 6 && options[:width] && options[:bitrate]
      end

      def xml_body
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

        if include_encoding_options?
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
