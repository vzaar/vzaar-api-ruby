module VzaarApi
  class Playlist < Abstract

    ENDPOINT = 'feeds/playlists'

    ATTR_READERS = %i(
      id title sort_order sort_by autoplay continuous_play category_id
      embed_code created_at updated_at
    ).freeze

    ATTR_ACCESSORS = %i(
      category_id title sort_by sort_order private dimensions max_vids
      position autoplay continuous_play max_vids video_ids
    ).freeze

    prepend Lib::HasAttributes
    include Lib::HasCollectionBuilder
    include Lib::HasResourceUrl
    include Lib::ActiveObject::Find
    include Lib::ActiveObject::Save
    include Lib::ActiveObject::Delete
    include Lib::WillPaginate

    def self.create(attrs = {})
      url = Lib::Api.resource_url(ENDPOINT)
      new Lib::Api.new.post(url, attrs).data
    end
  end
end
