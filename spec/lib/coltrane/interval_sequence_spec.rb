RSpec.describe IntervalSequence do
  it 'can return named intervals' do
    expect(IntervalSequence.new([0, 4, 7, 10]).names)
      .to eq(%w[1P 3M 5P 7m])
  end
end
