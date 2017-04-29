RSpec.describe GuitarNote do

  let :guitar_note { GuitarNote.new(guitar_string_index: 5, fret: 3) }

  describe '#note' do
    it 'returns the note' do
      expect(guitar_note.note).to eq('G')
    end
  end
end