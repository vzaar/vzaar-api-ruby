$: << File.dirname(__FILE__)

require 'forwardable'
require 'httpclient'
require 'json'

require 'vzaar_api/version'
require 'vzaar_api/api'
require 'vzaar_api/api_response'
require 'vzaar_api/paged_resource'

require 'vzaar_api/category'
require 'vzaar_api/encoding_preset'
require 'vzaar_api/link_upload'
require 'vzaar_api/rendition'
require 'vzaar_api/strategy/video/create'
require 'vzaar_api/video'

require 'vzaar_api/signature/factory'
require 'vzaar_api/signature/multipart'
require 'vzaar_api/signature/single'

require 'vzaar_api/upload/s3'
require 'vzaar_api/upload/virtual_file'

module VzaarApi
  class Error < StandardError ; end

  DEFAULT_HOSTNAME = 'api.vzaar.com'
  DEFAULT_PROTOCOL = 'https'

  class << self
    attr_accessor :auth_token
    attr_accessor :client_id
    attr_accessor :hostname
    attr_accessor :protocol

    def hostname
      @hostname || DEFAULT_HOSTNAME
    end

    def protocol
      @protocol || DEFAULT_PROTOCOL
    end

    def protocol=(value)
      @protocol = value.downcase == 'https' ? 'https' : 'http'
    end
  end

end
