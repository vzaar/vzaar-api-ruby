module Vzaar
  module Request
    class UserDetails < Base
      endpoint { |o| "/api/users/#{o.login}" }
      resource :user

      def login
        options[:login]
      end
    end
  end
end
