RSpec.describe Note do
  let :note { Note.new 'C' }
  describe '#interval' do
    it 'returns an interval to other note' do
      expect(note.interval_to('D').number)
        .to eq(2)
    end
  end

  it 'can transpose' do
    expect(note.transpose_by(2).name).to eq('D')
  end

end