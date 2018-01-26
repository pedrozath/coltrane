# RSpec.describe GuitarNoteSet do
#   let(:pitch) { 'F4' }

#   let(:guitar_note_set) do
#     GuitarNoteSet.new(pitch).guitar_notes.collect(&:position)
#   end

#   it 'can be created from a pitch' do
#     expect(guitar_note_set)
#       .to include(fret: 6, guitar_string_index: 1)
#   end

#   it 'returns correct pitches' do
#     guitar_note_set = GuitarNoteSet.new [
#       { guitar_string_index: 2, fret: 6 },
#       { guitar_string_index: 3, fret: 5 },
#       { guitar_string_index: 4, fret: 7 },
#       { guitar_string_index: 5, fret: 5 }
#     ]

#     expect(guitar_note_set.guitar_notes.collect(&:pitch).collect(&:name))
#       .to contain_exactly('A2', 'C#4', 'E3', 'G3')
#   end
# end
