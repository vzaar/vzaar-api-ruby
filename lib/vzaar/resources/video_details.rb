module Vzaar
  module Resource
    module VideoDetails
      def self.new(xml_doc)
        if xml_doc.xpath("//oembed").empty?
          Vzaar::Resource::VideoStatus.new(xml_doc)
        else
          Vzaar::Resource::Video.new(xml_doc)
        end
      end
    end
  end
end
