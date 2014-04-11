module Vzaar
  module Request
    class VideoList < Base
      endpoint { |o| "/api/#{o.login}/videos" }

      def url_params
        { page: options[:page] || 1 }
      end

      def login
        options[:login]
      end
    end
  end
end
