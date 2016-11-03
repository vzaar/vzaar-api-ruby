module VzaarApi
  class Video

    attr_reader :id, :title, :user_id, :account_id, :description,
      :private, :renditions, :seo_url, :url, :thumbnail_url, :state,
      :created_at, :updated_at

    def initialize(attrs = {})
      @id = attrs[:id]
      @title = attrs[:title]
      @user_id = attrs[:user_id]
      @account_id = attrs[:account_id]
      @description = attrs[:description]
      @private = attrs[:private]
      @renditions = Rendition.build(attrs[:renditions])
      @seo_url = attrs[:seo_url]
      @url = attrs[:url]
      @thumbnail_url = attrs[:thumbnail_url]
      @state = attrs[:state]
      @created_at = attrs[:created_at]
      @updated_at = attrs[:updated_at]
    end

  end
end