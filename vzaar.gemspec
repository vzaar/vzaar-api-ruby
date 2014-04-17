# coding: utf-8
require File.expand_path('../lib/vzaar/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = 'vzaar-api'
  s.version       = Vzaar::VERSION
  s.authors       = ['Ed James', 'Jozef Chraplewski']
  s.email         = ['ed@vzaar.com', 'jozef@vzaar.com']
  s.description   = 'A Ruby gem for the vzaar API'
  s.summary       = "vzaar-#{s.version}"
  s.homepage      = 'http://vzaar.com'
  s.license       = 'MIT'

  s.platform      = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.9'
  s.rubygems_version  = ">= 1.6.1"

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(spec)/})
  s.require_paths = ['lib']

  s.add_dependency 'nokogiri', '~> 1.6'
  s.add_dependency 'httpclient', '~> 2.3'
  s.add_dependency 'oauth', '~> 0.4'

  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency "fuubar", "~> 1.2"
  s.add_development_dependency 'rake', '~> 0'
  s.add_development_dependency "growl", "~> 1.0"
  s.add_development_dependency "guard-rspec", "~> 4.0"
  s.add_development_dependency "rspec", "~> 2.14"
  s.add_development_dependency "vcr", "~> 2.7"
  s.add_development_dependency "webmock", "~> 1.16"
end
