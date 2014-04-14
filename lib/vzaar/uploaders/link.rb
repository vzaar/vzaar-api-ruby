module Vzaar
  module Uploaders
    class Link < Struct.new(:conn, :path, :signature_hash)
      def upload
        Request::LinkUpload.new(conn, params).execute
      end

      private

      def params
        { guid: signature_hash[:guid],
          key: signature_hash[:key],
          format: opts[:format],
          url: path }
      end
    end
  end
end
