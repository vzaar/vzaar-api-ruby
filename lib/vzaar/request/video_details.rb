module Vzaar
  module Request
    class VideoDetails < Base
      endpoint { |o| "/api/videos/#{o.video_id}" }

      def video_id
        options[:video_id]
      end
    end
  end
end
