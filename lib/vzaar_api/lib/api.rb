module VzaarApi
  module Lib
    class Api

      def self.api_root_url
        "#{VzaarApi.protocol}://#{VzaarApi.hostname}/api/v2"
      end

      def self.resource_url(resource, path = nil)
        [api_root_url, resource, path].compact.join('/')
      end

      def delete(url)
        handle_response http_client.delete(url, {}, headers)
      end

      def get(url, query = {})
        handle_response http_client.get(url, query, headers)
      end

      def patch(url, body = {})
        handle_response http_client.patch(url, body.to_json, headers)
      end

      def post(url, body = {})
        handle_response http_client.post(url, body.to_json, headers)
      end

      def handle_response(response)
        api_response = ApiResponse.new(response)
        VzaarApi.rate_limit = api_response.rate_limit
        VzaarApi.rate_limit_remaining = api_response.rate_limit_remaining
        VzaarApi.rate_limit_reset = api_response.rate_limit_reset
        return api_response if api_response.ok?
        raise Error.new(api_response.error)
      end

      def http_client
        HTTPClient.new.tap do |c|
          c.ssl_config.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
      end

      def headers
        {
          'X-Auth-Token' => VzaarApi.auth_token,
          'X-Client-Id'  => VzaarApi.client_id,
          'Content-Type' => 'application/json'
        }
      end

    end
  end
end
