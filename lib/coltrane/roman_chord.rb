# frozen_string_literal: true

module Coltrane
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

    def initialize(notation=nil, chord: nil, key: nil, scale: nil)
      if notation.nil? && chord.nil? || key.nil? && scale.nil?
        raise WrongKeywordsError,
          '[notation, [scale: || key:]] '\
          '[chord:, [scale: || key:]] '\
      end
      @scale = scale || Scale.from_key(key)
      if notation
        @notation = notation
      elsif chord
        @chord = chord.is_a?(String) ? Chord.new(name: chord) : chord
      end
    end

    def degree
      return @scale.degree_of_note(root_note) unless @chord.nil?
      d      = regexed_notation['degree']
      @flats = d.count('b')
      d      = d.delete('b')
      @degree ||= DIGITS.index(d.upcase) + 1
    end

    def roman_numeral
      r = DIGITS[degree]
      minor? ? r.downcase : r
    end

    def upcase?
      !!(regexed_notation['degree'][0].match /[[:upper:]]/)
    end

    def chord
      @chord ||= Chord.new root_note: root_note,
                           quality: quality
    end

    def minor?
      quality.has_minor_third?
    end

    def major?
      quality.has_major_third?
    end

    def quality_name
      return @chord.quality.name unless @chord.nil?
      q     = normalize_quality_name(regexed_notation['quality'])
      minor = 'm' if !q.match?((/dim|m7b5/)) && !upcase?
      q     = [minor, q].join
      q.empty? ? 'M' : q
    end

    def quality
      return @chord.quality unless @chord.nil?
      ChordQuality.new(name: quality_name) if quality_name
    end

    def root_note
      return @chord.root_note unless @chord.nil?
      @scale[degree] - @flats
    end

    def notation
      q = case quality_name
      when 'm', 'M' then ''
      when 'm7', 'M' then '7'
      else quality_name
      end

      @notation ||= [
        roman_numeral,
        q,
      ].join
    end

    def function
      return if @scale.name != 'Major'
      %w[Tonic Supertonic Mediant Subdominant
        Dominant Submediant Leading][degree - 1]
    end

    private

    def regexed_notation
      @regexed_notation ||= @notation.match(NOTATION_REGEX).named_captures
    end

    def normalize_quality_name(quality_name)
      NOTATION_SUBSTITUTIONS.reduce(quality_name) do |memo, subs|
        break memo if memo.empty?
        memo.gsub(*subs)
      end
    end
  end
end
