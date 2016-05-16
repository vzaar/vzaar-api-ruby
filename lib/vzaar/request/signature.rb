module Vzaar
  module Request
    class Signature < Base
      endpoint "/api/v1.1/videos/signature"
      authenticated true
      resource :signature

      private

      def ensure_valid_params!
        if !options.has_key?(:path) && !options.has_key?(:url)
          raise Vzaar::Error, "Path or url parameter required to generate signature."
        end
      end

      def url_params
        ensure_valid_params!
        _params = { multipart: 'true' }

        if options[:path]
          _params[:filename] = File.basename(options[:path])
          _params[:filesize] = File::Stat.new(options[:path]).size
          _params[:uploader] = "Ruby #{VERSION}"
        end
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
