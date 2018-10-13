module Coltrane
  module Commands
    class AvailableClassicScales < Command
      def run
        Theory::Scale.known_scales
      end
    end
  end
end