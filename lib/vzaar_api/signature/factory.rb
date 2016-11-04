module VzaarApi
  module Signature
    class Factory

      # 5MB is min size required for multipart upload
      MIN_S3_MULTIPART_FILE_SIZE = 5 * (1024 ** 2)

      attr_reader :attrs

      def initialize(attrs)
        @attrs = attrs
      end

      def self.create(attrs)
        new(attrs).create
      end

      def create
        klass = multipart? ? Multipart : Single
        klass.create(multipart_attrs)
      end

      def multipart?
        multipart_attrs[:filesize].to_i >= MIN_S3_MULTIPART_FILE_SIZE
      end

      def multipart_attrs
        {
          filesize: File::Stat.new(attrs[:path]).size,
          filename: File.basename(attrs[:path]),
          uploader: UPLOADER
        }
      rescue Errno::ENOENT
        raise Error.new 'Invalid parameters: path is invalid'
      end

    end
  end
end
