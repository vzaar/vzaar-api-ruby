module VzaarApi
  class Category

    def initialize(attrs = {})
      # init category here from hash of attributes
      # ...
      # ...
    end

    def self.find(category_id)
      api = Api.new
      api.get "categories/#{category_id}"
    end

  end
end
