module ColtraneInstruments
  module Guitar
    class Base
      def initialize
      end

      def find_chord(target_chord)
        Chord.new(target_chord, guitar: self).fetch_descendant_chords
      end
    end
  end
end