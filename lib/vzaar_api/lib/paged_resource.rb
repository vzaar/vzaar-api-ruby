module VzaarApi
  module Lib
    class PagedResource

      attr_reader :query, :meta, :collection, :resource_class, :resource_url

      def initialize(query = {})
        @query = query.dup
        @resource_class = @query.delete(:resource_class)
        @resource_url = @query.delete(:resource_url)
      end

      def each
        return enum_for :each unless block_given?
        begin
          _each { |record| yield record }
        end while self.next
      end

      def first
        return nil unless meta
        url = meta[:links][:first]
        load_from_url(url) if url
      end

      def next
        return nil unless meta
        url = meta[:links][:next]
        load_from_url(url) if url
      end

      def previous
        return nil unless meta
        url = meta[:links][:previous]
        load_from_url(url) if url
      end

      def last
        return nil unless meta
        url = meta[:links][:last]
        load_from_url(url) if url
      end

      def load!
        load_from_url resource_url, query
        self
      end

      private

      def _each
        return enum_for :_each unless block_given?
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
