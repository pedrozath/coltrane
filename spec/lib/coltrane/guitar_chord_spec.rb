# RSpec.describe GuitarChord do
#   it 'can be created by describing frets in sequence' do
#     expect(GuitarChord.new(nil,nil,6,5,7,5).guitar_notes.map(&:position))
#       .to include({ guitar_string_index:2, fret: 6 },
#                   { guitar_string_index:3, fret: 5 },
#                   { guitar_string_index:4, fret: 7 },
#                   { guitar_string_index:5, fret: 5 })
#   end

#   it 'can be created from guitar notes' do
#     expect(GuitarChord.new_from_notes([
#       GuitarNote.new(guitar_string_index: 2, fret: 6),
#       GuitarNote.new(guitar_string_index: 3, fret: 5),
#       GuitarNote.new(guitar_string_index: 4, fret: 7),
#       GuitarNote.new(guitar_string_index: 5, fret: 5)
#     ]).frets_in_sequence).to eq([nil,nil,6,5,7,5])

#     expect(GuitarChord.new_from_notes([
#       GuitarNote.new(guitar_string_index: 2, fret: 6),
#       GuitarNote.new(guitar_string_index: 3, fret: 5),
#       GuitarNote.new(guitar_string_index: 4, fret: 7),
#     ]).frets_in_sequence).to eq([nil,nil,6,5,7])
#   end

#   it 'has a string form' do
#     expect(GuitarChord.new_from_notes([
#       GuitarNote.new(guitar_string_index: 2, fret: 6),
#       GuitarNote.new(guitar_string_index: 3, fret: 5),
#       GuitarNote.new(guitar_string_index: 4, fret: 7),
#       GuitarNote.new(guitar_string_index: 5, fret: 5)
#     ]).to_s).to eq('5  7  5  6  X  X ')

#     expect(GuitarChord.new_from_notes([
#       GuitarNote.new(guitar_string_index: 0, fret: 5),
#       GuitarNote.new(guitar_string_index: 1, fret: 5),
#       GuitarNote.new(guitar_string_index: 2, fret: 6),
#       GuitarNote.new(guitar_string_index: 3, fret: 5),
#     ]).to_s).to eq('X  X  5  6  5  5 ')

#   end

#   it 'cant have more than one guitar note per string' do
#     pending
#     expect(GuitarChord.new [
#       GuitarNote.new(guitar_string_index: 4, fret: 0),
#       GuitarNote.new(guitar_string_index: 3, fret: 0),
#       GuitarNote.new(guitar_string_index: 2, fret: 6),
#       GuitarNote.new(guitar_string_index: 1, fret: 5),
#       GuitarNote.new(guitar_string_index: 1, fret: 7),
#       GuitarNote.new(guitar_string_index: 0, fret: 5)
#     ]).to raise_exception
#   end
# end