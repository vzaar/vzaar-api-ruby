module Vzaar
  module Request
    class GenerateThumbnail < Video
      endpoint { |o| "/api/videos/#{o.video_id}/generate_thumb" }
      authenticated true
      http_verb :post
      resource "Status"

      def xml_body
        <<-XML
          <?xml version="1.0" encoding="UTF-8"?>
          <vzaar-api>
            <video>
              <thumb_time>#{options[:time]}</thumb_time>
            </video>
          </vzaar-api>
        XML
      end

    end
  end
end
