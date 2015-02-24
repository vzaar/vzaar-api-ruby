module Vzaar
  module Request
    class Base < Struct.new(:conn, :opts)
      include Vzaar::Helper

      class << self
        [:authenticated, :http_verb].each do |method_name|
          define_method(method_name) do |val|
            define_method(method_name) do
              param = self.options[method_name]
              blank?(param) ? val : param
            end
          end
        end

        def endpoint(obj=nil, &fn)
          define_method(:endpoint) { block_given? ? yield(self) : obj }
        end

        def resource(name)
          define_method(:resource) { name }
        end

        def format(f)
          define_method(:format) do
            # JC: options should always overwrite format param
            self.options[:format] ? self.options[:format] : f
          end
        end
      end

      authenticated nil
      http_verb :get
      format :xml

      def execute
        conn.using_connection(url, user_options) do |res|
          Response::Base.new(res, resource)
        end
      end

      protected

      attr_reader :xml_body, :json_body

      def options
        @options ||= symb_keys(opts)
      end

      def format_suffix
        format
      end

      def url
        Url.new(endpoint, format_suffix, url_params).build
      end

      def user_options
        { format: format.to_sym,
          authenticated: authenticated,
          http_verb: http_verb,
          data: data
        }
      end

      def xml?
        format == :xml
      end

      def url_params
        options[:params] || {}
      end

      def data
        xml? ? xml_body : json_body
      end
    end
  end
end
