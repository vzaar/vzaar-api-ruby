$: << File.dirname(__FILE__)

module Vzaar
  module Helper
    def blank?(obj)
      obj.nil? or obj == ""
    end

    def symb_keys(hash)
      h = {}
      hash.each_pair do |k,v|
        h[k.to_sym] = v.is_a?(Hash) ? symb_keys(v) : v
      end
      h
    end

    def hash_to_xml(h)
      h.map do |k, v|
        text = Hash === v ? hash_to_xml(v) : v
        "<%s>%s</%s>" % [k, text, k]
      end.join
    end
  end

  class Error < StandardError; end
end

require 'httpclient'
require 'nokogiri'
require 'oauth'
require 'json'


require 'vzaar/request/multipart'
require 'vzaar/ext/oauth'
require 'vzaar/connection'
require 'vzaar/request/base'

# resources

require 'vzaar/resources/base'
require 'vzaar/resources/account_type'


require 'vzaar/resources/user'
require 'vzaar/resources/video'
require 'vzaar/resources/video_status'
require 'vzaar/resources/video_details'
require 'vzaar/resources/video_collection_item'
require 'vzaar/resources/video_collection'
require 'vzaar/resources/signature'
require 'vzaar/resources/processed_video'
require 'vzaar/resources/who_am_i'
require 'vzaar/resources/link_upload'
require 'vzaar/resources/upload_thumbnail'
require 'vzaar/resources/status'

# request

require 'vzaar/request/video'
require 'vzaar/request/video_details'
require 'vzaar/request/who_am_i'
require 'vzaar/request/account_type'
require 'vzaar/request/user_details'
require 'vzaar/request/video_list'
require 'vzaar/request/delete_video'
require 'vzaar/request/upload_status'
require 'vzaar/request/link_upload'
require 'vzaar/request/generate_thumbnail'
require 'vzaar/request/upload_thumbnail'
require 'vzaar/request/add_subtitle'


require 'vzaar/uploader'


# response

require 'vzaar/response/base'


require 'vzaar/request/edit_video'
require 'vzaar/request/process_video'
require 'vzaar/request/signature'
require 'vzaar/request/url'
require 'vzaar/api'
