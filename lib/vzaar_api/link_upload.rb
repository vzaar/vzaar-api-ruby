module VzaarApi
  module LinkUpload

    ENDPOINT = 'link_uploads'

    def self.create(attrs = {})
      url = Api.resource_url ENDPOINT
      Video.new Api.new.post(url, attrs).data
    end

  end
end
