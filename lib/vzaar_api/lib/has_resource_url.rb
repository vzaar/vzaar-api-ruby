module VzaarApi
  module Lib
    module HasResourceUrl

      def self.included(base)
        base.include(InstanceMethods)
        base.extend(ClassMethods)
      end

      module InstanceMethods
        def resource_url(path = nil, scope_id = nil)
          self.class.resource_url(path, scope_id)
        end
      end

      module ClassMethods
        def resource_url(path=nil, scope_id=nil)
          ep = self::ENDPOINT
          args = ep.is_a?(Proc) ? [ep.call(scope_id, path), nil] : [ep, path]

          Api.resource_url *args
        end
      end

    end
  end
end
