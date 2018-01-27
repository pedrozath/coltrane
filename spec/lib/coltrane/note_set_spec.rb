RSpec.describe NoteSet do
  let(:note_set) { NoteSet[*%w[A# D F G#]] }

  it 'can return named intervals' do
    expect(note_set.interval_sequence.names)
      .to eq(%w[1P 3M 5P 7m])
  end

  it 'can intersect other notesets' do
    intersection_notes = (note_set & NoteSet[*%w[A D F]])
    expect(intersection_notes.names).to include(*%w[D F])
    expect(intersection_notes.names).to_not include(*%w[A G])
  end
end
