require_relative "uploaders/s3"
require_relative "uploaders/link"

module Vzaar
  class Uploader < Struct.new(:conn, :signature, :opts)
    attr_reader :guid

    def upload
      begin
        success = (link_upload? ? link : s3).upload
        yield(self) if block_given? && success
      rescue Exception => e
        VzaarError.generate :unknown, e.message
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
      Uploaders::Link.new(conn, signature, opts)
    end
  end
end
