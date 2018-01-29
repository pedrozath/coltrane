# frozen_string_literal: true

module Coltrane
  module Cli
    # Renders notes in a common most popular ukulele scheme
    class Ukulele < Guitar
      SPECIAL_FRETS = [5, 7, 9, 12].freeze

      def initialize(notes, flavor, tuning: %w[G C E A], frets: 12)
        super
      end
    end
  end
end
