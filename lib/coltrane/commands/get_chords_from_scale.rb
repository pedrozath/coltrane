module Coltrane
  module Commands
    class GetChordsFromScale < Command
      def run(scale, type, size)
        scale.send(type == 'tertians' ? :tertians : :chords)
      end
    end
  end
end
