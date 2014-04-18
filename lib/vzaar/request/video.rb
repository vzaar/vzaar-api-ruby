module Vzaar
  module Request
    class Video < Base
      endpoint { |o| "/api/videos/#{o.video_id}" }
      resource :video

      def video_id
        options[:video_id]
      end
    end
  end
end
