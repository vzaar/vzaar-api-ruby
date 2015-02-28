require 'rspec'
require 'vzaar'
require 'yaml'
require 'pry'

RSpec.configure do |config|
  config.order = 'defined'
end

RSpec.shared_examples("RO only") do |login, token, fn|
  specify do
    api = _api(login: login, application_token: token)
    res = fn.call(api)
    expect(res.status_code).to eq(401)
  end
end


RSpec.shared_examples("Unauthenticated") do |fn|
  specify do
    res = fn.call(unauthenticated_api())
    expect(res.status_code).to eq(401)
  end
end

RSpec.shared_examples("422 Failure") do
  specify { expect(@res.status_code).to eq(422) }
end

RSpec.shared_examples("202 Accepted") do
  specify { expect(@res.status_code).to eq 202 }
end

RSpec.shared_examples("200 OK") do
  specify { expect(@res.status_code).to eq 200 }
end

RSpec.shared_examples("401 Unauthorized") do
  specify { expect(@res.status_code).to eq 401 }
end

def env
  ENV["API_ENV"] || "development"
end

def server
  case env
  when "development" then "http://app.vzaar.localhost"
  when "qa" then "https://app.qavzr.com"
  when "production" then "https://app.vzaar.com"
  end
end

def api_envs
  @api_envs ||= YAML.load_file("api_envs.yml")
end

def user1
  api_envs[env]["user1"]
end

def user2
  api_envs[env]["user2"]
end

def user_with_public_api
  api_envs[env]["user_with_public_api"]
end

def user_with_public_videos_access_only
  api_envs[env]["user_with_public_videos_access_only"]
end

def test_video_id(account)
  api_envs[env][account]["test_video_id"]
end

def user_ro
end

def conn_params(params={})
  { application_token: params[:application_token],
    login: params[:login],
    server: server,
    force_http: true }
end

def _api(params)
  Vzaar::Api.new(conn_params(params))
end

def unauthenticated_api
  _api(login: "unknown", application_token: "wrong")
end

def rand_str
  (0...8).map { (65 + rand(26)).chr }.join
end
