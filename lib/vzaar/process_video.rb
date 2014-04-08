module Vzaar
  class ProcessVideo

    attr_reader :xml, :video_id

    def initialize(xml)
      @xml = xml
      doc = Nokogiri::XML(xml)
      @video_id = doc.at_xpath('//vzaar-api/video').text
    end

  end
end
