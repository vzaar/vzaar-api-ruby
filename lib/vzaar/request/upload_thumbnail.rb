module Vzaar
  module Request
    class UploadThumbnail < Video
      endpoint { |o| "/api/videos/#{o.video_id}/upload_thumb" }
      authenticated true
      http_verb :post
      resource "UploadThumbnail"

      def data
        { file: File.open(options[:path]) }
      end
    end
  end
end
