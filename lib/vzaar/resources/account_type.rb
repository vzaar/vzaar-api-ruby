module Vzaar
  module Resource
    class AccountType < Base
      root_node "//account"

      attribute :title
      attribute :id, field: :account_id, type: Integer
      attribute :monthly, node: "cost", type: Integer
      attribute :currency, node: "cost"
      attribute :borderless, node: "rights", type: Boolean
      attribute :bandwidth, type: Integer
      attribute :search_enhancer, node: "rights", field: :searchEnhancer, type: Boolean

    end
  end
end
