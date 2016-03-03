module Vzaar
  module Resource
    class Signature < Base
      root_node "//vzaar-api"

      attribute :https, type: Boolean
      attribute :signature
      attribute :expiration_date, field: :expirationdate
      attribute :acl
      attribute :success_action_redirect
      attribute :profile
      attribute :access_key_id, field: :accesskeyid
      attribute :policy
      attribute :title
      attribute :guid
      attribute :key
      attribute :bucket
      attribute :upload_hostname
      attribute :chunk_size

    end
  end
end
