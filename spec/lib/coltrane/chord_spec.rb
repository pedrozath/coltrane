RSpec.describe Chord do
  let :guitar_chord_1 do
    GuitarChord.new [
      { guitar_string_index: 2, fret: 6 },
      { guitar_string_index: 3, fret: 5 },
      { guitar_string_index: 4, fret: 7 },
      { guitar_string_index: 5, fret: 5 }
    ]
  end

  let :guitar_chord_2 do
    GuitarChord.new [
      { guitar_string_index: 0, fret: 9 },
      { guitar_string_index: 1, fret: 9 },
      { guitar_string_index: 2, fret: 9 },
      { guitar_string_index: 3, fret: 11 },
      { guitar_string_index: 4, fret: 11 },
      { guitar_string_index: 5, fret: 9 }
    ]
  end

  it 'can return the chord name from guitar chord' do
    expect(Chord.new(guitar_chord_1).name).to eq('A7')
    expect(Chord.new(guitar_chord_2).name).to eq('C#m')
  end

  # it 'can return guitar note sets from chord name' do
  #   expect(Chord.new('A7').guitar_chords)
  #     .to include(guitar_chord_1.guitar_notes)
  # end
end
