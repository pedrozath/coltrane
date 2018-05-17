module Coltrane
  module Theory
    class GreekMode < Scale
      attr_reader :mode

      MODES = %w[
        Ionian
        Dorian
        Phrygian
        Lydian
        Mixolydian
        Aeolian
        Locrian
      ].freeze

      LETTER_SEQUENCE = %w[C D E F G A B].freeze

      def initialize(mode, tone)
        super name: mode.capitalize, notes: begin
          @mode = mode.to_s
          @tone = Note[tone]
          base_major_notes
          .rotate(mode_index)
          .zip(letter_sequence)
          .map { |(note, letter)| note.as(letter) }
        end
      end

      private

      def letter_sequence
        LETTER_SEQUENCE.yield_self { |seq| seq.rotate(seq.index(tone.letter))}
      end

      def mode_index
        @mode_index ||= MODES.map(&:downcase).index(mode.to_s)
      end

      def base_major_notes
        base_scale    = DiatonicScale.new(Note['C']).notes
        base_interval = base_scale[0] - base_scale[mode_index]
        DiatonicScale.new(Note[tone] - base_interval).notes
      end
    end
  end
end
