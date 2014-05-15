module Vzaar
  module Request
    class DeleteVideo < Video
      authenticated true
      http_verb :delete
      resource :video
    end
  end
end
