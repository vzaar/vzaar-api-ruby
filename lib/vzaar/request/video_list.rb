module Vzaar
  module Request
    class VideoList < Base
      endpoint { |o| "/api/#{o.login}/videos" }
      resource "VideoCollection"

      def url_params
        super.merge({ page: options[:page] || 1 })
      end

      def login
        options[:login]
      end
    end
  end
end
