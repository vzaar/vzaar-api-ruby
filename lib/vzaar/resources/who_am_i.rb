module Vzaar
  module Resource
    class WhoAmI < Base
      root_node "//vzaar-api/test"
      attribute :login
    end
  end
end
