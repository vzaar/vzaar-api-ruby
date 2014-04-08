module Vzaar
  module Response
    class Handler

      def self.handle_response(response)
        case response.code
        when Http::OK
          response.body
        when Http::CREATED
          response.body
        when Http::NOT_AUTHORISED
          handle_exception :protected_resource
        when Http::NOT_FOUND
          handle_exception :not_found
        else
          handle_exception :unknown
        end
      end

      def self.handle_exception(type, custom_message = '')
        VzaarError.generate type, custom_message
      end

    end
  end
end
