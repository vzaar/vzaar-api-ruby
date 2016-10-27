module VzaarApi
  class CategoryCollection

    attr_reader :collection, :meta

    def initialize(response)
      @collection = build_collection(response.data)
      @meta = response.meta
    end

    def each
      return enum_for :each unless block_given?
      @collection.each { |record| yield record }
    end

    private

    def build_collection(items)
      items.map { |attrs| Category.new attrs }
    end

  end
end
