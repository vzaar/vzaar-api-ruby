module Vzaar
  module Request
    class EditVideo < Base

      private

      def authenticated?
        true
      end

      def http_verb
        Http::PUT
      end

      def base_url
        "/api/videos/#{video_id}"
      end

      def data
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
