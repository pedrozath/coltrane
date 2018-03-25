# frozen_string_literal: true

module Coltrane
  module Theory
    class ProgressionSet
      extend Forwardable
      include Enumerable

      def_delegators :progressions, :each

      attr_accessor :progressions

      def initialize(*progressions)
        @progressions = progressions.sort_by(&:notes_out_size)
      end
    end
  end
end
