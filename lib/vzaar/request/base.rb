module Vzaar
  module Request
    class Base < Struct.new(:conn, :opts)
      include Vzaar::Helper

      class << self
        [:authenticated, :http_verb].each do |method_name|
          define_method(method_name) do |val|
            define_method(method_name) do
              val.nil? ? self.options[method_name] : val
            end
          end
        end

        def endpoint(obj=nil, &fn)
          define_method(:endpoint) { block_given? ? yield(self) : obj }
        end
      end

      authenticated nil
      http_verb Http::GET

      def execute
        conn.using_connection(url, user_options) do |res|
          return Response::Base.new(res).body
        end
      end

      protected

      attr_reader :xml_body, :json_body

      def options
        @options ||= symb_keys(opts)
      end

      def format
        @format ||= (options[:format] || :xml).to_sym
      end

      def format_suffix
        format
      end

      def url
        Url.new(endpoint, format_suffix, url_params).build
      end

      def user_options
        { format: format,
          authenticated: authenticated,
          http_verb: http_verb,
          data: data
        }
      end

      def xml?
        format == :xml
      end

      def url_params; {} end
      def data
        xml? ? xml_body : json_body
      end
    end
  end
end
