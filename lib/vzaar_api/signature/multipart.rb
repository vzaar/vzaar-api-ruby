module VzaarApi
  module Signature
    class Multipart < Abstract

      include Lib::HasResourceUrl

      ENDPOINT = 'signature/multipart'

      attr_reader :upload_hostname, :part_size, :part_size_in_bytes, :parts

      def after_initialize(attrs = {})
        @part_size = attrs[:part_size]
        @part_size_in_bytes = attrs[:part_size_in_bytes]
        @parts = attrs[:parts]
      end

      def multipart?
        true
      end

    end
  end
end
