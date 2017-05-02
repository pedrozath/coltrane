RSpec.describe GuitarChordFinder do
  # it 'can return regions where the chords may happen' do
  #   pending
  # end

  it 'can return essential guitar chords from chord' do
    expect(GuitarChordFinder.by_chord_name('C#m').map(&:frets_in_sequence))
      .to include(GuitarChord.new(nil,nil,9,nil,11,9).frets_in_sequence)
  end

  it 'can return guitar chords from chord' do
    expect(GuitarChordFinder.by_chord_name('C#m').map(&:to_s))
      .to include(GuitarChord.new('9  11  11  9  9  9'))
  end
end