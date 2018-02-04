# frozen_string_literal: true

RSpec.describe Interval do
  it 'cant be negative' do
    expect(Interval[-2].semitones).to eq(10)
  end

  it 'cant go higher than 12' do
    expect(Interval[13].semitones).to eq(1)
  end

  it 'has full names' do
    expect(Interval['P1'].full_names)
      .to contain_exactly 'Perfect Unison',
                          'Diminished Second',
                          'Augmented Seventh',
                          'Perfect Octave',
                          'Diminished Ninth',
                          'Augmented Fourteenth'

    expect(Interval['Augmented Fifth'].full_names)
      .to contain_exactly 'Augmented Fifth',
                          'Minor Sixth',
                          'Augmented Twelfth',
                          'Minor Thirteenth'
  end

  it 'has corresponding helpers' do
    expect(Interval['P1']).to be_perfect_unison
    expect(Interval['m3']).to be_minor_third
    expect(Interval['P5']).to be_perfect_fifth
    expect(Interval['m2']).to be_minor_ninth
  end

  it 'may be created by full name' do
    expect(Interval['Major Second']).to   eq(Interval['M2'])
    expect(Interval['Major Third']).to    eq(Interval['M3'])
    expect(Interval['Minor Seventh']).to  eq(Interval['m7'])
    expect(Interval['Perfect Unison']).to eq(Interval['P1'])
    expect(Interval['Perfect Octave']).to eq(Interval['P1'])
    expect(Interval['Minor Second']).to   eq(Interval['m2'])
  end

  it 'may be created by methods' do
    expect(Interval.major_second).to   eq(Interval['M2'])
    expect(Interval.major_third).to    eq(Interval['M3'])
    expect(Interval.minor_seventh).to  eq(Interval['m7'])
    expect(Interval.perfect_unison).to eq(Interval['P1'])
    expect(Interval.perfect_octave).to eq(Interval['P1'])
    expect(Interval.minor_second).to   eq(Interval['m2'])
  end

end
