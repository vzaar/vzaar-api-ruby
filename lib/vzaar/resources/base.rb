module Vzaar
  module Resource
    class Base
      include Helper
      attr_reader :api_version, :doc, :http_status_code

      class << self
        def root_node(node)
          define_method(:initialize) do |*args|
            xml_body = args[0]
            status_code = args[1]
            _node = node

            instance_variable_set(:@root_node, _node)
            instance_variable_set(:@doc, Nokogiri::XML(xml_body))
            instance_variable_set(:@http_status_code, status_code.to_i)
            set_api_version!(_node)
          end
        end

        def attribute(name, opts={})
          field_name = (opts[:field] || name).to_s
          data_type = opts[:type] || String
          node = opts[:node]

          define_method(name) do
            val = instance_variable_get(:"@#{name.to_s}")
            unless val
              root_node = instance_variable_get(:@root_node)
              _node = node ? (root_node + "/" + node.to_s) : root_node

              value = extract_value(_node, field_name)
              return set_value!(name, value, data_type)
            end
            val
          end
        end
      end

      def errors
        doc.xpath("//vzaar-api/errors").map do |e|
          node = e.children.first
          { node.name => node.text }
        end
      end

      protected

      def set_value!(name, value, type=nil)
        val = case type.to_s
              when 'Integer'
                blank?(value) ? nil : value.to_i
              when 'Vzaar::Resource::Boolean'
                value =~ /^true$/i ? true : false
              when 'Fixnum'
                value.to_f
              when 'Time'
                Time.parse(value).utc
              else
                value
              end

        instance_variable_set(:"@#{name}", val)
        val
      end

      def set_api_version!(root_node)
        @api_version ||= extract_text(root_node + "/version").to_f
      end

      def extract_value(node, field_name)
        extract_text(build_xpath(node, field_name))
      end

      def build_xpath(node, field_name)
        node + "/" + field_name
      end

      def extract_text(xpath)
        doc.at_xpath(xpath) ? doc.at_xpath(xpath).text : ''
      end

    end

    class Boolean; end
  end
end
