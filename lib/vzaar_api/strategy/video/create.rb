module VzaarApi
  module Strategy
    module Video
      class Create

        attr_reader :attrs, :video_class

        def initialize(attrs, video_class)
          @attrs = attrs
          @video_class = video_class
        end

        def execute
          case
          when attrs.has_key?(:guid)
            create_from_guid
          when attrs.has_key?(:path)
            create_from_path
          when attrs.has_key?(:url)
            create_from_url
          else
            raise Error.new('Invalid parameters: Expected one of :guid, :path, :url')
          end
        end

        private

        def create_from_guid
          url = Api.resource_url video_class::ENDPOINT
          video_class.new Api.new.post(url, attrs).data
        end

        def create_from_path
          signature = Signature::Factory.create(attrs)
          upload_attrs = Upload::S3.new(attrs, signature).execute
          video_class.create upload_attrs
        end

        def create_from_url
          LinkUpload.create(attrs.merge({ uploader: UPLOADER }))
        end

      end
    end
  end
end
