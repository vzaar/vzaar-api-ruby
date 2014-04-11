module Vzaar
  module Request
    class EditVideo < Base
      endpoint { |o| "/api/videos/#{o.video_id}" }
      authenticated true
      http_verb Http::PUT

      def xml
        <<-XML
          <?xml version="1.0" encoding="UTF-8"?>
          <vzaar-api>
            <video>
              <title>#{options[:title]}</title>
              <description>#{options[:description]}</description >
            </video>
          </vzaar-api>
        XML
      end

      def video_id
        options[:video_id]
      end
    end
  end
end
