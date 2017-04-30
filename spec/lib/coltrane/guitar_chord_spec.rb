RSpec.describe GuitarChord do
  it 'can be created by describing frets in sequence' do
    # pending
    expect(GuitarChord.new(nil,nil,6,5,7,5).guitar_notes.map(&:position))
      .to include({ guitar_string_index:2, fret: 6 },
                  { guitar_string_index:3, fret: 5 },
                  { guitar_string_index:4, fret: 7 },
                  { guitar_string_index:5, fret: 5 })
  end

  it 'cant have more than one guitar note per string' do
    pending
    expect(GuitarChord.new [
      GuitarNote.new(guitar_string_index: 4, fret: 0),
      GuitarNote.new(guitar_string_index: 3, fret: 0),
      GuitarNote.new(guitar_string_index: 2, fret: 6),
      GuitarNote.new(guitar_string_index: 1, fret: 5),
      GuitarNote.new(guitar_string_index: 1, fret: 7),
      GuitarNote.new(guitar_string_index: 0, fret: 5)
    ]).to raise_exception
  end
end