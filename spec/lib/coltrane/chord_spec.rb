RSpec.describe Chord do
  # let :pitches {}
  let :guitar_notes_1 do
    GuitarNoteSet.new [
      { guitar_string_index: 2, fret: 6 },
      { guitar_string_index: 3, fret: 5 },
      { guitar_string_index: 4, fret: 7 },
      { guitar_string_index: 5, fret: 5 }
    ]
  end

  let :guitar_notes_2 do
    GuitarNoteSet.new [
      { guitar_string_index: 0, fret: 9 },
      { guitar_string_index: 1, fret: 9 },
      { guitar_string_index: 2, fret: 9 },
      { guitar_string_index: 3, fret: 11 },
      { guitar_string_index: 4, fret: 11 },
      { guitar_string_index: 5, fret: 9 }
    ]
  end

  describe '#initialize' do
    it 'can be initialized by guitar notes' do
      expect(Chord.new(guitar_notes_1).pitches.collect(&:name))
        .to contain_exactly('A2', 'C#4', 'E3', 'G3')
    end
  end


  it 'can return the chord name from guitar notes' do
    expect(Chord.new(guitar_notes_1).name).to eq('A7')
    expect(Chord.new(guitar_notes_2).name).to eq('C#m')
  end

end