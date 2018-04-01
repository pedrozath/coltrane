module Coltrane
  module Renderers
    module TextRenderer
      class RepresentationPianoNoteSetDrawer < BaseDrawer
        alias note_set model

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
            when 2, 3 then replace_x(l, Representation::Piano.black_notes, 1, ln - 2)
            when 6    then replace_x(l, Representation::Piano.white_notes, 2)
            else l
            end
          end.join
        end

        private

        def replace_x(line, notes, size, index = 0)
          line.gsub('X' * size).with_index do |_match, i|
            note = notes[i % notes.size]
            next ' ' * size unless note_set.include?(note)
            Paint[replacer(note)[size == 2 ? 0..2 : index], 'red']
          end
        end

        def replacer(note)
          case flavor
          when :intervals then (note_set.root - note).name
          when :marks then '◼ '
          when :degrees then note_set.notes.degree(note).to_s.rjust(2, '0')
          when :notes then note.pretty_name.to_s.ljust(2, "\u266E")
          end
        end
      end
    end
  end
end
