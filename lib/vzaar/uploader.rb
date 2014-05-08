require_relative "uploaders/s3"

module Vzaar
  class Uploader < Struct.new(:conn, :signature, :opts)
    attr_reader :guid

    def upload
      begin
        if link_upload?
          link
        else
          success = s3.upload
          yield(self) if block_given? && success
        end
      rescue Exception => e
        Vzaar::Error.generate :unknown, e.message
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
