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

    def subtree(query = {})
      args = query.merge({
        resource_url: self.class.resource_url("#{id}/subtree"),
        resource_class: self.class })
      PagedResource.new(args)
    end

    def self.find(category_id)
      url = resource_url(category_id)
      response = Api.new.get(url)
      new response.data
    end

    def self.each(query = {}, &block)
      paginate(query).each(&block)
    end

    def self.paginate(query = {})
      args = query.merge({ resource_url: resource_url, resource_class: self })
      PagedResource.new(args)
    end

    def self.resource_url(path = nil)
      Api.resource_url 'categories', path
    end

  end
end
