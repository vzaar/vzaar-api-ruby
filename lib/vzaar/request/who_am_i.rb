module Vzaar
  module Request
    class WhoAmI < Base
      endpoint '/api/test/whoami'
      authenticated true
      resource "WhoAmI"

      def format_suffix
        nil
      end
    end
  end
end
