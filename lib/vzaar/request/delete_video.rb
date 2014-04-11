module Vzaar
  module Request
    class DeleteVideo < Base
      endpoint { |o| "/api/videos/#{o.video_id}" }
      authenticated true
      http_verb Http::DELETE

      def video_id
        options[:video_id]
      end
    end
  end
end
