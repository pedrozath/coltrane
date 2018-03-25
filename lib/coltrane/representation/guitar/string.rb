# frozen_string_literal: true

module Coltrane
  module Representation
    class Guitar
      class String
        attr_reader :pitch, :guitar

        def initialize(pitch, guitar:)
          @guitar = guitar
          @pitch = pitch
        end

        def find(pitch_class, possible_frets: (0..guitar.frets).to_a)
          output = []
          n = 0
          loop do
            f = (pitch_class.integer - pitch.integer) % 12 + 12 * n
            possible_frets.include?(f) ? output << Note.new(self, f) : break
            n += 1
          end
          output
        end

        def +(fret)
          pitch + fret
        end
      end
    end
  end
end