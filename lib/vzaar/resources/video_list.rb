module Vzaar
  module Resource
    class VideoList < Array
      def initialize(xml_doc)
        xml_doc.xpath("//videos/video").each do |xml|
          push(VideoListItem.new(xml))
        end
      end
    end
  end
end
