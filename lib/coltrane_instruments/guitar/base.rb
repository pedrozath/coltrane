# frozen_string_literal: true

module ColtraneInstruments
  module Guitar
    # A base class for operations involving Guitars
    class Base
      def initialize; end

      def find_chord(target_chord)
        Chord.new(target_chord, guitar: self).fetch_descendant_chords
      end
    end
  end
end
