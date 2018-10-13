module Coltrane
  module Commands
    class AvailableNotableProgressions < Command
      def run
        Theory::NotableProgressions::PROGRESSIONS.keys
      end
    end
  end
end