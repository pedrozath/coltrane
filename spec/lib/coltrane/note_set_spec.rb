RSpec.describe NoteSet do
  let :note_set { NoteSet.new(%w{A# D F G#}) }

  it 'can return named intervals' do
    expect(note_set.interval_sequence.names)
      .to eq(%w[1P 3M 5P 7m])
  end
end