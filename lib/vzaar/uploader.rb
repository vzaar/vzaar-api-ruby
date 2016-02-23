require_relative "uploaders/s3"

module Vzaar
  class Uploader < Struct.new(:conn, :signature, :opts)
    attr_reader :guid

    def upload
      begin
        if link_upload?
          link
        else
          result = s3.upload
          if result[:success]
            opts[:chunks] = result[:total_chunks]
            yield(self) if block_given?
          end
        end
      rescue Exception => e
        raise(Vzaar::Error, "Upload error: " + e.message)
      end
    end

    def processing_params
      opts.merge guid: guid
    end

    private

    def link_upload?
      opts[:url]
    end

    def guid
      signature.guid
    end

    def s3
      Uploaders::S3.new(opts[:path], signature)
    end

    def link
      _opts = opts.merge({ guid: guid, key: signature.key })
      Request::LinkUpload.new(conn, _opts).execute
    end
  end
end
