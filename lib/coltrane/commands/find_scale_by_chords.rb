module Coltrane
  module Commands
    class FindScaleByChords < Command
      def run(chords)
        Theory::Scale.having_chords(*chords)
      end
    end
  end
end
