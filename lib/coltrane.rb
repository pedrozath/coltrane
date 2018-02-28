# frozen_string_literal: true

require 'yaml'

require 'forwardable'
require 'facets/multiton'
require 'core_ext'
require 'ostruct'

require 'coltrane/version'
require 'coltrane/errors'
require 'coltrane/cadence'

require 'coltrane/frequency'
require 'coltrane/pitch'
require 'coltrane/pitch_class'
require 'coltrane/note'
require 'coltrane/note_set'

require 'coltrane/interval'
require 'coltrane/interval_class'
require 'coltrane/unordered_interval_class'
require 'coltrane/interval_sequence'

require 'coltrane/chord_quality'

require 'coltrane/chord_substitutions'
require 'coltrane/chord'
require 'coltrane/roman_chord'

require 'coltrane/classic_scales'
require 'coltrane/scale'

require 'coltrane/notable_progressions'
require 'coltrane/changes'
require 'coltrane/progression'

require 'coltrane/mode'

# The main module for working with Music Theory
module Coltrane
  BASE_OCTAVE = 4
  BASE_PITCH_INTEGER = 9

  def self.tuning=(f)
    @base_tuning = Frequency[f].octave(-4)
  end

  def self.base_tuning
    @base_tuning
  end

  @base_tuning = Frequency[440].octave(-4)
end
