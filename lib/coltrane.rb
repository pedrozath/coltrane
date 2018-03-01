# frozen_string_literal: true

require 'json'
require 'forwardable'
require 'core_ext'
require 'ostruct'


# The main module for working with Music Theory
module Coltrane
  autoload :Frequency,              'coltrane/frequency'

  BASE_OCTAVE = 4
  BASE_PITCH_INTEGER = 9

  def self.tuning=(f)
    @base_tuning = Frequency[f].octave(-4)
  end

  def self.base_tuning
    @base_tuning
  end

  @base_tuning = Frequency[440].octave(-4)

  require 'coltrane/version'
  require 'coltrane/errors'

  autoload :Pitch,                  'coltrane/pitch'
  autoload :Voicing,                'coltrane/voicing'

  autoload :PitchClass,             'coltrane/pitch_class'
  autoload :Note,                   'coltrane/note'
  autoload :NoteSet,                'coltrane/note_set'

  autoload :Interval,               'coltrane/interval'
  autoload :IntervalClass,          'coltrane/interval_class'
  autoload :UnorderedIntervalClass, 'coltrane/unordered_interval_class'
  autoload :IntervalSequence,       'coltrane/interval_sequence'
  autoload :Qualities,              'coltrane/qualities'
  autoload :ChordQuality,           'coltrane/chord_quality'
  autoload :Chord,                  'coltrane/chord'
  autoload :ChordSubstitutions,     'coltrane/chord_substitutions'
  autoload :RomanChord,             'coltrane/roman_chord'

  autoload :ClassicScales,          'coltrane/classic_scales'
  autoload :Scale,                  'coltrane/scale'
  autoload :CircleOfFifths,         'coltrane/circle_of_fifths'
  autoload :DiatonicScale,          'coltrane/diatonic_scale'
  autoload :Key,                    'coltrane/key'

  autoload :NotableProgressions,    'coltrane/notable_progressions'
  autoload :Changes,                'coltrane/changes'
  autoload :Cadence,                'coltrane/cadence'
  autoload :Progression,            'coltrane/progression'
  autoload :Mode,                   'coltrane/mode'
end
