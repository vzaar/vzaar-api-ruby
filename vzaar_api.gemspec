# coding: utf-8
require File.expand_path('../lib/vzaar_api/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'vzaar_api'
  s.version     = VzaarApi::VERSION
  s.authors     = ['vzaar']
  s.email       = ['support@vzaar.com']
  s.description = 'A Ruby gem for the vzaar API v2'
  s.summary     = "vzaar-#{s.version}"
  s.homepage    = 'http://vzaar.com'
  s.license     = 'MIT'

  s.platform              = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.0'
  s.rubygems_version      = ">= 2.5"

  s.files         = `git ls-files lib README.md`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'httpclient', '~> 2.8'
  s.add_dependency 'request_store', '~> 1.3'

  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency 'fuubar', '~> 2.2'
  s.add_development_dependency 'rake', '~> 10.5'
  s.add_development_dependency 'growl', '~> 1.0'
  s.add_development_dependency 'guard-rspec', '~> 4.6'
  s.add_development_dependency 'pry-byebug', '~> 3.4'
  s.add_development_dependency 'rspec', '~> 3.1'
  s.add_development_dependency 'vcr', '~> 3.0'
  s.add_development_dependency 'webmock', '~> 2.1'
end
