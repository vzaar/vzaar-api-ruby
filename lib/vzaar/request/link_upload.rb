module Vzaar
  module Request
    class LinkUpload < Base
      endpoint "/api/upload/link"
      authenticated true
      http_verb :post
      resource "LinkUpload"

      def xml_body
        <<-XML
          <?xml version="1.0" encoding="UTF-8"?>
          <vzaar-api>
            <link_upload>
              <key>#{options[:key]}</key>
              <guid>#{options[:guid]}</guid>
              <url>#{options[:url]}</url>
              <encoding_params>
                <title>#{options[:title]}</title>
                <description>#{options[:description]}</description>
                <profile>#{options[:profile]}</profile>
                <bitrate>#{options[:bitrate]}</bitrate>
                <width>#{options[:width]}</width>
                <replace_id>#{options[:replace_id]}</replace_id>
                <transcoding>#{options[:transcoding]}</transcoding>
              </encoding_params>
            </link_upload>
          </vzaar-api>
        XML
      end

    end
  end
end
