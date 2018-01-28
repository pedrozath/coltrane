module Coltrane
  module Cli
    class Ukulele < Guitar
      SPECIAL_FRETS = [5, 7, 9, 12]

      def initialize(notes, flavor, tuning: %w[G C E A], frets: 12)
        super
      end
    end
  end
end