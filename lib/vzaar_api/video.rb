module VzaarApi
  class Video

    ENDPOINT = 'videos'

    ATTR_READERS = [:id, :user_id, :account_id, :renditions,
                    :legacy_renditions, :url, :thumbnail_url,
                    :state, :created_at, :updated_at].freeze

    ATTR_ACCESSORS = [:description, :private, :seo_url, :title].freeze

    prepend Lib::HasAttributes
    include Lib::HasResourceUrl
    include Lib::ActiveObject::Find
    include Lib::ActiveObject::Save
    include Lib::ActiveObject::Delete
    include Lib::WillPaginate

    def initialize(attrs = {})
      update_from_attributes attrs
    end

    def to_hash
      {
        id: self.id,
        title: self.title,
        user_id: self.user_id,
        account_id: self.account_id,
        description: self.description,
        private: self.private,
        renditions: @renditions.map(&:to_hash),
        legacy_renditions: @legacy_renditions.map(&:to_hash),
        seo_url: self.seo_url,
        url: self.url,
        thumbnail_url: self.thumbnail_url,
        state: self.state,
        created_at: self.created_at,
        updated_at: self.updated_at,
      }
    end

    def self.create(attrs = {})
      Strategy::Video::Create.new(attrs, self).execute
    end

    private

    def update_from_attributes(attrs)
      @renditions = Rendition.build(attrs[:renditions])
      @legacy_renditions = LegacyRendition.build(attrs[:renditions])
    end

  end
end
