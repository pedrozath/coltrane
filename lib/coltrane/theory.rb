# frozen_string_literal: true

module Coltrane
  # The main module for working with Music Theory
  module Theory
    require 'coltrane/theory/errors'
    autoload :Frequency, 'coltrane/theory/frequency'

    BASE_OCTAVE = 4
    BASE_PITCH_INTEGER = 9

    def self.tuning=(f)
      @base_tuning = Frequency[f].octave(-4)
    end

    def self.base_tuning
      @base_tuning
    end

    @base_tuning = Frequency[440].octave(-4)

    autoload :Pitch,                  'coltrane/theory/pitch'
    autoload :Voicing,                'coltrane/theory/voicing'

    autoload :PitchClass,             'coltrane/theory/pitch_class'
    autoload :Note,                   'coltrane/theory/note'
    autoload :NoteSet,                'coltrane/theory/note_set'

    autoload :FrequencyInterval,      'coltrane/theory/frequency_interval'
    autoload :IntervalClass,          'coltrane/theory/interval_class'
    autoload :Interval,               'coltrane/theory/interval'
    autoload :UnorderedIntervalClass, 'coltrane/theory/unordered_interval_class'
    autoload :IntervalSequence,       'coltrane/theory/interval_sequence'
    autoload :Qualities,              'coltrane/theory/qualities'
    autoload :ChordQuality,           'coltrane/theory/chord_quality'
    autoload :Chord,                  'coltrane/theory/chord'
    autoload :ChordSubstitutions,     'coltrane/theory/chord_substitutions'
    autoload :RomanChord,             'coltrane/theory/roman_chord'

    autoload :ClassicScales,          'coltrane/theory/classic_scales'
    autoload :Scale,                  'coltrane/theory/scale'
    autoload :ScaleSet,               'coltrane/theory/scale_set'
    autoload :CircleOfFifths,         'coltrane/theory/circle_of_fifths'
    autoload :DiatonicScale,          'coltrane/theory/diatonic_scale'
    autoload :Key,                    'coltrane/theory/key'

    autoload :NotableProgressions,    'coltrane/theory/notable_progressions'
    autoload :Changes,                'coltrane/theory/changes'
    autoload :Cadence,                'coltrane/theory/cadence'
    autoload :ProgressionSet,         'coltrane/theory/progression_set'
    autoload :Progression,            'coltrane/theory/progression'
    autoload :Mode,                   'coltrane/theory/mode'
  end
end
