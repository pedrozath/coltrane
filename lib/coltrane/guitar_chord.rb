module Coltrane
  # It describes a group of guitar notes
  class GuitarChord < GuitarNoteSet

    class << self
      def new_from_notes(guitar_notes)
        new(*frets_in_sequence(guitar_notes))
      end

      def new_from_frets(*frets)
        gns = (0..5).each_with_object([]) do |string_index, memo|
          fret = frets[5-string_index]
          unless fret.nil?
            memo << GuitarNote.new(guitar_string_index: string_index,
                                   fret: fret)
          end
        end
        new_from_notes(gns)
      end

      def frets_in_sequence(guitar_notes)
        guitar_notes.each_with_object([]) do |gn, memo|
          memo[gn.guitar_string_index] = gn.fret
        end
      end
    end

    def initialize(*frets_in_sequence)
      arg = frets_in_sequence.each_with_index.map do |fret, i|
        { fret: fret, guitar_string_index: i }
      end
      super(arg)
    end

    def chord
      Chord.new(notes)
    end

    def frets_in_sequence
      self.class.frets_in_sequence(guitar_notes)
    end

    def to_s
      fs = frets_in_sequence
      (0..5).map { |x|
        fs[5-x].nil? ? 'X ' : fs[5-x].to_s.ljust(2,' ')
      }.join(' ')
    end
  end
end