RSpec.describe Guitar do
  it 'returns the default tuning pitches' do
    pitches = [52, 47, 43, 38, 33, 28]
    expect(Guitar.strings.collect(&:pitch).collect(&:number))
      .to eq(pitches)
  end
end