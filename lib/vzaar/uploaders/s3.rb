module Vzaar
  module Uploaders
    class S3 < Struct.new(:path, :signature)
      SEND_TIMEOUT = 1800

      def upload
        client = HTTPClient.new
        client.send_timeout = SEND_TIMEOUT

        begin
          file = File.open(path)
          res = client.post url, [
            ['acl', signature.acl],
            ['bucket', signature.bucket],
            ['success_action_status', '201'],
            ['policy', signature.policy],
            ['AWSAccessKeyId', signature.access_key_id],
            ['signature', signature.signature],
            ['key', signature.key],
            ['file', file]
          ]
        ensure
          file.close if file
        end
        res.status_code == 201
      end

      def url
        "https://#{signature.bucket}.s3.amazonaws.com/"
      end
    end
  end
end
