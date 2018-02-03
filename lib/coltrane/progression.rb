# frozen_string_literal: true

module Coltrane

  # Allows the creation of chord progressions using standard notations.
  # Ex: Progression.new('I-IV-V', key: 'Am')
  class Progression
    extend ClassicProgressions
    attr_reader :scale, :chords

    def initialize(roman_notation, roman_chords: [], key: nil, scale: nil)
      @scale  = scale || Scale.from_key(key)
      rchords = roman_chords.any? ? roman_chords : roman_notation.split('-')
      @chords = rchords.map {|c| RomanChord.new(c, scale: @scale).chord }
    end
  end
end
