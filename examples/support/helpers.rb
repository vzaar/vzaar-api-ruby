module Helpers

  def api_envs
    @api_envs = begin
      env = ENV["API_ENV"] || "development"
      YAML.load_file("api_envs.yml")[env]
    end
  end

  def setup_for(user)
    VzaarApi.hostname   = api_envs['hostname'] if api_envs['hostname']
    VzaarApi.auth_token = api_envs[user.to_s]['auth_token']
    VzaarApi.client_id  = api_envs[user.to_s]['client_id']
  end

end
