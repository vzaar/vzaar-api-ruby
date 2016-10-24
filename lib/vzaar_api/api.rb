module VzaarApi
  class Api

    def get(path, query = {})
      handle_response http_client.get(url(path), query, headers)
    end

    def handle_response(response)
      json = jsonify(response)
      return_data_or_raise(json)
    end

    def jsonify(response)
      JSON.parse response.body
    end

    def return_data_or_raise(json)
      return json['data'] if json['data']
      err = [
        json['errors'].first['message'],
        json['errors'].first['detail']].join(': ')
      raise Error.new(err)
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
