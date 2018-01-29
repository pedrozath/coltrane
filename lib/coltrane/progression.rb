# frozen_string_literal: true

module Coltrane
  # Allows creation of chord progressions
  class Progression
    extend ClassicProgressions

    attr_reader :scale

    def initialize(_roman_notation, key: nil, scale: nil)
      @scale = Scale.from_key(key) unless key.nil?
    end

    # def chords

    # end

    private

    def chord_indexes
      scale.degrees.map { |d| d - 1 }
    end
  end
end
