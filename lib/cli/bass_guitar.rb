# frozen_string_literal: true

module Coltrane
  module Cli
    # Renders notes in a bass guitar scheme
    class BassGuitar < Guitar
      def initialize(notes, flavor, tuning: %w[E A D G])
        super
      end
    end
  end
end
