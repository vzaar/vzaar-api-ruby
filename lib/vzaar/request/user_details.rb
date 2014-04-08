module Vzaar
  module Request
    class UserDetails < Base
      def execute
        conn.using_connection(url, user_options) do |xml|
          return Response::UserDetails.new(xml)
        end
      end

      private

      def user_options
        super.merge authenticated: options[:authenticated]
      end

      def base_url
        "/api/users/#{login}"
      end

      def login
        options[:login]
      end
    end
  end
end
