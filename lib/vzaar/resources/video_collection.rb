module Vzaar
  module Resource
    class VideoCollection < Array
      def initialize(xml_body)
        doc = Nokogiri::XML(xml_body)
        doc.xpath("//videos/video").each do |xml|
          push(VideoCollectionItem.new(xml.to_s))
        end
      end
    end
  end
end
