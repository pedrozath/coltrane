# frozen_string_literal: true

RSpec.describe Progression do
  let(:progression) { Progression.new('I-V-vi-VI', key: 'A') }

  it 'returns chords' do
    pending
    expect(progression.chords)
      .to include(*chords)
  end
end
