RSpec.describe NoteSet do
  let :note_set { NoteSet.new(%w{C# D# A#}) }

  it 'can transpose' do
    expect(note_set.transpose_to('C').collect(&:name))
      .to contain_exactly('C', 'D', 'A')
  end

  it 'can return intervals format' do
    expect(note_set.intervals)
      .to eq([0,2,9])
  end
end