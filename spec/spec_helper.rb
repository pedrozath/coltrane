# frozen_string_literal: true

require 'simplecov'

SimpleCov.start

$LOAD_PATH.unshift(File.expand_path('../../', __FILE__))

require 'bundler'
Bundler.require(:test)

require 'tty-prompt'
require 'coltrane'
require 'coltrane/representation'
require 'coltrane/renderers'

include Coltrane::Theory
include Coltrane::Representation
include Coltrane::Renderers

RSpec.configure
