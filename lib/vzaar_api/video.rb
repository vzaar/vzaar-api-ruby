module VzaarApi
  class Video

    ENDPOINT = 'videos'

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

    def self.create(attrs = {})
      # Strategy::Video::Create.new(attrs).execute
      case
      when attrs.has_key?(:guid)
        url = Api.resource_url ENDPOINT
        new Api.new.post(url, attrs).data
      when attrs.has_key?(:path)
        signature = Signature::Factory.create(attrs)
        upload_attrs = Upload::S3.new(attrs, signature).execute
        create upload_attrs
      when attrs.has_key?(:url)
        LinkUpload.create(attrs)
      else
        raise Error.new('Invalid parameters: Expected one of :guid, :path, :url')
      end
    end

  end
end
