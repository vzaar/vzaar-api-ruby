module Vzaar
  module Resource
    class Status < Base
      root_node "//vzaar-api"
      attribute :status
    end
  end
end
