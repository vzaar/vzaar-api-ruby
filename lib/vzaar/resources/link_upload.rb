module Vzaar
  module Resource
    class LinkUpload < Base
      root_node "//vzaar-api"
      attribute :id, type: Integer
    end
  end
end
