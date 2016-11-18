module VzaarApi
  module Lib
    module WillPaginate

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def each_item(query = {}, &block)
          paginate(query).each_item(&block)
        end

        def paginate(query = {})
          args = query.merge({ resource_url: resource_url, resource_class: self })
          Lib::PagedResource.new(args)
        end
      end

    end
  end
end
