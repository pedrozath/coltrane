module Coltrane
  module Cli
    class Piano
      PIANO_TEMPLATE = <<~ASCII
        ┌─┬─┬┬─┬─╥─┬─┬┬─┬┬─┬─╥─┬─┬┬─┬─╥─┬─┬┬─┬┬─┬─┐
        │ │ ││ │ ║ │ ││ ││ │ ║ │ ││ │ ║ │ ││ ││ │ │
        │ │X││X│ ║ │X││X││X│ ║ │X││X│ ║ │X││X││X│ │
        │ │X││X│ ║ │X││X││X│ ║ │X││X│ ║ │X││X││X│ │
        │ ┕╥┙┕╥┙ ║ ┕╥┙┕╥┙┕╥┙ ║ ┕╥┙┕╥┙ ║ ┕╥┙┕╥┙┕╥┙ │
        │XX║XX║XX║XX║XX║XX║XX║XX║XX║XX║XX║XX║XX║XX│
        └──╨──╨──╨──╨──╨──╨──╨──╨──╨──╨──╨──╨──╨──┘
      ASCII

      def initialize(notes)
        @notes    = notes
        @ref_note = notes.first
      end

      def render_intervals
        PIANO_TEMPLATE.each_line.map.each_with_index do |l, ln|
          case ln
          when 2, 3 then replace_x(l, black_notes, 1, ln - 2)
          when 5 then replace_x(l, white_notes, 2)
          else l
          end
        end.join
      end

      private

      def replace_x(line, notes, size, index=0)
        line.gsub('X'*size).with_index do |match, i|
          note = notes[i%notes.size]
          next ' '*size unless @notes.include?(note)
          interval_name = (@ref_note - note).name
          Paint[interval_name[size == 2 ? 0..2 : index ], 'red']
        end
      end

      def white_notes
        Coltrane::Scale.major.notes
      end

      def black_notes
        Coltrane::Scale.pentatonic_major('C#',4).notes
      end
    end
  end
end