module Coltrane
  module Commands
    class GetChordsFromString < Command
      def run(string)
        string.split(' ').map do |chord|
          Theory::Chord.new(name: chord)
        end
      end
    end
  end
end
