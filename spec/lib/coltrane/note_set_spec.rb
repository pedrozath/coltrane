RSpec.describe NoteSet do
  let :note_set { NoteSet.new(%w{C# D# A#}) }

  it 'can transpose' do
    expect(note_set.transpose_to('C').collect(&:name))
      .to contain_exactly('C', 'D', 'A')
  end
end