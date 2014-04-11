module Vzaar
  class S3Uploader

    attr_reader :file_path, :signature

    SEND_TIMEOUT = 1800

    def initialize(file_path, signature)
      @file_path = file_path
      @signature = signature
    end

    def url
      "https://#{signature[:bucket]}.s3.amazonaws.com/"
    end

    def upload
      client = HTTPClient.new
      client.send_timeout = SEND_TIMEOUT
      begin
        file = File.open file_path
        res = client.post url, [
          ['acl', signature[:acl]],
          ['bucket', signature[:bucket]],
          ['success_action_status', '201'],
          ['policy', signature[:policy]],
          ['AWSAccessKeyId', signature[:aws_access_key]],
          ['signature', signature[:signature]],
          ['key', signature[:key]],
          ['file', file]
        ]
      ensure
        file.close if file
      end
      res.status_code.to_s == Http::CREATED
    end

  end
end
