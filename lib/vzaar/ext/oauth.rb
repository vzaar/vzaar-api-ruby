module Vzaar
  module OAuthExt
    module Multipart
      def create_http_request(http_method, path, *arguments)
        _params = arguments.first
        file = _params.is_a?(Hash) ? _params[:file] : nil

        if file && file.respond_to?(:read)
          uri = URI.parse(site)
          path = uri.path + path if uri.path && uri.path != '/'
          Vzaar::Request::Multipart.new(path, file).request
        else
          super(http_method, path, *arguments)
        end
      end
    end
  end
end
