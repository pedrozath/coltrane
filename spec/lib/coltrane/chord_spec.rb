RSpec.describe Chord do
  # let :pitches {}

  it 'can return the chord from pitches' do
    # expect(Chord.new(pitches).name).to eq(Am7)
  end

  let :guitar_notes do
    GuitarNoteSet.new [
      { guitar_string_index: 5, fret: 5 },
      { guitar_string_index: 4, fret: 7 },
      { guitar_string_index: 3, fret: 5 },
      { guitar_string_index: 2, fret: 5 }
    ]
  end

  it 'can return the chord name from guitar notes' do
    expect(Chord.new(guitar_notes).name).to eq('Am7')
  end
end