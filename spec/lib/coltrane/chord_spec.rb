# frozen_string_literal: true

RSpec.describe Chord do
  it 'can return the chord from notes' do
    expect(Chord.new(notes: %w[C E G]).name).to eq('CM')
  end

  it 'can return a chord from root_note and quality' do
    expect(Chord.new(root_note: Note['C'],
                     quality: ChordQuality.new(name: 'M')).notes.names)
      .to eq(%w[C E G])
  end

  it 'has notes' do
    expect(Chord.new(name: 'A7').notes.names)
      .to contain_exactly('A', 'C#', 'E', 'G')
  end
end
