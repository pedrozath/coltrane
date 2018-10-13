module Coltrane
  module Commands
    class GetChordsFromProgression < Command
      def run(notation, key)
        Theory::Progression.new(notation, key: key).chords
      end
    end
  end
end
