module VzaarApi
  module Lib
    module HasCollectionBuilder

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def build(data = [])
          Array(data).map { |attrs| new attrs }
        end
      end

    end
  end
end
