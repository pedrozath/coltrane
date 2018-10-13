# frozen_string_literal: true

require 'coltrane'
require 'coltrane/representation'
require 'coltrane/renderers'
require 'coltrane/commands/command'

Dir["#{Dir.pwd}/lib/coltrane/commands/*"].map do |command_file|
  require(command_file)
end
