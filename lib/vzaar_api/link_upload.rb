module VzaarApi
  module LinkUpload

    include Lib::HasResourceUrl

    ENDPOINT = 'link_uploads'

    def self.create(attrs = {})
      Video.new Lib::Api.new.post(resource_url, attrs).data
    end

  end
end
