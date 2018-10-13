module Coltrane
  module Commands
    class FindCommonChords < Command
      def run(*scales)
        scales.map(&:chords).reduce(&:&)
      end
    end
  end
end