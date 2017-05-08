RSpec.describe Scale do
  let(:scale) { Scale.new(2,2,1,2,2,2,1) }

  it 'can be defined by interval steps' do
    expect(scale.class).to eq(Scale)
  end

  it 'defaults to C' do
    expect(scale.tone.name).to eq('C')
  end

  it 'can give you degrees' do
    expect(scale[7].name).to eq('B')
  end

  it 'can give you degrees above the scale size' do
    expect(scale[9].name).to eq('D')
  end

  it 'can give you tertians' do
    expect(scale.tertians.map(&:name))
      .to eq ["C", "Dm", "Em", "F", "G", "Am", "Bdim"]
  end

  it 'can give you all possible triads for a major scale' do
    expect(scale.chords(3).map(&:name))
      .to include %w[CMsus2 C CMsus4 CMsus2 C CMsus4 DMsus2 Dm DMsus4 DMsus2 Dm
                DMsus4 Em#5 Em#5 Em Em#5 EMsus4 Em EMsus4 Em#5 FMsus2 F FMsus2
                FMsus2 F FMb5 F FMb5 FMsus2 F GMsus4 GMsus4 GMsus2 G GMsus4
                G7ndim5 GMsus2 G G7ndim5 GMsus4 Am Am#5 AMsus4 Am AMsus4 AMsus2
                Am Am#5 Am#5 AMsus2 Am Am#5 Bdim Bm#5 Bdim Bm#5 CMsus2C CMsus4
                CMsus2 C CMsus4]
  end

  it 'can give you all possible triads for pentatonic scale' do
    expect(Scale.pentatonic_minor.chords(3).map(&:name))
      .to eq ["Cm", "CMsus4", "D#Msus2", "D#", "FMsus2", "FMsus4"]
  end

  it 'can return scales that include a chord' do
    # expect(Scale.having_chord('C'))
      # .to include({:name=>"C Major",             :degree =>1},
      #             {:name=>"G Major",             :degree =>4},
      #             {:name=>"A Natural Minor",     :degree =>3},
      #             {:name=>"C Pentatonic Major",  :degree =>1},
      #             {:name=>"A Pentatonic Minor",  :degree =>2},
      #             {:name=>"C Blues Major",       :degree =>1},
      #             {:name=>"A Blues Minor",       :degree =>2})
    expect(Scale.having_chord('G7').map(&:name))
      .to include('C Major')

  end

  it 'can return the degree of a chord in a scale' do
    expect(scale.degree_of_chord(Chord.new('G7'))).to eq(5)
  end

  it 'can render guitar notes' do
    expect(scale.on_guitar.class)
      .to eq(String)
  end

  it 'can render intervals' do
    expect(scale.intervals_on_guitar.class)
      .to eq(String)
  end

  it 'can render degrees' do
    expect(scale.degrees_on_guitar.class)
      .to eq(String)
  end

  it 'can render intervals on piano' do
    expect(Scale.hungarian_minor('D#').intervals_on_piano)
      .to eq(String)
  end

end