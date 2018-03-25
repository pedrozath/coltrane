# frozen_string_literal: true

module Coltrane
  # This class describes an actual implementation of a Chord, being aware
  # of exact octaves of each pitch and even repeating pitches across octaves.
  class Voicing
    attr_reader :pitches

    def initialize(*pitch_strings, pitches: nil)
      @pitches = if pitch_strings.any?
                   pitch_strings.map { |s| Pitch[s] }
                 elsif pitches
                   pitches
                 else
                   raise WrongArgumentsError
                 end
    end

    def self.[](*args)
      new(*args)
    end

    def pitch_classes
      NoteSet[*pitches.map(&:pitch_class).uniq]
    end

    alias notes pitch_classes

    def chord
      @chord ||= Chord.new(notes: notes)
    rescue ChordNotFoundError
      return false
    end

    def frequencies
      pitches.map(&:frequency)
    end
  end
end
