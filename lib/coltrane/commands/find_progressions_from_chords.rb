module Coltrane
  module Commands
    class FindProgressionsFromChords < Command
      def run(*chords)
        Theory::Progression.find(*chords)
      end
    end
  end
end