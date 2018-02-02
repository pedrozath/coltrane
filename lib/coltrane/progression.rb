# frozen_string_literal: true

module Coltrane
  # Allows creation of chord progressions
  class Progression
    extend ClassicProgressions

    attr_reader :scale

    def initialize(roman_notation, key: nil, scale: nil)
      @scale = Scale.from_key(key) unless key.nil?
    end

    def chords

    end
  end
end
