$: << File.dirname(__FILE__)

require 'httpclient'
require 'json'

require 'vzaar_api/version'
require 'vzaar_api/api'
require 'vzaar_api/api_response'
require 'vzaar_api/paged_resource'

require 'vzaar_api/category'


module VzaarApi
  class Error < StandardError ; end
  class << self
    # Global config for Vzaar API
    attr_accessor :auth_token
    attr_accessor :client_id
    attr_accessor :hostname
  end
end
