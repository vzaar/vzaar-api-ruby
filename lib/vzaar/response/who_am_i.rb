module Vzaar
  module Response
    class WhoAmI < Response::XML
      def initialize(xml)
        super(xml)
      end

      def body
        extract_text('//test/login')
      end
    end
  end
end
