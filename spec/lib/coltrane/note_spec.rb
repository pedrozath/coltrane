# frozen_string_literal: true

RSpec.describe Note do
  describe '#interval' do
    it 'returns an interval to other note' do
      expect(Note['C'].interval_to('D').semitones).to eq(10)
    end
  end

  it 'when summed to intervals it returns the corresponding note' do
    expect((Note['C'] + Interval.major_third).name).to eq('E')
  end

  it 'can return intervals by subtraction' do
    expect((Note['D'] - Note['C']).name).to eq('m7')
    expect((Note['B'] - Note['C']).name).to eq('m2')
    expect((Note['C'] - Note['C']).name).to eq('P1')
  end
end
