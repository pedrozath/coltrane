RSpec.describe GuitarChordFinder do
  it 'can return guitar chords from chord name C#m' do
    expect(GuitarChordFinder.by_chord_name('C#m').map(&:frets_in_sequence))
      .to include([9,11,11,9,9,9].reverse)
  end

  it 'can return guitar chords from chord name C' do
    expect(GuitarChordFinder.by_chord_name('C').map(&:frets_in_sequence))
      .to include([3,3,0,2,1,0].reverse)
  end

  it 'can return guitar chords from chord name A7' do
    expect(GuitarChordFinder.by_chord_name('A7').map(&:frets_in_sequence))
      .to include([5,7,5,6,5,5].reverse)
  end

  it 'includes chords with only 4 frets of extension' do
    asdf = GuitarChordFinder.by_chord_name('C#m').reduce(false) do |memo, chord|
      frets = chord.frets_in_sequence
      frets.delete(0)
      memo || !(frets.max - frets.min).between?(0,4)
    end

    expect(asdf).to be_falsy
  end
end