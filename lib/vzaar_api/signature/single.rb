module VzaarApi
  module Signature
    class Single < Abstract

      ENDPOINT = 'signature/single/2'

      def after_initialize(attrs = {})
        # no-op in this class
      end

      def multipart?
        false
      end

    end
  end
end
