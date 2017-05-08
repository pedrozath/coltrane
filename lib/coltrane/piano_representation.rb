class PianoRepresentation
  PIANO_TEMPLATE = <<~ASCII
    ┌─┬─┬┬─┬─╥─┬─┬┬─┬┬─┬─╥─┬─┬┬─┬─╥─┬─┬┬─┬┬─┬─┐
    │ │ ││ │ ║ │ ││ ││ │ ║ │ ││ │ ║ │ ││ ││ │ │
    │ │X││X│ ║ │X││X││X│ ║ │X││X│ ║ │X││X││X│ │
    │ │X││X│ ║ │X││X││X│ ║ │X││X│ ║ │X││X││X│ │
    │ ┕╥┙┕╥┙ ║ ┕╥┙┕╥┙┕╥┙ ║ ┕╥┙┕╥┙ ║ ┕╥┙┕╥┙┕╥┙ │
    │XX║XX║XX║XX║XX║XX║XX║XX║XX║XX║XX║XX║XX║XX│
    └──╨──╨──╨──╨──╨──╨──╨──╨──╨──╨──╨──╨──╨──┘
  ASCII

  class << self
    def render_intervals(notes, ref_note)
      output = place_black_notes(Paint[PIANO_TEMPLATE, 'gray'], notes, ref_note)
      place_white_notes(output, notes, ref_note)
    end

    def place_white_notes(input, notes, ref_note)
      white_notes = Scale.major.notes
      i = 0
      output_array = input.split("\n")
      output_array[5].gsub!('XX') do |match|
        note = white_notes[i%7]
        interval_name = (note - ref_note).name
        i += 1
        notes.map(&:name).include?(note.name) ? Paint[interval_name, 'red'] : '  '
      end

      output_array.join("\n")
    end

    def place_black_notes(input, notes, ref_note)
      black_notes  = Scale.pentatonic_major('C#',4).notes
      output_array = input.split("\n")

      i = 0
      output_array[2].gsub!('X') do |match|
        note = black_notes[i%5]
        interval_name = (note - ref_note).name
        i += 1
        notes.map(&:name).include?(note.name) ? Paint[interval_name[0], 'red'] : ' '
      end

      i = 0
      output_array[3].gsub!('X') do |match|
        note = black_notes[i%5]
        interval_name = (black_notes[i%5] - ref_note).name
        i += 1
        notes.map(&:name).include?(note.name) ? Paint[interval_name[1], 'red'] : ' '
      end

      output_array.join("\n")
    end
  end

end