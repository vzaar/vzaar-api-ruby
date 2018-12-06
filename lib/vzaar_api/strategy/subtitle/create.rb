module VzaarApi
  module Strategy
    module Subtitle
      class Create
        attr_reader :video_id, :attrs, :klass

        def initialize(video_id, attrs, klass)
          @attrs = attrs
          @video_id = video_id
          @klass = klass
        end

        def execute
          res = attrs[:file] ? create_from_file : Lib::Api.new.post(url, attrs)
          klass.new res.data.merge(scope_id: video_id)
        end

        private

        def create_from_file
          File.open(attrs[:file], "r") do |file|
            Lib::Api.new.post(url, attrs.merge(file: file)) do |body, headers|
              headers.delete('Content-Type')
              [body, headers]
            end
          end
        end

        def url
          path = VzaarApi::Video::Subtitle::ENDPOINT.call(video_id, nil)
          Lib::Api.resource_url path
        end
      end
    end
  end
end
