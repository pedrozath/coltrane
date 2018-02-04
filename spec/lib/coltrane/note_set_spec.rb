# frozen_string_literal: true

RSpec.describe NoteSet do
  let(:note_set) { NoteSet['A#', 'D', 'F', 'G#'] }

  it 'can return named intervals' do
    expect(note_set.interval_sequence.names)
      .to eq(%w[P1 M3 P5 m7])
  end

  it 'can intersect other notesets' do
    intersection_notes = (note_set & NoteSet['A', 'D', 'F'])
    expect(intersection_notes.names).to include('D', 'F')
    expect(intersection_notes.names).to_not include('A', 'G')
  end
end
