# frozen_string_literal: true

RSpec.describe IntervalClass do
  it 'has full names' do
    expect(IntervalClass['P1'].full_names)
      .to contain_exactly 'Perfect Unison',
                          'Diminished Second',
                          'Augmented Seventh',
                          'Perfect Octave',
                          'Diminished Ninth',
                          'Augmented Fourteenth'

    expect(IntervalClass['Augmented Fifth'].full_names)
      .to contain_exactly 'Augmented Fifth',
                          'Minor Sixth',
                          'Augmented Twelfth',
                          'Minor Thirteenth'
  end

  it 'has corresponding helpers' do
    expect(IntervalClass['P1']).to be_perfect_unison
    expect(IntervalClass['m3']).to be_minor_third
    expect(IntervalClass['P5']).to be_perfect_fifth
    expect(IntervalClass['m2']).to be_minor_ninth
  end

  it 'may be created by full name' do
    expect(IntervalClass['Major Second']).to   eq(IntervalClass['M2'])
    expect(IntervalClass['Major Third']).to    eq(IntervalClass['M3'])
    expect(IntervalClass['Minor Seventh']).to  eq(IntervalClass['m7'])
    expect(IntervalClass['Perfect Unison']).to eq(IntervalClass['P1'])
    expect(IntervalClass['Perfect Octave']).to eq(IntervalClass['P1'])
    expect(IntervalClass['Minor Second']).to   eq(IntervalClass['m2'])
  end

  it 'may be created by methods' do
    expect(IntervalClass.major_second).to   eq(IntervalClass['M2'])
    expect(IntervalClass.major_third).to    eq(IntervalClass['M3'])
    expect(IntervalClass.minor_seventh).to  eq(IntervalClass['m7'])
    expect(IntervalClass.perfect_unison).to eq(IntervalClass['P1'])
    expect(IntervalClass.perfect_octave).to eq(IntervalClass['P1'])
    expect(IntervalClass.minor_second).to   eq(IntervalClass['m2'])
  end
end
