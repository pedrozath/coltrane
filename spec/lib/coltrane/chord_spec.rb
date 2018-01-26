RSpec.describe Chord do
  # it 'can return the chord name from guitar chord' do
  #   expect(Chord.new(guitar_chord_1).name).to eq('A7')
  #   expect(Chord.new(guitar_chord_2).name).to eq('C#m')
  # end

  it 'can return the chord from notes' do
    expect(Chord.new(notes: %w[C E G]).name).to eq('CM')
  end

  it 'can return a chord from root_note and quality' do
    expect(Chord.new(root_note: Note.new('C'),
                     quality: ChordQuality.new(name: 'M')).names)
      .to eq(%w[C E G])
  end

  # it 'can return guitar notes for the chord root' do
  #   expect(Chord.new('C').guitar_notes_for_root.map(&:position))
  #     .to include({ guitar_string_index: 5, fret: 8},
  #                 { guitar_string_index: 4, fret: 3},
  #                 { guitar_string_index: 3, fret: 10},
  #                 { guitar_string_index: 2, fret: 5},
  #                 { guitar_string_index: 1, fret: 1},
  #                 { guitar_string_index: 1, fret: 13},
  #                 { guitar_string_index: 0, fret: 8})
  # end

  it 'has notes' do
    expect(Chord.new(name: 'A7').notes.collect(&:name))
      .to contain_exactly('A','C#','E','G')
  end
end
