module Vzaar
  module Request
    class Signature < Base
      endpoint "/api/videos/signature"
      authenticated true

      private

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
        super.merge(_params)
      end
    end
  end
end
