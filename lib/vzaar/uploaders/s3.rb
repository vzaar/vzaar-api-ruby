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

      def multipart_upload
        client = HTTPClient.new
        client.send_timeout = SEND_TIMEOUT

        file_size = File.stat(path).size
        chunk_size_bytes = signature.chunk_size.to_i * (1024 ** 2)

        total_chunks = file_size / chunk_size_bytes
        total_chunks += 1 if (file_size % chunk_size_bytes) > 0

        headers = {
          'acl' => signature.acl,
          'bucket' => signature.bucket,
          'success_action_status' => '201',
          'policy' => signature.policy,
          'AWSAccessKeyId' => signature.access_key_id,
          'signature' => signature.signature,
          'chunks' => total_chunks
        }

        chunk = 0
        File.open(path, "r") do |file|
          until file.eof?
            headers['chunk'] = chunk
            headers['key'] = "#{signature.key}.#{chunk}"
            headers['file'] = VirtualFile.new(file, chunk_size_bytes)

            res = client.post url, headers
            unless res.status_code == 201
              return { success: false }
            end
            chunk += 1
          end
        end
        { success: true, total_chunks: total_chunks }
      end

      def single_part_upload
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
            ['chunk', '0'],
            ['chunks', '0'],
            ['file', file]
          ]
        ensure
          file.close if file
        end
        { success: res.status_code == 201 }
      end

      def url
        signature.upload_hostname
      end
    end
  end
end
