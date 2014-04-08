module Vzaar
  module Response
    class VideoList < Response::XML

      attr_reader :version

      def initialize(xml)
        super(xml)
        @videos = []
        doc.xpath('//videos/video').each do |video_xml|
          @videos << Video.new(video_xml.to_s)
        end
      end

      def count
        @videos.length
      end

      def each(&block)
        @videos.each &block
      end

    end
  end
end
