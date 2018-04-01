# frozen_string_literal: true

module Coltrane
  module Representation
    class Guitar
      class Note
        attr_reader :string, :fret

        def initialize(string, fret = nil)
          @string = string
          @fret   = fret
        end

        def pitch
          string + fret unless fret.nil?
        end

        def pitch_class
          pitch.pitch_class unless fret.nil?
        end

        alias note pitch_class
      end
    end
  end
end