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

  it 'can do a tritone substitution' do
    # expect(Chord.new(name: 'A7').tritone_substitution.name).to eq('D#7')
    # expect(Chord.new(name: 'GM').tritone_substitution.name).to eq('C#M')
  end

  it 'can transpose when summed or subtracted from interval' do
    expect((Chord.new(name: 'DM') - Interval.major_second).name)
      .to eq('CM')
    expect((Chord.new(name: 'DM') + Interval.major_second).name)
      .to eq('EM')
  end

  it 'can add notes when summed against a note' do
    expect((Chord.new(name: 'DM') + Note['B']).name)
      .to eq('DM6')
  end

  it 'can create slash chords' do
    expect(Chord.new(name: 'Am7/F#').notes.names)
      .to contain_exactly(*%w[A C E F# G])
  end
end
