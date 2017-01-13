module VzaarApi
  class Category < Abstract

    ENDPOINT = 'categories'

    ATTR_READERS = [:id, :account_id, :user_id, :name,
                    :description, :parent_id, :depth,
                    :node_children_count, :tree_children_count,
                    :node_video_count, :tree_video_count,
                    :created_at, :updated_at].freeze

    prepend Lib::HasAttributes
    include Lib::HasResourceUrl
    include Lib::ActiveObject::Find
    include Lib::WillPaginate

    def subtree(query = {})
      args = query.merge({
        resource_url: resource_url("#{id}/subtree"),
        resource_class: self.class })
      Lib::PagedResource.new(args)
    end

  end
end
