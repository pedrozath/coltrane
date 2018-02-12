# frozen_string_literal: true

module Coltrane

  # Allows the creation of chord progressions using standard notations.
  # Ex: Progression.new('I-IV-V', key: 'Am')
  class Progression
    extend ClassicProgressions
    attr_reader :scale, :chords, :notation

    def self.find(*chords)
      chords.map! { |c| Chord.new(name: c) } if chords[0].is_a?(String)
      scales = Scale.having_chords(*chords).scales
      scales.reduce([]) do |memo, scale|
        memo + [Progression.new(chords: chords, scale: scale)]
      end
    end

    def initialize(notation=nil, chords: nil, roman_chords: nil, key: nil, scale: nil)
      if notation.nil? && chords.nil? && roman_chords.nil? || key.nil? && scale.nil?
        raise WrongKeywordsError,
          '[chords:, [scale: || key:]] '\
          '[roman_chords:, [scale: || key:]] '\
          '[notation:, [scale: || key:]] '\
      end

      @scale  = scale || Scale.from_key(key)
      @chords =
        if !chords.nil?
          chords
        elsif !roman_chords.nil?
          roman_chords.map(&:chord)
        elsif !notation.nil?
          @notation = notation
          notation.split('-').map {|c| RomanChord.new(c, scale: @scale).chord }
        end
    end

    def interval_sequence
      @interval_sequence ||= IntervalSequence(notes: @root_notes)
    end

    def root_notes
      @root_notes ||= @chords.map(&:root_note)
    end

    def roman_chords
      @roman_chords ||= chords.map do |c|
        RomanChord.new(chord: c, scale: scale)
      end
    end

    def notation
      roman_chords.map(&:notation).join('-')
    end
  end
end
