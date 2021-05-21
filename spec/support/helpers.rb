module Helpers

  def api_envs
    @api_envs = begin
      env = ENV["API_ENV"] || "development"
      YAML.load_file("api_envs.yml")[env]
    end
  end

  def setup_auth!
    VzaarApi.auth_token = 'E_TbHDr5X_Js1woNTnmR'
    VzaarApi.client_id  = 'colin-moche-test'
    VzaarApi.hostname   = 'app.raazv.com'
  end
end
