module Vzaar
  module Response
    class Base < Struct.new(:res)
      include Vzaar::Helper

      def body
        json? ? JSON.parse(res.body) : res.body
      end

      def content_type
        @content_type ||= res.content_type
      end

      def json?
        content_type == "application/json"
      end
    end

    def self.handle_response(response)
      case response.code.to_i
      when 302
        error("Moved Temporarily")
      when 401
        error("Protected Resource")
      when 403
        error("Forbidden")
      when 404
        error("Not Found")
      when 502
        error("Bad Gateway")
      else
        response
      end
    end

    def self.error(msg)
      raise(Vzaar::Error, msg)
    end
  end
end
