module Coltrane
  module Commands
    class GetRepresentationChords < Command
      def run(representation, chords, guitar = nil)
        chords.map do |chord|
          if representation == 'GuitarChordChart'
            guitar_instance = guitar || Representation::Guitar.new
            {
              chord.name => guitar_instance.find_chords(chord).first(4),
              options: { layout: :horizontal, per_row: 4 }
            }
          else
            { chord.name => GetRepresentationNotes.run(representation, chord.notes, guitar) }
          end
        end
      end
    end
  end
end
