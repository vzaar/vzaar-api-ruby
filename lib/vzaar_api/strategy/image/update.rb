module VzaarApi
  module Strategy
    module Image
      class Update < Abstract
        def execute
          video_class.new Lib::Api.new.patch(url, attrs).data
        end
      end
    end
  end
end
