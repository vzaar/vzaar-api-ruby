module Vzaar
  module Uploaders
    class S3 < Struct.new(:path, :signature_hash)
      SEND_TIMEOUT = 1800

      def upload
        client = HTTPClient.new
        client.send_timeout = SEND_TIMEOUT
        begin
          file = File.open(path)
          res = client.post url, [
            ['acl', signature_hash[:acl]],
            ['bucket', signature_hash[:bucket]],
            ['success_action_status', '201'],
            ['policy', signature_hash[:policy]],
            ['AWSAccessKeyId', signature_hash[:aws_access_key]],
            ['signature', signature_hash[:signature]],
            ['key', signature_hash[:key]],
            ['file', file]
          ]
        ensure
          file.close if file
        end
        res.status_code.to_s == Http::CREATED
      end

      def url
        "https://#{signature_hash[:bucket]}.s3.amazonaws.com/"
      end
    end
  end
end
