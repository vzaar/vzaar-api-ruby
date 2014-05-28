module Vzaar
  module Request
    class GenerateThumbnail < Video
      endpoint { |o| "/api/videos/#{o.video_id}/generate_thumb" }
      authenticated true
      http_verb :post
      resource "Status"

      def xml_body
        <<-XML
          <?xml version="1.0" encoding="UTF-8"?>#{hash_to_xml(json_body)}
        XML
      end

      def json_body
        { "vzaar-api" => { "video" => { "thumb_time" => options[:time] }}}
      end
    end
  end
end
