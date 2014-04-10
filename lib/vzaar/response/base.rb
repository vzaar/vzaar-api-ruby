module Vzaar
  module Response
    class Base < Struct.new(:res)

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
  end
end
