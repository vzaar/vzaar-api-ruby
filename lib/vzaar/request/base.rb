module Vzaar
  module Request
    class Base < Struct.new(:conn, :opts)
      include Vzaar::Helper

      class << self
        [:authenticated, :http_verb, :format].each do |method_name|
          define_method(method_name) do |val|
            define_method(method_name) do
              val.nil? ? self.options[method_name] : val
            end
          end
        end

        def endpoint(obj=nil, &fn)
          define_method(:endpoint) { block_given? ? yield(self) : obj }
        end

        def resource(name)
          define_method(:resource) { name }
        end
      end

      authenticated nil
      http_verb :get
      format :xml

      def execute
        conn.using_connection(url, user_options) do |res|
          return resource_klass.new(Response::Base.new(res).body, res.code)
        end
      end

      protected

      attr_reader :xml_body, :json_body

      def resource_klass
        name = resource.is_a?(Symbol) ? resource.to_s.capitalize : resource
        Resource.const_get(name)
      end

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

      # JC: vzaar_dev_login param is used only for localhost testing
      def url_params
        unless ENV["RUBY_ENV"] == "test"
          { vzaar_dev_login: options[:l] || ENV["VZAAR_DEV_LOGIN"] }
        else
          {}
        end
      end

      def data
        xml? ? xml_body : json_body
      end
    end
  end
end
