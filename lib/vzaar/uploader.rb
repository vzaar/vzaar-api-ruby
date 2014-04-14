require_relative "uploaders/s3"
require_relative "uploaders/link"

module Vzaar
  class Uploader < Struct.new(:conn, :signature_hash, :opts)
    attr_reader :guid

    def upload
      begin
        (link_upload? ? link : s3).upload
        yield(self) if block_given?
      rescue Exception => e
        VzaarError.generate :unknown, e.message
      end
    end

    def processing_params
      { :guid => guid,
        :title => opts[:title],
        :description => opts[:description],
        :profile => opts[:profile],
        :transcoding => opts[:transcoding]
      }
    end

    private

    def link_upload?
      opts[:url]
    end

    def guid
      signature_hash[:guid]
    end

    def s3
      Uploaders::S3.new(opts[:path], signature_hash)
    end

    def link
      Uploaders::Link.new(conn, signature_hash, opts)
    end
  end
end
