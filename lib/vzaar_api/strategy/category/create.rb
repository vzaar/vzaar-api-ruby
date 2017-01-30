module VzaarApi
  module Strategy
    module Category
      class Create

        attr_reader :attrs, :category_class

        def initialize(attrs, category_class)
          @attrs = attrs
          @category_class = category_class
        end

        def execute
          if attrs.has_key?(:name)
            create
          else
            raise Error.new('Invalid parameters: :name must be supplied')
          end
        end

        private

        def create
          url = Lib::Api.resource_url category_class::ENDPOINT
          category_class.new Lib::Api.new.post(url, attrs).data
        end
      end
    end
  end
end
