module Vzaar
  module Response
    class Base < Struct.new(:res, :_resource_name)
      include Vzaar::Helper

      def resource
        @resource ||= if xml?
                        resource_klass.new(xml_doc)
                      else
                        JSON.parse(res.body)
                      end
      end

      def status_code
        @status_code ||= res.code.to_i
      end

      def json?
        content_type == "application/json"
      end

      def xml?
        content_type == "application/xml"
      end

      def errors
        if xml?
          xml_doc.xpath("//vzaar-api/errors").map do |e|
            node = e.children.first
            { node.name => node.text }
          end
        else
          []
        end
      end

      def xml_doc
        @xml_doc ||= Nokogiri::XML(res.body) if xml?
      end

      private

      def content_type
        @content_type ||= res.content_type
      end

      def resource_klass
        Vzaar::Resource.const_get(resource_name)
      end

      def resource_name
        if _resource_name.is_a?(Symbol)
          _resource_name.to_s.capitalize
        else
          _resource_name
        end
      end
    end

    def self.handle_response(response)
      case response.code.to_i
      when 302
        error("Moved Temporarily")
      when 502
        error("Bad Gateway")
      else
        response
      end
    end

    def self.error(msg)
      raise(Vzaar::Error, msg)
    end
  end
end
