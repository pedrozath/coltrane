require 'simplecov'
SimpleCov.start
$LOAD_PATH.unshift(File.expand_path('../../', __FILE__))

require 'bundler'
Bundler.require(:test)

require 'coltrane'
require 'rspec-command'
include Coltrane

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.configure do |config|
  config.include RSpecCommand
end