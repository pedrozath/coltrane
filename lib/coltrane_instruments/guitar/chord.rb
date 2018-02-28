module ColtraneInstruments
  module Guitar
    class Chord
      def initialize(target_chord, guitar_notes: [],
                                   free_fingers: 4,
                                   barre: nil,
                                   guitar:)
        @target_chord = target_chord
        @guitar_notes = guitar_notes
        @free_fingers = free_fingers
        @barre = barre
      end

      def barre?
        !@barre.nil?
      end

      def fetch_descendant_chords
        return self if guitar_notes.size < guitar.strings
        possible_new_notes.reduce([]) do |memo, n|
          fingers_change = n.fret == @barre ? 0 : 1
          return self unless @free_fingers - fingers_change < 0
          guitar.create_chord target_chord,
                              guitar_notes: @guitar_notes + n,
                              free_fingers: @free_fingers - fingers_change
                              barre: @barre
            .fetch_descendant_chords + memo
        end
      end

      def possible_new_notes
      end

      private

      def barre=(fret)
        @barre = fret
      end
    end
  end
end