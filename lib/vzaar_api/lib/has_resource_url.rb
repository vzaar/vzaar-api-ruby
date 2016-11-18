module VzaarApi
  module Lib
    module HasResourceUrl

      def self.included(base)
        base.include(InstanceMethods)
        base.extend(ClassMethods)
      end

      module InstanceMethods
        def resource_url(path = nil)
          self.class.resource_url(path)
        end
      end

      module ClassMethods
        def resource_url(path = nil)
          Api.resource_url self::ENDPOINT, path
        end
      end

    end
  end
end
