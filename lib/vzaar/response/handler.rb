module Vzaar
  module Response
    class Handler
      # JC: refactor this
      def self.handle_response(response)
        case response.code
        when Http::OK
          response
        when Http::ERROR
          response
        when Http::CREATED
          response
        when Http::FORBIDDEN
          response
        when Http::NOT_AUTHORISED
          handle_exception :protected_resource
        when Http::NOT_FOUND
          handle_exception :not_found
        else
          handle_exception :unknown
        end
      end

      def self.handle_exception(type, custom_message = '')
        Vzaar::Error.generate type, custom_message
      end

    end
  end
end
