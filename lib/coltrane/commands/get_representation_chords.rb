module Coltrane
  module Commands
    class GetRepresentationChords < Command
      def run(representation, chords)
        chords.map do |chord|
          if representation == 'GuitarChordChart'
            {
              chord.name => Representation::Guitar.find_chords(chord).first(4),
              options: { layout: :horizontal, per_row: 4 }
            }
          else
            { chord.name => GetRepresentationNotes.run(representation, chord.notes) }
          end
        end
      end
    end
  end
end
