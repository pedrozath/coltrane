# frozen_string_literal: true

RSpec.describe ChordQuality do
  let :notes do
    [Note['A'], Note['E'], Note['G'], Note['C#']]
  end

  it 'can return quality from notes' do
    expect(ChordQuality.new(notes: %w[C E G]).name).to eq('M')
    expect(ChordQuality.new(notes: notes).name).to eq('7')
  end
end
