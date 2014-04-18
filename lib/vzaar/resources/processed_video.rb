module Vzaar
  module Resource
    class ProcessedVideo < Base
      root_node "//vzaar-api"
      attribute :id, field: :video, type: Integer
    end
  end
end
