module Vzaar
  module Resource
    class VideoStatus < Base
      root_node "//vzaar-api/video"

      attribute :state
      attribute :type
      attribute :status_id, field: :video_status_id, type: Integer
    end
  end
end
