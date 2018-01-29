# frozen_string_literal: true

RSpec.describe Interval do
  it 'cant be negative' do
    expect(Interval.new(-2).semitones).to eq(10)
  end

  it 'cant go higher than 12' do
    expect(Interval.new(13).semitones).to eq(1)
  end
end
