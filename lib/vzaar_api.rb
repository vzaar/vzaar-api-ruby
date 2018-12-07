$: << File.dirname(__FILE__)

require 'forwardable'
require 'httpclient'
require 'json'

require 'vzaar_api/version'

require 'vzaar_api/lib/api'
require 'vzaar_api/lib/api_response'
require 'vzaar_api/lib/active_object'
require 'vzaar_api/lib/has_attributes'
require 'vzaar_api/lib/has_collection_builder'
require 'vzaar_api/lib/has_resource_url'
require 'vzaar_api/lib/paged_resource'
require 'vzaar_api/lib/will_paginate'

require 'vzaar_api/abstract'
require 'vzaar_api/category'
require 'vzaar_api/encoding_preset'
require 'vzaar_api/ingest_recipe'
require 'vzaar_api/legacy_rendition'
require 'vzaar_api/link_upload'
require 'vzaar_api/playlist'
require 'vzaar_api/rendition'
require 'vzaar_api/strategy/image/abstract'
require 'vzaar_api/strategy/image/update'
require 'vzaar_api/strategy/image/create'
require 'vzaar_api/strategy/subtitle/create'
require 'vzaar_api/strategy/video/create'
require 'vzaar_api/video'
require 'vzaar_api/video/subtitle'

require 'vzaar_api/signature/abstract'
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
    attr_accessor :auth_token, :client_id, :hostname,
      :rate_limit, :rate_limit_remaining, :rate_limit_reset

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
