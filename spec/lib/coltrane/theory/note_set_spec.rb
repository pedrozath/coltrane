# frozen_string_literal: true

RSpec.describe NoteSet do
  let(:note_set) { NoteSet['A#', 'D', 'F', 'G#'] }

  it 'can return named intervals' do
    expect(note_set.interval_sequence.names).to eq(%w[P1 d4 d6 m7])
  end

  it 'can intersect other notesets' do
    intersection_notes = (note_set & NoteSet['A', 'D', 'F'])
    expect(intersection_notes.names).to include('D', 'F')
    expect(intersection_notes.names).to_not include('A', 'G')
  end

  it 'can output how much accidentals' do
    expect(NoteSet[*%w[C# G# A B Bb]].sharps).to eq(2)
    expect(NoteSet[*%w[C# G# A B Bb]].flats).to eq(1)
  end
end
