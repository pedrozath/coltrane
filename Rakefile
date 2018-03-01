# require "bundler/gem_tasks"
task :default => :spec

require 'opal/rspec/rake_task'
Opal::RSpec::RakeTask.new(:opal_specs) do |server, task|
  task.pattern = 'spec/{coltrane_instruments,lib}/**/*_spec.rb'
end