module Coltrane
  class Progression
    extend ClassicProgressions

    attr_reader :scale

    def initialize(roman_notation, key: nil, scale: nil)
      if !key.nil?
        @scale = Scale.from_key(key)
      end
    end

    # def chords

    # end

    private

    def chord_indexes
      scale.degrees.map { |d| d-1 }
    end
  end
end