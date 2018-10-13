module Coltrane
  module Commands
    class FindChordByNotes < Command
      def run(notes)
        Theory::Chord.new(notes: notes)
      end
    end
  end
end