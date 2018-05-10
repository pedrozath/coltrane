# frozen_string_literal: true

module Coltrane
  module Theory
    # This class describes an actual implementation of a Chord, being aware
    # of exact octaves of each pitch and even repeating pitches across octaves.
    class Voicing

      attr_reader :pitches

      def initialize(*pitch_strings, pitches: nil)
        @pitches = begin
          if pitch_strings.any?
           pitch_strings.map { |s| Pitch[s] }
          elsif pitches
           pitches
          else
           raise WrongArgumentsError
          end
        end.sort
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
        @frequencies ||= pitches.map(&:frequency)
      end

      def discontinuity
        frequencies.each_with_index.reduce(0) do |max_dist, (freq, index)|
          next 0 if index.zero?
          [max_dist, freq.to_f - frequencies[index - 1].to_f].max
        end
      end

      private

      def ideal_frequency_distance
        (Pitch['D3'].frequency - Pitch['A2'].frequency).to_f
      end

    end
  end
end
