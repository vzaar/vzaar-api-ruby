module Vzaar
  module Request
    class UserDetails < Base

      private

      def base_url
        "/api/users/#{login}"
      end

      def login
        options[:login]
      end
    end
  end
end
