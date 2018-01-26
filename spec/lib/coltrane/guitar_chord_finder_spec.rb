# RSpec.describe GuitarChordFinder do
#   it 'can return guitar chords from chord name C#m' do
#     pending
#     return
#     expect(GuitarChordFinder.by_chord_name('C#m').map(&:frets_in_sequence))
#       .to include([9,11,11,9,9,9].reverse)
#   end

#   it 'can return guitar chords from chord name C' do
#     pending
#     return
#     expect(GuitarChordFinder.by_chord_name('C').map(&:frets_in_sequence))
#       .to include([0,3,0,2,1,0].reverse)
#   end

#   it 'can return guitar chords from chord name A7' do
#     pending
#     return
#     expect(GuitarChordFinder.by_chord_name('A7').map(&:frets_in_sequence))
#       .to include([5,7,5,6,5,5].reverse)
#   end

#   it 'includes chords with only 4 frets of extension' do
#     pending
#     return
#     asdf = GuitarChordFinder.by_chord_name('C#m').reduce(false) do |memo, chord|
#       frets = chord.frets_in_sequence.compact
#       frets.delete(0)
#       memo || !(frets.max - frets.min).between?(0,4)
#     end

#     expect(asdf).to be_falsy
#   end
# end