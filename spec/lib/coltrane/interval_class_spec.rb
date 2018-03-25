# frozen_string_literal: true

RSpec.describe IntervalClass do
  it 'may be created by full name' do
    expect(IntervalClass['Major Second']).to   eq(IntervalClass['M2'])
    expect(IntervalClass['Major Third']).to    eq(IntervalClass['M3'])
    expect(IntervalClass['Minor Seventh']).to  eq(IntervalClass['m7'])
    expect(IntervalClass['Perfect Unison']).to eq(IntervalClass['P1'])
    expect(IntervalClass['Perfect Octave']).to eq(IntervalClass['P1'])
    expect(IntervalClass['Minor Second']).to   eq(IntervalClass['m2'])
  end
end
