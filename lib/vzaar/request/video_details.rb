module Vzaar
  module Request
    class VideoDetails < Base
      def execute
        conn.using_connection(url, user_options) do |body|
          return Response::VideoDetails.new(video_id, body)
        end
      end

      private

      def user_options
        super.merge authenticated: options[:authenticated]
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
