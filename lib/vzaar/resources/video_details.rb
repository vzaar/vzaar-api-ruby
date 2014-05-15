module Vzaar
  module Resource
    module VideoDetails
      def self.new(body, status_code)
        if body =~ /\/vzaar-api/
          Vzaar::Resource::VideoStatus.new(body, status_code)
        else
          Vzaar::Resource::Video.new(body, status_code)
        end
      end
    end
  end
end
