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
        end while !self.next.empty?
      end

      def first
        loaded? ? load_page_url(:first) : load!
      end

      def next
        load_page_url :next
      end

      def previous
        load_page_url :previous
      end

      def last
        load_page_url :last
      end

      private

      def load!
        @loaded = true
        load_from_url resource_url, query
      end

      def load_page_url(page)
        load! unless loaded?
        if url = meta_link(page)
          load_from_url meta[:links][page]
        else
          []
        end
      end

      def meta_link(page)
        return unless meta
        meta[:links][page]
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
