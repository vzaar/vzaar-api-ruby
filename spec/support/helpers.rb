module Helpers

  def api_envs
    @api_envs = begin
      env = ENV["API_ENV"] || "development"
      YAML.load_file("api_envs.yml")[env]
    end
  end

  def setup_auth!
    VzaarApi.auth_token = 'TUGXzNL17ypaougMYpR3'
    VzaarApi.client_id  = 'lair-tend72'
    VzaarApi.hostname   = 'app.vzaar.localhost'
  end

end
