module VzaarApi
  class Category

    attr_reader :id, :account_id, :user_id, :name, :description,
      :parent_id, :depth, :node_children_count, :tree_children_count,
      :node_video_count, :tree_video_count, :created_at, :updated_at

    def initialize(attrs = {})
      @id = attrs[:id]
      @account_id = attrs[:account_id]
      @user_id = attrs[:user_id]
      @name = attrs[:name]
      @description = attrs[:description]
      @parent_id = attrs[:parent_id]
      @depth = attrs[:depth]
      @node_children_count = attrs[:node_children_count]
      @tree_children_count = attrs[:tree_children_count]
      @node_video_count = attrs[:node_video_count]
      @tree_video_count = attrs[:tree_video_count]
      @created_at = attrs[:created_at]
      @updated_at = attrs[:updated_at]
    end

    def self.find(category_id)
      url = resource_url(category_id)
      response = Api.new.get(url)
      new response.data
    end

    def self.paginate(query = {})
      PagedResource.new(query)
    end

    def self.find_each(query = {}, &block)
      paginate(query).find_each(&block)
    end

    def self.all(query = {})
      paginate(query).each.to_a
    end

    def self.resource_url(path = nil)
      ["https://#{VzaarApi.hostname}/api/v2/categories", path].compact.join('/')
    end

    class PagedResource
      attr_reader :query

      def initialize(query = {})
        @query = query
      end

      def find_each
        return enum_for :find_each unless block_given?
        begin
          each { |record| yield record }
        end while self.next
      end

      def each
        return enum_for :each unless block_given?
        load! unless @collection
        @collection.each { |record| yield record }
      end

      def next
        return nil unless @collection.meta
        url = @collection.meta[:links][:next]
        if url
          @collection = begin
            response = Api.new.get(url)
            CategoryCollection.new response
          end
        end
      end

      def load!
        @collection = begin
          response = Api.new.get(resource_url, query)
          CategoryCollection.new response
        end
      end

      def resource_url(path = nil)
        ["https://#{VzaarApi.hostname}/api/v2/categories", path].compact.join('/')
      end
    end

  end
end
