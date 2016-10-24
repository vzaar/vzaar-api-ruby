guard :rspec, cmd: "bundle exec rspec", all_on_start: true do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)
  clearing :on

  # Feel free to open issues for suggestions and improvements

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)

  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/vzaar.rb$})           { "spec" }
  watch(%r{^lib/vzaar/(.+)\.rb$})     { "spec" }
  watch(%r{^spec/support/(.+)\.rb$})  { 'spec' }
  watch('spec/spec_helper.rb')        { "spec" }
end
