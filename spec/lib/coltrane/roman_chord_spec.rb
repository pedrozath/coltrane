RSpec.describe RomanChord do
  let(:key) { Scale.major('C') }

  it 'can detect the degree' do
    expect(RomanChord.new(key, 'vii').degree)
      .to eq(7)
  end

  it 'can detect the root note' do
    expect(RomanChord.new(key, 'III').root_note.name)
      .to eq('E')
  end

  it 'can output major chords' do
    expect(RomanChord.new(key, 'III').to_chord.name)
      .to eq('Em')
  end

end