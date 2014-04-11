module Vzaar
  module Request
    class DeleteVideo < Base
      authenticated true
      http_verb Http::DELETE

      def base_url
        "/api/videos/#{video_id}"
      end

      def video_id
        options[:video_id]
      end
    end
  end
end
