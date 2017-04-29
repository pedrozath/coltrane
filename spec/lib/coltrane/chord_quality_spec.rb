RSpec.describe ChordQuality do
  it 'can return quality from notes' do
    expect(ChordQuality.new_from_notes('C# F G#').name).to eq('M')
  end

  let :pitches_1 do
    [
      Pitch.new('C#2'),
      Pitch.new('F2'),
      Pitch.new('G#2'),
      Pitch.new('G#4')
    ]
  end

  let :pitches_2 do
    [
      Pitch.new('A3'),
      Pitch.new('E4'),
      Pitch.new('G4'),
      Pitch.new('C#5')
    ]
  end

  it 'can return quality from pitches' do
    expect(ChordQuality.new_from_pitches(*pitches_1).name).to eq('M')
    expect(ChordQuality.new_from_pitches(*pitches_2).name).to eq('7')
  end
end
