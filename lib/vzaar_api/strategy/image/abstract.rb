module VzaarApi
  module Strategy
    module Image
      class Abstract

        attr_reader :video_id, :attrs, :video_class

        def initialize(video_id, attrs, video_class)
          @attrs = attrs
          @video_id = video_id
          @video_class = video_class
        end

        def execute
          raise 'not implemented'
        end

        def url
          path = File.join(video_class::ENDPOINT, video_id.to_s, "image")
          Lib::Api.resource_url path
        end
      end
    end
  end
end
