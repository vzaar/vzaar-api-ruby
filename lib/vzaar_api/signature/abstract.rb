module VzaarApi
  module Signature
    class Abstract

      include Lib::HasResourceUrl

      attr_reader :access_key_id, :acl, :bucket, :content_type,
        :guid, :key, :policy, :signature, :success_action_status,
        :upload_hostname

      def initialize(attrs = {})
        @access_key_id = attrs[:access_key_id]
        @acl = attrs[:acl]
        @bucket = attrs[:bucket]
        @content_type = attrs[:content_type]
        @guid = attrs[:guid]
        @key = attrs[:key]
        @policy = attrs[:policy]
        @signature = attrs[:signature]
        @success_action_status = attrs[:success_action_status]
        @upload_hostname = attrs[:upload_hostname]
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

    end
  end
end
