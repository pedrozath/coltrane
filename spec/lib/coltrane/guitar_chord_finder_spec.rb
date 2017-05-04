RSpec.describe GuitarChordFinder do
  it 'can return guitar chords from chord' do
    expect(GuitarChordFinder.by_chord_name('C#m').map(&:frets_in_sequence))
      .to include([9, 9, 9, 11, 11, 9])
  end
end