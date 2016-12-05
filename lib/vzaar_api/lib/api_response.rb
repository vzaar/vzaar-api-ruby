module VzaarApi
  module Lib
    class ApiResponse

      attr_reader :response

      def initialize(response)
        @response = response
      end

      def data
        json[:data]
      end

      def meta
        json[:meta]
      end

      def error
        simple_errors.join('; ')
      end

      def ok?
        response.ok?
      end

      def rate_limit
        rate_limit_value 'X-RateLimit-Limit'
      end

      def rate_limit_remaining
        rate_limit_value 'X-RateLimit-Remaining'
      end

      def rate_limit_reset
        rate_limit_value 'X-RateLimit-Reset'
      end

      private

      def rate_limit_value(header)
        if limit = response.headers[header]
          limit.to_i
        else
          nil
        end
      end

      def simple_errors
        json[:errors].map { |e| [e[:message], e[:detail]].join(': ') }
      end

      def json
        @json ||= JSON.parse(response.body, symbolize_names: true)
      rescue JSON::ParserError
        raise Error.new('Invalid JSON response from API')
      end

    end
  end
end
