RSpec.describe GuitarString do
  it 'can return the fret for a pitch' do
    expect(GuitarString.new('E2').fret_by_pitch('F2')).to eq(1)
  end
end
