module Vzaar
  module Request
    class Base < Struct.new(:conn, :opts)
      include Vzaar::Helper

      def execute
        klass = find_response_klass
        if klass
          conn.using_connection(url, user_options) do |xml|
            return klass.new(xml).body
          end
        else
          conn.using_connection(url, user_options)
        end
      end

      protected

      def find_response_klass
        kname = self.class.name.split("::").last
        Response.const_defined?(kname) ? Response.const_get(kname) : nil
      end

      def base_url
        raise "not implemented"
      end

      def options
        @options ||= symb_keys(opts)
      end

      def format
        @format ||= options[:format] || "xml"
      end

      def format_suffix
        format
      end

      def authenticated?
        options[:authenticated]
      end

      def url
        Url.new(base_url, format_suffix, url_params).build
      end

      def user_options
        { format: format,
          authenticated: authenticated?,
          http_verb: http_verb,
          data: data
        }
      end

      def http_verb; Http::GET end
      def url_params; {} end
      def data; end

    end
  end
end
