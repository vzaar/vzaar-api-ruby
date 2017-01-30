module VzaarApi
  class Category < Abstract

    ENDPOINT = 'categories'

    ATTR_READERS = [:id, :account_id, :user_id, :name,
                    :description, :parent_id, :depth,
                    :node_children_count, :tree_children_count,
                    :node_video_count, :tree_video_count,
                    :created_at, :updated_at].freeze

    ATTR_ACCESSORS = [:name, :parent_id, :move_to_root].freeze

    prepend Lib::HasAttributes
    include Lib::HasCollectionBuilder
    include Lib::HasResourceUrl
    include Lib::ActiveObject::Find
    include Lib::ActiveObject::Save
    include Lib::ActiveObject::Delete
    include Lib::WillPaginate

    def initialize(attrs = {})
      update_from_attributes attrs
    end

    def self.create(attrs = {})
      url = Lib::Api.resource_url(ENDPOINT)
      new Lib::Api.new.post(url, attrs).data
    end

    def subtree(query = {})
      args = query.merge(
        resource_url: resource_url("#{id}/subtree"),
        resource_class: self.class
      )
      Lib::PagedResource.new(args)
    end
  end
end
