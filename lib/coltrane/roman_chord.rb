# frozen_string_literal: true

module Coltrane
  # It deals with chords in roman notation
  class RomanChord
    DIGITS = {
      'I'   => 1,
      'V'   => 5
    }.freeze

    def initialize(scale, roman_numeral)
      @scale = scale
      @roman_numeral = roman_numeral
    end

    def to_chord
      Chord.new root_note: root_note,
                quality: quality
    end

    def root_note
      @scale[degree]
    end

    def degree
      @roman_numeral.split('').reduce(0) do |memo, r|
        memo + (DIGITS[r] || 0) + (DIGITS[r.swapcase] || 0)
      end
    end

    def quality
      ChordQuality.new(name: major? ? 'M' : 'm')
    end

    def major?
      @roman_numeral[0] =~ /[[:upper]]/
    end
  end
end
