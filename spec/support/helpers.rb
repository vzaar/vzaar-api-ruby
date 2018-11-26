module Helpers

  def api_envs
    @api_envs = begin
      env = ENV["API_ENV"] || "development"
      YAML.load_file("api_envs.yml")[env]
    end
  end

  def setup_auth!
    VzaarApi.auth_token = 'pVrjGuKWP27U_kz4anfy'
    VzaarApi.client_id  = 'glide-franca-raise'
    VzaarApi.hostname   = 'app.vzaar.localhost'
  end
end
