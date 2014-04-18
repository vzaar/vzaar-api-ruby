module Vzaar
  module Request
    class AccountType < Base
      endpoint { |o| "/api/accounts/#{o.account_type_id}" }
      resource "AccountType"

      def account_type_id
        options[:account_type_id]
      end
    end
  end
end
