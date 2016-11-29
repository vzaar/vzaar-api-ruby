$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'vzaar_api'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["./examples/support/**/*.rb"].each {|f| require f}

RSpec.configure do |c|
  c.include Helpers
  c.order = 'defined'
end

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
end
