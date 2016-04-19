module Vzaar
  module Request
    class Url < Struct.new(:url, :format, :params)
      include Vzaar::Helper

      def build
        _params = build_params
        blank?(_params) ? base_url : (base_url + "?" + _params)
      end

      private

      def base_url
        @base_url ||= blank?(format) ? url : url + ".#{format.to_s}"
      end

      def build_params
        _params = params ? (params.delete_if { |k,v| v.nil? }) : {}
        URI.encode_www_form(_params)
      end

    end
  end
end
