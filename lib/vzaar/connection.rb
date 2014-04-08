module Vzaar
  class Connection
    SERVER = "vzaar.com".freeze

    attr_reader :application_token, :force_http, :login, :server

    def initialize(options)
      @application_token = options[:application_token]
      @force_http = options[:force_http]
      @login = options[:login]
      @server = options[:server].gsub(/(http|https)\:\/\//, "")
    end

    def using_authorised_connection(http_verb, url, data = nil, &block)
      using_connection(true, http_verb, url, data, &block)
    end

    def using_public_connection(http_verb, url, &block)
      using_connection(false, http_verb, url, &block)
    end

    def using_connection(authorised, http_verb, url, data = nil, &block)
      connection = authorised ? authorised_connection : public_connection
      response = nil
      case http_verb
      when Http::GET
        response = connection.get(url)
        yield handle_response(response) if block_given?
      when Http::DELETE
        response = connection.delete(url)
        handle_response(response)
      when Http::POST
        response = connection.post url, data, { 'Content-Type' => 'application/xml' }
        yield handle_response(response) if block_given?
      when Http::PUT
        response = connection.put url, data, { 'Content-Type' => 'application/xml' }
        handle_response(response)
      else
        handle_exception :invalid_http_verb
      end
      response
    end

    private

    def consumer(authorised = false)
      OAuth::Consumer.new '', '', { :site => "#{protocol(authorised)}://#{server}" }
    end

    def protocol(authorised)
      return 'http' if force_http
      authorised ? 'https' : 'http'
    end

    def authorised_connection
      @authorised_connection ||= OAuth::AccessToken.new consumer(true), login, application_token
    end

    def public_connection
      @public_connection ||= OAuth::AccessToken.new consumer, '', ''
    end

    def handle_response(response)
      Response::Handler.handle_response(response)
    end

    def handle_exception(type, custom_message = '')
      Response::Handler.handle_exception(type, custom_message)
    end

  end
end
