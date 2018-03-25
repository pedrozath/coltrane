# frozen_string_literal: true

require 'coltrane/representation/guitar'

module Coltrane
  module Representation
    class Ukulele < Guitar
      def initialize(tuning: %w[G3 C4 E4 A4],
                     frets: 12,
                     special_frets: [5, 7, 9, 12])
      super
      end
    end

    class Bass < Guitar
      def initialize(tuning: %w[E1 A1 D2 G2])
      super
      end
    end
  end
end
