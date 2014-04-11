module Vzaar
  module Request
    class AccountType < Base
      endpoint { |o| "/api/accounts/#{o.account_type_id}" }

      def account_type_id
        options[:account_type_id]
      end
    end
  end
end
