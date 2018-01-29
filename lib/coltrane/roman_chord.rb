# frozen_string_literal: true

module Coltrane
  attr_reader :degree, :quality

  # It deals with chords in roman notation
  class RomanChord
    DIGITS = %w[I II III IV V VI VII].freeze
    NOTATION_REGEX = %r{
      (?<degree>[ivIV]*)
      (?<quality>.*)
    }x

    def initialize(scale, notation)
      @scale    = scale
      @notation = notation.match(NOTATION_REGEX).named_captures
    end

    def degree
      DIGITS.index(@notation['degree'].upcase) + 1
    end

    def quality_name
      [
        minor_notation,
        @notation['quality'].gsub('o', 'dim').gsub('ø', 'm7b5')
      ].join
    end

    def minor_notation
      return 'm' if !@notation['quality'].match?((/dim|m7b5/)) && !upcase?
    end

    def upcase?
      !!(@notation['degree'][0].match /[[:upper:]]/)
    end

    def chord
      Chord.new root_note: root_note,
                quality: quality
    end

    def quality
      q = quality_name
      ChordQuality.new(name: (q.size.zero? ? 'M' : q))
    end

    def root_note
      @scale[@degree]
    end
  end
end
