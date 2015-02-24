module Vzaar
  module Request
    class VideoList < Base
      endpoint { |o| "/api/#{o.login}/videos" }
      resource "VideoList"

      def url_params
        super.merge({ page: options[:page] || 1 })
      end

      def login
        options[:login]
      end
    end
  end
end
