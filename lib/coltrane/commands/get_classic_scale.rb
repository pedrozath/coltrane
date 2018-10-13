module Coltrane
  module Commands
    class GetClassicScale < Command
      def run(scale, tone)
        Theory::Scale.fetch(scale, tone)
      end
    end
  end
end