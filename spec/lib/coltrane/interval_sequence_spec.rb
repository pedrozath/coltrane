RSpec.describe IntervalSequence do
  it 'is organized by default' do
    expect(IntervalSequence.new(notes: %w[D F C A]).intervals_semitones)
      .to eq([0,3,7,10])
    expect(IntervalSequence.new(notes: %w[D F C A#]).intervals_semitones)
      .to eq([0,3,8,10])
  end

  it 'can find the relative distances' do
    expect(IntervalSequence.new(intervals: [0,3,5,7,10]).distances)
      .to eq([3,2,2,3,2])
  end

  it 'can be instantiated from distances' do
    expect(IntervalSequence.new(distances: [3,2,2,3,2]).intervals_semitones)
      .to eq([0,3,5,7,10])
  end

  it 'can be created from Notes' do
    expect(IntervalSequence.new(notes:[
      Note['A'], Note['E'], Note['G'], Note['C#']
    ]).intervals_semitones).to eq([0,4,7,10])
  end

  it 'can return named intervals' do
    expect(IntervalSequence.new(intervals: [0, 4, 7, 10]).names)
      .to eq(%w[1P 3M 5P 7m])
  end

  it 'can return inversions' do
    interval = IntervalSequence.new(notes: %w[C E G])
    expect(interval.inversion(0).intervals_semitones).to eq([0,4,7])
    expect(interval.inversion(1).intervals_semitones).to eq([0,3,8])
    expect(interval.inversion(2).intervals_semitones).to eq([0,5,9])
  end

  # it 'can be shifted' do
  #   expect(IntervalSequence.new([1,3,5]).shift(-1).numbers)
  #     .to eq([0,2,4])
  # end

  # it 'can be shifted further' do
  #   expect(IntervalSequence.new([1,3,5]).shift(-2).numbers)
  #     .to eq([11,1,3])
  # end
end
