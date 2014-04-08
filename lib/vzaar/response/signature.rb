module Vzaar
  module Response
    class Signature < Response::XML

      attr_reader :https, :signature, :expirationdate, :acl,
      :success_action_redirect, :profile, :accesskeyid,
      :policy, :title, :guid, :key, :bucket

      alias_method :aws_access_key, :accesskeyid
      alias_method :expiration_date, :expirationdate

      def initialize(xml)
        super(xml)
        @https = extract_text('//vzaar-api/https')
        @signature = extract_text('//vzaar-api/signature')
        @expirationdate = extract_text('//vzaar-api/expirationdate')
        @acl = extract_text('//vzaar-api/acl')
        @success_action_redirect = extract_text('//vzaar-api/success_action_redirect')
        @profile = extract_text('//vzaar-api/profile')
        @accesskeyid = extract_text('//vzaar-api/accesskeyid')
        @policy = extract_text('//vzaar-api/policy')
        @title = extract_text('//vzaar-api/title')
        @guid = extract_text('//vzaar-api/guid')
        @key = extract_text('//vzaar-api/key')
        @bucket = extract_text('//vzaar-api/bucket')
      end

    end
  end
end
