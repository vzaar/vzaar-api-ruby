module Vzaar
  module Request
    class UploadStatus < Base
      endpoint { |o| "/api/link_upload/#{o.guid}" }

      def guid
        options[:guid]
      end
    end
  end
end
