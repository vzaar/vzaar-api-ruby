module Vzaar
  module Request
    class DeleteVideo < Base

      private

      def authenticated?
        true
      end

      def http_verb
        Http::DELETE
      end

      def base_url
        "/api/videos/#{video_id}"
      end

      def video_id
        options[:video_id]
      end
    end
  end
end
