require 'coltrane/representation/piano/note_set'

module Coltrane
  module Representation
    class Piano
      attr_reader :octaves

      class << self

        def find_notes(notes)
          Piano::NoteSet.new(notes, piano: new)
        end

        def chord(chord)
          find_notes(
            chord.is_a?(Chord) ? chord.notes : Chord.new(name: chord).notes
          )
        end

        def black_notes
          Theory::Scale.pentatonic_major('C#', 4).notes
        end

        def white_notes
          Theory::Scale.major.notes
        end

      end

      def initialize
        @octaves
      end
    end
  end
end

