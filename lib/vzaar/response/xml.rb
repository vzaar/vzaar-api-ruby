module Vzaar
  module Response
    class XML

      attr_reader :xml

      def initialize(xml)
        @xml = xml
        @doc = Nokogiri::XML(xml)
      end

      def body
        self
      end

      private

      attr_reader :doc

      def extract_text(xpath)
        return '' if xml.to_s == ''
        doc.at_xpath(xpath) ? doc.at_xpath(xpath).text : ''
      end

    end
  end
end
