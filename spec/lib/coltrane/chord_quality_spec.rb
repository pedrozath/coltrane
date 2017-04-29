RSpec.describe ChordQuality do
  it 'can return quality from notes' do
    expect(ChordQuality.new_from_notes('C# F G#').name).to eq('M')
  end

  it 'can return quality from pitches' do
    x = Pitch.new('C#2')
    y = Pitch.new('F2')
    z = Pitch.new('G#2')
    q = Pitch.new('G#4')
    expect(ChordQuality.from_pitches(y,x,z,q)).to eq('M')
  end
end