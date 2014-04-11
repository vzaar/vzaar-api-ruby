module Vzaar
  module Request
    class WhoAmI < Base
      authenticated true

      private

      def base_url
        '/api/test/whoami'
      end

      def format_suffix
        nil
      end
    end
  end
end
