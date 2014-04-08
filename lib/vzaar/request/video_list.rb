module Vzaar
  module Request
    class VideoList < Base

      private

      def base_url
        "/api/#{login}/videos"
      end

      def url_params
        { page: options[:page] || 1 }
      end

      def login
        options[:login]
      end
    end
  end
end
