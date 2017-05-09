$LOAD_PATH << __dir__

require 'bundler'

Bundler.require

ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'cache', 'caches'
end

ActiveRecord::Base.establish_connection YAML.load_file("#{__dir__}/../db/config.yml")['production']
# require "#{__dir__}/../db/schema.rb"

require 'coltrane/cadence'

require 'coltrane/qualities'
require 'coltrane/chord_quality'
require 'coltrane/chord'

require 'coltrane/classic_scales'
require 'coltrane/fret_set'

require 'coltrane/piano_representation'
require 'coltrane/guitar_representation'
require 'coltrane/essential_guitar_chords'
require 'coltrane/guitar_chord_finder'
require 'coltrane/guitar_note_set'
require 'coltrane/guitar_chord'
require 'coltrane/guitar_note'
require 'coltrane/guitar_string'
require 'coltrane/guitar'

require 'coltrane/interval_sequence'
require 'coltrane/interval_set'
require 'coltrane/interval'

require 'coltrane/note_set'
require 'coltrane/note'

require 'coltrane/pitch'
require 'coltrane/progression'
require 'coltrane/scale'
require 'coltrane/mode'

require 'coltrane/scale_chord'
require 'coltrane/chord_cache'
require 'coltrane/scale_cache'
# require 'terminal_input'