# frozen_string_literal: true

module Coltrane
  attr_reader :degree, :quality

  # This class deals with chords in roman notation. Ex: IVº.
  class RomanChord
    DIGITS = %w[I II III IV V VI VII].freeze
    NOTATION_REGEX = %r{
      (?<degree>b?[ivIV]*)
      (?<quality>.*)
    }x

    NOTATION_SUBSTITUTIONS = [
      %w[º dim],
      %w[o dim],
      %w[ø m7b5]
    ]

    def initialize(notation, key: nil, scale: nil)
      @scale   = scale || Scale.from_key(key)
      notation = notation.match(NOTATION_REGEX).named_captures
      notation['quality'] =
        NOTATION_SUBSTITUTIONS.reduce(notation['quality']) do |memo, subs|
          break memo if memo.empty?
          memo.gsub(*subs)
        end

      @notation = notation
    end

    def degree
      d      = @notation['degree']
      @flats = d.count('b')
      d      = d.delete('b')
      @degree ||= DIGITS.index(d.upcase) + 1
    end

    def quality_name
      [
        minor_notation,
        @notation['quality']
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
      @scale[degree] - @flats
    end
  end
end
