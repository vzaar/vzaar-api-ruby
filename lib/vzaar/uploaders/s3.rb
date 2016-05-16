module Vzaar
  module Uploaders
    class S3 < Struct.new(:path, :signature)
      SEND_TIMEOUT = 1800

      def upload
        if signature.chunk_size.to_s.empty?
          single_part_upload
        else
          multipart_upload
        end
      end

      class VirtualFile < StringIO
        attr_reader :path
        def initialize(file, chunk_size)
          @path = File.basename file.path
          super file.read(chunk_size)
        end
      end

      private

      def single_part_upload
        File.open(path, "r") do |file|
          _headers = headers.dup
          _headers['chunk'] = '0'
          _headers['chunks'] = '0'
          _headers['key'] = signature.key
          _headers['file'] = file
          res = http_client.post url, _headers
          { success: res.status_code == 201 }
        end
      end

      def file_size
        @file_size ||= File.stat(path).size
      end

      def chunk_size_bytes
        @chunk_size_bytes ||= signature.chunk_size.to_i * (1024 ** 2)
      end

      def total_chunks
        @total_chunks ||= begin
          val = file_size / chunk_size_bytes
          val += 1 if (file_size % chunk_size_bytes) > 0
          val
        end
      end

      def multipart_upload
        _headers = headers.dup
        _headers['chunks'] = total_chunks

        chunk = 0
        File.open(path, "r") do |file|
          until file.eof?
            _headers['chunk'] = chunk
            _headers['x-amz-meta-uploader'] = "Ruby #{VERSION}"
            _headers['key'] = "#{signature.key}.#{chunk}"
            _headers['file'] = VirtualFile.new(file, chunk_size_bytes)

            res = http_client.post url, _headers
            unless res.status_code == 201
              return { success: false }
            end
            chunk += 1
          end
        end
        { success: true, total_chunks: total_chunks }
      end

      def headers
        @headers ||= {
          'acl' => signature.acl,
          'bucket' => signature.bucket,
          'success_action_status' => '201',
          'policy' => signature.policy,
          'AWSAccessKeyId' => signature.access_key_id,
          'signature' => signature.signature
        }
      end

      def http_client
        @http_client ||= begin
          HTTPClient.new.tap { |c| c.send_timeout = SEND_TIMEOUT }
        end
      end

      def url
        signature.upload_hostname
      end
    end
  end
end
