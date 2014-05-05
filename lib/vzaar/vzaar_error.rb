module Vzaar
  class Error < ::RuntimeError

    NOT_AUTHORIZED = 'You have not been authorized on the server. Please check your login and application token.'
    AUTHORIZATION_INFO_NOT_PROVIDED = 'You need to provide login and application token to perform to perform this action.'
    SERVER_NOT_RESPONDING = 'The server you are trying to connect to is not responding.'
    PROTECTED_RESOURCE = 'The resource is protected and you have not been authorized to access it.'
    NOT_FOUND = 'The resource has not been found on the server.'
    UNKNOWN_METHOD = 'The method used for connecting is not a proper HTTP method.'
    UNKNOWN = 'Unknown error occured when accessing the server: '

    def self.generate(type, message_extension = '')
      raise self.new build_message(type, message_extension)
    end

    def self.build_message(type, message_extension)
      message = case type
      when :not_authorized
        NOT_AUTHORIZED
      when :authorization_info_not_provided
        AUTHORIZATION_INFO_NOT_PROVIDED
      when :server_not_responding
        SERVER_NOT_RESPONDING
      when :protected_resource
        PROTECTED_RESOURCE
      when :not_found
        NOT_FOUND
      when :unknown_method
        UNKNOWN_METHOD
      else
        UNKNOWN + message_extension
      end
    end

  end
end
