RSpec.describe Note do
  describe '#interval' do
    it 'returns an interval to other note' do
      expect(Note['C'].interval_to('D').semitones).to eq(10)
    end
  end

  it 'when summed to intervals it returns the corresponding note' do
    expect((Note['C'] + Interval.new('3M')).name).to eq('E')
  end

  it 'can return intervals by subtraction' do
    expect((Note['D'] - Note['C']).name).to eq('7m')
    expect((Note['B'] - Note['C']).name).to eq('2m')
    expect((Note['C'] - Note['C']).name).to eq('1P')
  end
end
