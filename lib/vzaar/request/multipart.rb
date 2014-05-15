module Vzaar
  module Request
    class Multipart < Struct.new(:path, :file)
      CRLF = "\r\n".freeze

      def request
        req = Net::HTTP::Post.new(path)
        req.body = build_body
        req["Content-Type"] = "multipart/form-data; boundary=#{boundary}"
        req["Content-Length"] = req.body.size
        req
      end

      private

      def build_body
        body = ""
        body << "--#{boundary}#{CRLF}"
        body << "Content-Disposition: form-data;"\
        " name=\"vzaar-api[thumbnail]\"; filename=\"#{filename}\"#{CRLF}"

        body << "Content-Type: image/#{file_format}#{CRLF*2}"
        body << file.read
        body << CRLF
        body << "--#{boundary}--#{CRLF*2}"
        body
      end

      def boundary
        @boundary ||= Time.now.to_i.to_s(16)
      end

      def filename
        File.basename(file.path)
      end

      def file_format
        filename.split(/\./).last
      end
    end
  end
end
