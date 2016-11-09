module VzaarApi
  module Signature
    class Single

      ENDPOINT = 'signature/single'

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
      end

      def multipart?
        false
      end

      def self.create(attrs = {})
        url = Api.resource_url ENDPOINT
        new Api.new.post(url, attrs).data
      end

    end
  end
end
