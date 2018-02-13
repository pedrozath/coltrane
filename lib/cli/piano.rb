# frozen_string_literal: true

module Coltrane
  module Cli
    # It allows rendering notes in an ASCII piano
    class Piano < Representation
      PIANO_TEMPLATE = <<~ASCII
        ┌─┬─┬┬─┬─╥─┬─┬┬─┬┬─┬─╥─┬─┬┬─┬─╥─┬─┬┬─┬┬─┬─┐
        │ │ ││ │ ║ │ ││ ││ │ ║ │ ││ │ ║ │ ││ ││ │ │
        │ │X││X│ ║ │X││X││X│ ║ │X││X│ ║ │X││X││X│ │
        │ │X││X│ ║ │X││X││X│ ║ │X││X│ ║ │X││X││X│ │
        │ ┕╥┙┕╥┙ ║ ┕╥┙┕╥┙┕╥┙ ║ ┕╥┙┕╥┙ ║ ┕╥┙┕╥┙┕╥┙ │
        │  ║  ║  ║  ║  ║  ║  ║  ║  ║  ║  ║  ║  ║  │
        │XX║XX║XX║XX║XX║XX║XX║XX║XX║XX║XX║XX║XX║XX│
        └──╨──╨──╨──╨──╨──╨──╨──╨──╨──╨──╨──╨──╨──┘
      ASCII

      def render
        PIANO_TEMPLATE.each_line.map.each_with_index do |l, ln|
          case ln
          when 2, 3 then replace_x(l, black_notes, 1, ln - 2)
          when 6 then replace_x(l, white_notes, 2)
          else l
          end
        end.join + "\n#{hint}"
      end

      private

      def replace_x(line, notes, size, index = 0)
        line.gsub('X' * size).with_index do |_match, i|
          note = notes[i % notes.size]
          next ' ' * size unless @notes.include?(note)
          Paint[replacer(note)[size == 2 ? 0..2 : index], 'red']
        end
      end

      def replacer(note)
        # TODO: Maybe extract this method into its own class/module
        case @flavor
        when :intervals then (@ref_note - note).name
        when :marks then '◼ '
        when :degrees then @notes.degree(note).to_s.rjust(2, '0')
        when :notes then note.pretty_name.to_s.ljust(2, "\u266E")
        end
      end

      def white_notes
        Coltrane::Scale.major.notes
      end

      def black_notes
        Coltrane::Scale.pentatonic_major('C#', 4).notes
      end
    end
  end
end
