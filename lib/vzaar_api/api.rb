module VzaarApi
  class Api

    attr_reader :auth_token, :client_id, :hostname

    def initialize(auth_token:, client_id:, hostname: 'app.vzaar.com')
      @auth_token = auth_token
      @client_id = client_id
      @hostname = hostname
    end

  end
end
