module Vzaar
  module Resource
    class LinkUpload < Base
      root_node "//link-upload"

      attribute :guid
      attribute :status
      attribute :progress, type: Integer
      attribute :filesize, type: Integer
    end
  end
end
