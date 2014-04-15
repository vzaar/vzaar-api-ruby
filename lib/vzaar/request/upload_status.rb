module Vzaar
  module Request
    class UploadStatus < Base
      endpoint { |o| "/api/upload/link/#{o.guid}" }
      resource "LinkUpload"

      def guid
        options[:guid]
      end
    end
  end
end
