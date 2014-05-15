module Vzaar
  class Connection
    include Vzaar::Helper

    SERVER = "vzaar.com".freeze
    attr_reader :application_token, :force_http, :login, :options

    def initialize(options)
      @options = options
      @application_token = options[:application_token]
      @force_http = options[:force_http]
      @login = options[:login]
    end

    def using_connection(url, opts={}, &block)
      connection = opts[:authenticated] ? authorised_connection : public_connection

      case opts[:http_verb]
      when :get
        yield handle_response(connection.get(url)) if block_given?
      when :delete
        yield handle_response(connection.delete(url)) if block_given?
      when :post
        response = connection.post(url, opts[:data], content_type(opts[:format]))
        yield handle_response(response) if block_given?
      when :put
        response = connection.put(url, opts[:data], content_type(opts[:format]))
        yield handle_response(response) if block_given?
      else
        handle_exception :invalid_http_verb
      end
    end

    def server
      @server ||= blank?(sanitized_url) ? self.class::SERVER : sanitized_url
    end

    private

    def content_type(_type='xml')
      { 'Content-Type' => "application/#{_type}" }
    end

    def sanitized_url
      @sanitized_url ||= options[:server].gsub(/(http|https)\:\/\//, "") if options[:server]
    end

    def consumer(authorised = false)
      site = "#{protocol(authorised)}://#{server}"
      c = OAuth::Consumer.new('', '', { :site => site })
      c.extend(OAuthExt::Multipart)
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
      Response.handle_response(response)
    end

    def handle_exception(type, custom_message = '')
      Response::Handler.handle_exception(type, custom_message)
    end

  end
end
