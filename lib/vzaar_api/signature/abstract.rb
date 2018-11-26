module VzaarApi
  module Signature
    class Abstract

      include Lib::HasResourceUrl

      attr_reader :access_key_id, :acl, :bucket, :content_type,
        :guid, :key, :policy, :success_action_status,
        :upload_hostname, :x_amz_headers

      X_AMZ_HEADERS = [
        "x-amz-credential",
        "x-amz-algorithm",
        "x-amz-date",
        "x-amz-signature"
      ]


      def initialize(attrs = {})
        @access_key_id = attrs[:access_key_id]
        @acl = attrs[:acl]
        @bucket = attrs[:bucket]
        @guid = attrs[:guid]
        @key = attrs[:key]
        @policy = attrs[:policy]
        @success_action_status = attrs[:success_action_status]
        @upload_hostname = attrs[:upload_hostname]
        @x_amz_headers = build_x_amz_headers(attrs)
        after_initialize(attrs)
      end

      def after_initialize(attrs = {})
        raise Error.new('Cannot call #after_initialize on Signature::Abstract')
      end

      def multipart?
        raise Error.new('Cannot call #multipart? on Signature::Abstract')
      end

      def self.create(attrs = {})
        attrs[:uploader] = UPLOADER
        new Lib::Api.new.post(resource_url, attrs).data
      end

      def build_x_amz_headers(attrs)
        X_AMZ_HEADERS.reduce({}) do |col, key|
          col[key] = attrs[key.to_sym]
          col
        end
      end
    end
  end
end
