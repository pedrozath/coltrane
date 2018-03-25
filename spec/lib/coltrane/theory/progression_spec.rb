# frozen_string_literal: true

RSpec.describe Progression do
  let(:progression) { Progression.new('I-IV-vi-V', key: 'A') }

  it 'returns chords' do
    expect(progression.chords.map(&:name))
      .to contain_exactly(*%w[AM DM F#m EM])
  end

  it 'finds progressions using chords' do
    Progression.find(*%w[AM DM F#m EM])
    .map(&:notation)
    .yield_self(&method(:expect))
    .to include('I-IV-vi-V')
  end

  it 'can return some notable progressions' do
    expect(Progression.jazz('C').chords.map(&:name))
      .to contain_exactly(*%w[C7 Dm7 G7])
    expect(Progression.pop('A#').chords.map(&:name))
      .to contain_exactly(*%w[A#M D#M FM Gm])
  end
end
