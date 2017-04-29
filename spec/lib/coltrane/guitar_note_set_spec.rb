RSpec.describe GuitarNoteSet do
  let :guitar_note_set do
    GuitarNoteSet.new(pitch).guitar_notes.collect(&:position)
  end

  let :pitch { 'F4' }

  describe '#initialize' do
    let :guitar_notes do
      GuitarNoteSet.new [
        { guitar_string_index: 5, fret: 5 },
        { guitar_string_index: 4, fret: 7 },
        { guitar_string_index: 3, fret: 5 },
        { guitar_string_index: 2, fret: 5 }
      ]
    end


    context 'When created from pitch' do
      it 'can be created from a pitch' do
        expect(guitar_note_set)
          .to include({fret:6, guitar_string_index: 1})
      end
    end
  end

end