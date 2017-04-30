RSpec.describe GuitarChordFinder do
  # it 'can return regions where the chords may happen' do
  #   pending
  # end

  it 'can return guitar chords from chord' do
    expect(GuitarChordFinder.by_chord(Chord.new('C#m'))) #.map(&:frets_in_sequence))
      .to include(GuitarChord.new(9,9,9,11,11,9).frets_in_sequence)
  end
end