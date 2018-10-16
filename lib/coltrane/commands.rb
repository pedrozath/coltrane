# frozen_string_literal: true

require 'coltrane'
require 'coltrane/representation'
require 'coltrane/renderers'
require 'coltrane/commands/command'

Dir[File.expand_path('../commands/*', __FILE__)].map do |f|
  require(f)
end
