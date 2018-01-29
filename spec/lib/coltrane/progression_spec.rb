# frozen_string_literal: true

RSpec.describe Progression do
  let(:progression) { Progression.new('I-V-vi-VI', key: 'A') }

  let(:chords) do
    [
      Chord.new('A'),
      Chord.new('E')
    ]
  end

  it 'returns chords' do
    pending
    expect(progression.chords)
      .to include(*chords)
  end
end
