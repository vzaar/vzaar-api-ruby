module VzaarApi
  class Category

    include Lib::HasResourceUrl
    include Lib::ActiveObject::Find
    include Lib::WillPaginate

    ENDPOINT = 'categories'

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
        resource_url: resource_url("#{id}/subtree"),
        resource_class: self.class })
      Lib::PagedResource.new(args)
    end

    def self.each(query = {}, &block)
      paginate(query).each(&block)
    end

  end
end
