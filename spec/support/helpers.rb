module Helpers

  def setup_auth!
    VzaarApi.auth_token = 'TUGXzNL17ypaougMYpR3'
    VzaarApi.client_id  = 'lair-tend72'
    VzaarApi.hostname   = 'app.vzaar.localhost'
  end

end
