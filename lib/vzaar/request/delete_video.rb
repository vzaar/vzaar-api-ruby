module Vzaar
  module Request
    class DeleteVideo < Video
      authenticated true
      http_verb Http::DELETE
      resource :video
    end
  end
end
