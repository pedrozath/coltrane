require 'opal/rspec'

# or use Opal::RSpec::SprocketsEnvironment.new(spec_pattern='spec/opal/**/*_spec.{rb,opal}') to customize the pattern
sprockets_env = Opal::RSpec::SprocketsEnvironment.new
run Opal::Server.new(sprockets: sprockets_env) { |s|
  s.main = 'opal/rspec/sprockets_runner'
  sprockets_env.spec_exclude_pattern = 'spec/exe/**/*_spec.rb'
  sprockets_env.add_spec_paths_to_sprockets
  s.debug = true
}