# frozen_string_literal: true

module Coltrane

  # Allows the creation of chord progressions using standard notations.
  # Ex: Progression.new('I-IV-V', key: 'Am')
  class Progression
    extend NotableProgressions
    include Changes
    attr_reader :scale, :chords, :notation

    def self.find(*chords)
      if chords[0].is_a?(String)
        chords.map! { |c| Chord.new(name: c) }
      end

      root_notes = NoteSet[*chords.map(&:root_note)]

      scales = Scale.having_notes(*root_notes).scales
      progressions = scales.reduce([]) do |memo, scale|
        memo + [Progression.new(chords: chords, scale: scale)]
      end

      progressions.sort_by(&:notes_out_size)
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

    def notes
      NoteSet[*chords.map(&:notes).map(&:notes).flatten]
    end

    def notes_out
      notes - scale.notes
    end

    def notes_out_size
      notes_out.size
    end
  end
end
