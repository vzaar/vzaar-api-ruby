module VzaarApi
  module Strategy
    module Image
      class Create < Abstract
        def execute
          File.open(attrs[:path], "r") do |file|
            res = Lib::Api.new.post(url, image: file) do |body, headers|
              headers.delete('Content-Type')
              [body, headers]
            end

            video_class.new res.data
          end
        end
      end
    end
  end
end
