module Vzaar
  module Resource
    class VideoCollectionItem < Base
      root_node "//video"

      attribute :id, type: Integer
      attribute :status
      attribute :status_id, type: Integer
      attribute :title
      attribute :description
      attribute :created_at, type: Time
      attribute :url
      attribute :play_count, type: Integer
      attribute :user_name, field: :author_name, node: :user
      attribute :user_url, field: :author_url, node: :user
      attribute :user_account_type_id, field: :author_account, node: :user, type: Integer
      attribute :video_count, node: :user, type: Integer
      attribute :duration, type: Integer
      attribute :height, type: Integer
      attribute :width, type: Integer
      attribute :thumbnail_url
      attribute :total_size, type: Integer
    end
  end
end
