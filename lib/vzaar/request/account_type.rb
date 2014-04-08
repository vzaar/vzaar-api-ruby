module Vzaar
  module Request
    class AccountType < Base

      private

      def authenticated?
        false
      end

      def base_url
        "/api/accounts/#{account_type_id}"
      end

      def account_type_id
        options[:account_type_id]
      end
    end
  end
end
