$: << File.dirname(__FILE__)

module Vzaar
  refine Object do
    def blank?
      self.nil? or self == ""
    end
  end

  refine Hash do

    def as_sym
      h = {}
      self.each_pair do |k,v|
        h[k.to_sym] = v.is_a?(Hash) ? v.symbolize_keys : v
      end
      h
    end
  end
end
require 'pry'
require 'httpclient'
require 'nokogiri'
require 'oauth'

require 'vzaar/response/base'
require 'vzaar/connection'
require 'vzaar/account_type'
require 'vzaar/vzaar_error'
require 'vzaar/http'
require 'vzaar/user'
require 'vzaar/video'
require 'vzaar/video_details'
require 'vzaar/video_collection'
require 'vzaar/signature'
require 'vzaar/who_am_i'
require 'vzaar/process_video'
require 'vzaar/s3_uploader'
require 'vzaar/api'
require 'vzaar/request/edit_video'
require 'vzaar/request/process_video'
require 'vzaar/request/signature'
require 'vzaar/response/handler'
require 'vzaar/base'
