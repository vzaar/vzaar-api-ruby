module Vzaar
  module Request
    class Signature

      attr_reader :base_url, :options

      def initialize(base_url, options)
        @base_url = base_url
        @options = options
      end

      def url
        "#{base_url}#{querystring}"
      end

      def querystring
        params = []
        if options[:success_action_redirect]
          params << "success_action_redirect=#{options[:success_action_redirect]}"
        end
        if options[:include_metadata]
          params << 'include_metadata=yes'
        end
        if options[:flash_request]
          params << 'flash_request=yes'
        end
        return nil if params.empty?
        "?#{params.join('&')}"
      end

    end
  end
end
