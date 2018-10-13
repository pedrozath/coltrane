module Coltrane
  module Commands
    class AvailableChordRepresentations < Command
      def run
        return ['GuitarChordChart'] + AvailableRepresentations.run
      end
    end
  end
end
