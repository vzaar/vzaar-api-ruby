module VzaarApi
  class Video

    include Lib::HasResourceUrl
    include Lib::ActiveObject::Find
    include Lib::WillPaginate

    ENDPOINT = 'videos'

    attr_reader :id, :title, :user_id, :account_id, :description,
      :private, :renditions, :legacy_renditions, :seo_url, :url,
      :thumbnail_url, :state, :created_at, :updated_at

    def initialize(attrs = {})
      @id = attrs[:id]
      @title = attrs[:title]
      @user_id = attrs[:user_id]
      @account_id = attrs[:account_id]
      @description = attrs[:description]
      @private = attrs[:private]
      @renditions = Rendition.build(attrs[:renditions])
      @legacy_renditions = LegacyRendition.build(attrs[:renditions])
      @seo_url = attrs[:seo_url]
      @url = attrs[:url]
      @thumbnail_url = attrs[:thumbnail_url]
      @state = attrs[:state]
      @created_at = attrs[:created_at]
      @updated_at = attrs[:updated_at]
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

  end
end
