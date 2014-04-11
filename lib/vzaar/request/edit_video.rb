module Vzaar
  module Request
    class EditVideo < Base
      authenticated true
      http_verb Http::PUT

      private

      def base_url
        "/api/videos/#{video_id}"
      end

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
