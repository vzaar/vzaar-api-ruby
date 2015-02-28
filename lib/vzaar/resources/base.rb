module Vzaar
  module Resource
    class Base
      include Helper
      attr_reader :api_version

      class Boolean; end
      class Collection

        attr_reader :node, :xml_doc, :opts
        def initialize(node, xml_doc, opts)
          @node = node
          @xml_doc = xml_doc
          @opts = opts
        end

        def build
          xml_doc.at_xpath(node).elements.inject([]) do |col, xml|
            klass = opts[:class]
            col << klass.new(xml)
            col
          end
        end
      end

      class << self
        def root_node(node)
          define_method(:initialize) do |*args|
            instance_variable_set(:@_root_node, node)
            self.class.resource_attributes.each { |attr| send(attr, args[0]) }
          end
        end

        def attribute(name, opts={})
          register!(name)

          define_method(name) do |*args|
            val = instance_variable_get(:"@#{name.to_s}")
            xml_doc = args[0]
            if !val && xml_doc
              val = assign_value!(name, opts.merge(xml_doc: xml_doc))
            end
            val
          end
        end

        def resource_attributes
          @resource_attributes ||= []
        end

        private

        def register!(name)
          unless resource_attributes.include?(name)
            resource_attributes << name
          end
        end
      end

      def assign_value!(name, opts)
        field_name = (opts[:field] || name).to_s
        data_type = opts[:type] || String
        node = opts[:node]
        xml_doc = opts[:xml_doc]

        root_node = instance_variable_get(:@_root_node)
        _node = node ? (root_node + "/" + node.to_s) : root_node

        value = extract_value(_node, field_name, xml_doc)
        attr = case data_type.to_s
              when 'Integer'
                blank?(value) ? nil : value.to_i
              when 'Vzaar::Resource::Base::Boolean'
                value =~ /^true$/i ? true : false
              when 'Fixnum'
                value.to_f
              when /Collection/
                data_type.new(_node, xml_doc, opts).build
              when 'Time'
                Time.parse(value).utc
              else
                value
              end

        instance_variable_set(:"@#{name}", attr)
        attr
      end

      protected

      def extract_value(node, field_name, xml_doc)
        extract_text(build_xpath(node, field_name), xml_doc)
      end

      def build_xpath(node, field_name)
        node + "/" + field_name
      end

      def extract_text(xpath, xml_doc)
        xml_doc.at_xpath(xpath) ? xml_doc.at_xpath(xpath).text : ''
      end
    end
  end
end
