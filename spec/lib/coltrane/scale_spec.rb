RSpec.describe Scale do
  let(:scale) { Scale.new(2,2,1,2,2,2,1, tone: 'C') }

  it 'can try to find its name' do
    expect(scale.name).to eq('Major')
  end

  it 'can be defined by interval steps' do
    expect(scale.class).to eq(Scale)
  end

  it 'can parse major keys' do
    scale = Scale.from_key('A#m')
    expect(scale.name).to eq('Natural Minor')
    expect(scale.tone.name).to eq('A#')
  end

  it 'defaults to C' do
    expect(scale.tone.name).to eq('C')
  end

  it 'can give you degrees' do
    expect(scale[3].name).to eq('E')
    expect(scale[7].name).to eq('B')
    expect(scale[1].name).to eq('C')
  end

  it 'can give you tertians' do
    expect(scale.tertians.map(&:name))
      .to eq ["CM", "Dm", "Em", "FM", "GM", "Am", "Bdim"]
  end

  it 'can give you all possible triads for a major scale' do
    expect(scale.chords(3).map(&:name))
      .to include *%w[CMsus2 CM CMsus4 DMsus4 DMsus2 Dm DM
        Em#5 Em EMsus4 FMsus2 FM Fdim F7ndim5 FMb5 GMsus4
        GM GMsus2 G7ndim5 Am Am#5 AMsus4 AMsus2 Bdim Bm#5
        Bm BMsus4 BMb5]
  end

  it 'can give you all possible triads for pentatonic scale' do
    expect(Scale.pentatonic_minor.triads.map(&:name))
      .to include(*%w[CMsus4 D#m FMsus4 GMsus4 A#M])
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

  it 'can return scales that include some notes' do
    scales = Scale.having_notes('C', 'F', 'B').map(&:name)
    expect(scales).to include('C Major')
    expect(scales).to_not include('F# Major')
  end

  it 'can return the degree of a chord in a scale' do
    expect(scale.degree_of_chord(Chord.new(name: 'G7'))).to eq(5)
  end

  # it 'can render guitar notes' do
  #   expect(scale.on_guitar.class)
  #     .to eq(String)
  # end

  # it 'can render intervals' do
  #   expect(scale.intervals_on_guitar.class)
  #     .to eq(String)
  # end

  # it 'can render degrees' do
  #   expect(scale.degrees_on_guitar.class)
  #     .to eq(String)
  # end

  # it 'can render intervals on piano' do
  #   expect(Scale.hungarian_minor('D#').intervals_on_piano.class)
  #     .to eq(String)
  # end

end