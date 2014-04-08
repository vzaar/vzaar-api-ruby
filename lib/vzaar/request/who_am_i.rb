module Vzaar
  module Request
    class WhoAmI < Base

      private

      def authenticated?
        true
      end

      def base_url
        '/api/test/whoami'
      end

      def format_suffix
        nil
      end
    end
  end
end
