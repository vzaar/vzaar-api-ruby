# uncomment these lines when this library is gemified
# require 'bundler/gem_tasks'
# Bundler::GemHelper.install_tasks

desc "Run all specs"
task :default do
  exec 'rspec spec'
end

namespace :spec do
  namespace :api do

    task :dev do
      exec 'API_ENV=development bundle exec rspec examples'
    end

    task :qa do
      exec 'API_ENV=qa bundle exec rspec examples'
    end

    task :prod do
      exec 'API_ENV=production bundle exec rspec examples'
    end

  end
end
