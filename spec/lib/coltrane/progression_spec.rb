RSpec.describe Progression do
  let(:progression) { Progression.new('I-V-vi-VI', key: Pitch.new('A3')) }

  let(:chords) {
    [
      Chord.new('A'),
      Chord.new('E')
    ]
  }

  it 'returns chords' do
    pending
    expect(progression.chords)
      .to include(*chords)
  end
end