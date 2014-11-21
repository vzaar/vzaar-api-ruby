module Vzaar
  module Resource
    class VideoCollection < Array
      attr_reader :http_status_code

      def initialize(xml_body, status_code)
        @http_status_code = status_code.to_i

        if @http_status_code == 200
          doc = Nokogiri::XML(xml_body)
          doc.xpath("//videos/video").each do |xml|
            push(VideoCollectionItem.new(xml.to_s))
          end
        end
      end
    end
  end
end
