module Vzaar
  module Request
    class DeleteVideo < Video
      authenticated true
      http_verb Http::DELETE
    end
  end
end
