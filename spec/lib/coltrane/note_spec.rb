RSpec.describe Note do
  let(:note) { Note.new 'C' }
  describe '#interval' do
    it 'returns an interval to other note' do
      expect(note.interval_to('D').number)
        .to eq(2)
    end
  end

  it 'can transpose' do
    expect(note.transpose_by(2).name).to eq('D')
  end

  it 'has guitar notes' do
    expect(note.guitar_notes.collect(&:position))
      .to include({ guitar_string_index: 5, fret: 8},
                  { guitar_string_index: 4, fret: 3},
                  { guitar_string_index: 3, fret: 10},
                  { guitar_string_index: 2, fret: 5},
                  { guitar_string_index: 1, fret: 1},
                  { guitar_string_index: 1, fret: 13})
  end

  it 'has guitar notes in string' do
    expect(note.in_guitar_string(Guitar.strings[0]).collect(&:position))
      .to include({ guitar_string_index: 0, fret: 8},
                  { guitar_string_index: 0, fret: 20})
  end

  it 'has guitar_notes in string region' do
    region           = (6..12)
    inside_position  = { guitar_string_index: 0, fret: 8}
    outside_position = { guitar_string_index: 0, fret: 20}
    guitar_notes     = note.in_guitar_string_region(Guitar.strings[0], region)

    expect(guitar_notes.collect(&:position)).to include(inside_position)
    expect(guitar_notes.collect(&:position)).to_not include(outside_position)
  end
end
