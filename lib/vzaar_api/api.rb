module VzaarApi
  class Api

    def get(url, query = {})
      handle_response http_client.get(url, query, headers)
    end

    def handle_response(response)
      api_response = ApiResponse.new(response)
      if api_response.ok?
        api_response
      else
        raise Error.new(api_response.error)
      end
    end

    def http_client
      HTTPClient.new.tap do |c|
        c.ssl_config.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
    end

    def url(path)
      "https://#{VzaarApi.hostname}/api/v2/#{path}"
    end

    def headers
      {
        'X-Auth-Token' => VzaarApi.auth_token,
        'X-Client-Id'  => VzaarApi.client_id
      }
    end

  end
end
