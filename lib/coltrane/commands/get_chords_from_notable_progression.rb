module Coltrane
  module Commands
    class GetChordsFromNotableProgression < Command
      def run(progression, key)
        Theory::Progression.send(progression.underscore, key).chords
      end
    end
  end
end
