RSpec.describe Chord do
  let :guitar_chord_1 do
    GuitarChord.new(nil,nil,6,5,7,5)
  end

  let :guitar_chord_2 do
    GuitarChord.new(9,9,9,11,11,9)
  end

  it 'can return the chord name from guitar chord' do
    expect(Chord.new(guitar_chord_1).name).to eq('A7')
    expect(Chord.new(guitar_chord_2).name).to eq('C#m')
  end

  it 'can return guitar notes for the chord root' do
    expect(Chord.new('C').guitar_notes_for_root.map(&:position))
      .to include({ guitar_string_index: 5, fret: 8},
                  { guitar_string_index: 4, fret: 3},
                  { guitar_string_index: 3, fret: 10},
                  { guitar_string_index: 2, fret: 5},
                  { guitar_string_index: 1, fret: 1},
                  { guitar_string_index: 1, fret: 13},
                  { guitar_string_index: 0, fret: 8})
  end

  it 'has notes' do
    expect(Chord.new('A7').notes.collect(&:name))
      .to contain_exactly('A','C#','E','G')
  end
end
