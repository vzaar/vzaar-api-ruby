module VzaarApi
  module Upload
    class S3
      extend Forwardable

      SEND_TIMEOUT = 1800

      attr_reader :attrs, :path, :signature

      def_delegators :@signature, :access_key_id, :acl, :bucket,
        :guid, :key, :multipart?, :part_size_in_bytes, :policy,
        :success_action_status, :upload_hostname, :x_amz_headers

      def initialize(attrs, signature)
        @attrs = attrs.dup
        @path = @attrs.delete(:path)
        @signature = signature
      end

      def execute
        if multipart?
          multipart_upload
        else
          single_part_upload
        end
        attrs.merge({ guid: guid })
      end

      private

      def multipart_upload
        _headers = headers.dup
        chunk = 0
        File.open(path, "r") do |file|
          until file.eof?
            _headers['key'] = "#{key}.#{chunk}"
            _headers['file'] = VirtualFile.new(file, part_size_in_bytes)
            validate_response! upload_file(_headers)
            chunk += 1
          end
        end
      rescue => e
        raise Error.new(e.message)
      end

      def single_part_upload
        File.open(path, "r") do |file|
          _headers = headers.dup
          _headers['key'] = key
          _headers['file'] = file
          validate_response! upload_file(_headers)
        end
      rescue => e
        raise Error.new(e.message)
      end

      def upload_file(headers)
        http_client.post upload_hostname, headers
      end

      def headers
        @headers ||= {
          'acl' => acl,
          'bucket' => bucket,
          'success_action_status' => success_action_status,
          'policy' => policy,
          'x-amz-meta-uploader' => UPLOADER
        }.merge! x_amz_headers
      end

      def http_client
        @http_client ||= begin
          HTTPClient.new.tap { |c| c.send_timeout = SEND_TIMEOUT }
        end
      end

      def validate_response!(response)
        return if response.ok?
        raise error_message(response.body)
      end

      def error_message(body)
        /Message\>(.+)\<\/Message/.match(body)[1]
      end

    end
  end
end
