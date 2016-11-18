module VzaarApi
  module Lib
    module HasResourceUrl

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def resource_url(path = nil)
          Api.resource_url self::ENDPOINT, path
        end
      end

    end
  end
end
