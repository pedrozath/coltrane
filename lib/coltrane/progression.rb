module Coltrane
  class Progression
    extend ClassicProgressions

    attr_reader :scale

    def initialize(roman_notation, key: nil, scale: nil)
      if !key.nil?
        @scale = get_scale_from_key(key)
      end
    end

    def chords
      all_chords.values_at(*chord_indexes)
    end

    def on_guitar
      chords.map(&:on_guitar)
    end

    def on_piano
      chords.map(&:on_piano)
    end

    private

    def all_chords
      scale.sevenths
    end

    def chord_indexes
      degrees.map { |d| d-1 }
    end
  end
end