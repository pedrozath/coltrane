RSpec.describe Progression do
  let(:progression) { Progression.new('I-V-vi-VI', key: 'A') }

  let(:chords) {
    [
      Chord.new('A'),
      Chord.new('E')
    ]
  }

  it 'returns chords' do
    expect(progression.chords)
      .to include(*chords)
  end
end