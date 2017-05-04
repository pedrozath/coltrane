RSpec.describe GuitarChordFinder do
  it 'can return guitar chords from chord name C#m' do
    expect(GuitarChordFinder.by_chord_name('C#m').map(&:frets_in_sequence))
      .to include([9, 9, 9, 11, 11, 9])
  end

  it 'can return guitar chords from chord name C' do
    expect(GuitarChordFinder.by_chord_name('C').map(&:frets_in_sequence))
      .to include([nil, 3, 2, 0, 1, 0])
  end

  it 'can return guitar chords from chord name A7' do
    expect(GuitarChordFinder.by_chord_name('A7').map(&:frets_in_sequence))
      .to include([5, 7, 5, 6, 5, 5])
  end
end