module Coltrane
  module Commands
    class AvailableRepresentations < Command
      def run
        ['Text'] + Representation.constants.map(&:to_s)
      end
    end
  end
end
