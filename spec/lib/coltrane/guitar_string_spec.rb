RSpec.describe GuitarString do
  let(:guitar_string) do
    GuitarString.new('E2')
  end

  let(:note) { Note.new('E') }

  it 'can return the fret for a pitch' do
    expect(guitar_string.fret_by_pitch('F2')).to eq(1)
  end

  it 'has pitches' do
    expect(guitar_string.pitches.collect(&:name))
      .to include('E2', 'A2', 'E3', 'F#3', 'D4')
  end

  it 'has an index based on the default guitar class' do
    expect(guitar_string.index)
      .to eq(5)
  end

  it 'can provide guitar notes for a given note' do
    expect(guitar_string.guitar_notes_for_note(note).map(&:pitch).map(&:name))
      .to eq(%w[E2 E3])
  end

  it 'can provide guitar notes for a given note in a region, including fret 0' do
    expect(guitar_string.guitar_notes_for_note_in_region(note, 10..12).map(&:pitch).map(&:name))
      .to eq(%w[E2 E3])
  end


end
