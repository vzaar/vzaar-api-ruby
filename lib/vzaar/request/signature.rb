module Vzaar
  module Request
    class Signature < Base
      authenticated true

      private

      def format_suffix
        nil
      end

      def base_url
        '/api/videos/signature'
      end

      def url_params
        # JC: refactor it
        _params = {}
        if options[:success_action_redirect]
          _params[:success_action_redirect] = options[:success_action_redirect]
        end
        if options[:include_metadata]
          _params[:include_metadata] = 'yes'
        end
        if options[:flash_request]
          _params[:flash_request] = 'yes'
        end
        _params
      end
    end
  end
end
