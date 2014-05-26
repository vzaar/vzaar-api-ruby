module Vzaar
  module Request
    class UploadThumbnail < GenerateThumbnail
      endpoint { |o| "/api/videos/#{o.video_id}/upload_thumb" }

      def data
        { file: File.open(options[:path]) }
      end
    end
  end
end
