module VzaarApi
  module Strategy
    module Video
      class Replace < Create
        def create_from_guid
          data = attrs.dup
          data.delete(:replace_id)

          video_class.new Lib::Api.new.post(url, data).data
        end

        def create_from_path
          signature = Signature::Factory.create(attrs)
          upload_attrs = Upload::S3.new(attrs, signature).execute
          video_class.replace upload_attrs
        end

        def url
          base = Lib::Api.resource_url video_class::ENDPOINT
          File.join(base, attrs[:replace_id].to_s, 'replace')
        end
      end
    end
  end
end
