module Coltrane
  # It describes a group of guitar notes
  class GuitarChord < GuitarNoteSet

    class << self
      def new_from_notes(guitar_notes)
        new(*frets_in_sequence(guitar_notes))
      end

      def frets_in_sequence(guitar_notes)
       gns = guitar_notes.sort_by(&:guitar_string_index)
                   .map(&:position)
                   .map{|g| g[:fret]}

        (0..5).to_a.reverse.map do |i|
          gns[i]
        end
      end
    end

    def initialize(*frets_in_sequence)
      arg = frets_in_sequence.each_with_index.map do |fret, i|
        { fret: fret, guitar_string_index: i }
      end
      super(arg)
    end

    def frets_in_sequence
      self.class.frets_in_sequence(guitar_notes)
    end
  end
end