RSpec.describe IntervalSequence do
  it 'can return named intervals' do
    expect(IntervalSequence.new([0, 4, 7, 10]).names)
      .to eq(%w[1P 3M 5P 7m])
  end

  it 'can be shifted' do
    expect(IntervalSequence.new([1,3,5]).shift(-1).numbers)
      .to eq([0,2,4])
  end

  it 'can be shifted further' do
    expect(IntervalSequence.new([1,3,5]).shift(-2).numbers)
      .to eq([11,1,3])
  end
end
