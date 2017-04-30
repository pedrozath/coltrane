module Coltrane
  # It describes a group of guitar notes
  class GuitarChord < GuitarNoteSet

    def initialize(*frets_in_sequence)
      arg = frets_in_sequence.each_with_index.map do |fret, i|
        { fret: fret, guitar_string_index: i }
      end
      super(arg)
    end

    def frets_in_sequence
      guitar_notes.sort_by(&:guitar_string_index).map(&:fret)
    end
  end
end