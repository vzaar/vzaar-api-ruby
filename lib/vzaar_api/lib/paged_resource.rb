module VzaarApi
  module Lib
    class PagedResource

      attr_reader :query, :meta, :collection, :resource_class, :resource_url

      def initialize(query = {})
        @query = query.dup
        @resource_class = @query.delete(:resource_class)
        @resource_url = @query.delete(:resource_url)
        @loaded = false
      end

      def loaded?
        @loaded
      end

      def each_item
        return enum_for :each_item unless block_given?
        begin
          each { |record| yield record }
        end while self.next
      end

      def first
        if loaded?
          load_page_url :first
        else
          load!
        end
      end

      def next
        load! unless loaded?
        load_page_url :next
      end

      def previous
        load! unless loaded?
        load_page_url :previous
      end

      def last
        load! unless loaded?
        load_page_url :last
      end

      private

      def load!
        load_from_url resource_url, query
        @loaded = true
        self
      end

      def load_page_url(page)
        return nil unless meta
        url = meta[:links][page]
        load_from_url(url) if url
      end

      def each
        return enum_for :each unless block_given?
        load! unless collection
        collection.each { |record| yield record }
      end

      def load_from_url(url, query = {})
        response = Api.new.get(url, query)
        @meta = response.meta
        @collection = build_collection response.data
      end

      def build_collection(items)
        items.map { |attrs| resource_class.new attrs }
      end

    end
  end
end
