module Vzaar
  module Resource
    module VideoDetails
      def self.new(body)
        if body =~ /\/vzaar-api/
          Vzaar::Resource::VideoStatus.new(body)
        else
          Vzaar::Resource::Video.new(body)
        end
      end
    end
  end
end
