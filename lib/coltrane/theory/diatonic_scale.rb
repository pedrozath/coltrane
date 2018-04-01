# frozen_string_literal: true

module Coltrane
  module Theory
    class DiatonicScale < Scale
      def initialize(tone, major: true)
        @major = major
        tone   = Note[tone]
        notes  = CircleOfFifths.new(tone - (major? ? 0 : 9), 7).notes.sort
        super notes: notes.rotate(notes.index(tone))
      end

      def name
        major? ? 'Major' : 'Natural Minor'
      end

      def relative_minor
        minor? ? self : self.class.new(@tone + 9, major: false)
      end

      def relative_major
        major? ? self : self.class.new(@tone - 9, major: true)
      end

      def relative
        major? ? relative_minor : relative_major
      end

      def major?
        !!@major
      end

      def minor?
        !@major
      end
    end
  end
end
