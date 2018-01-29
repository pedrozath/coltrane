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

  it 'can give you a major scale' do
    expect(Scale.major('C').notes.names).to include(*%w[C D E F G A B])
    expect(Scale.major('C').notes.names).to_not include(*%w[C# D# F# G# A#])
    expect(Scale.major('D#').notes.names).to_not include(*%w[E])
  end

  it 'can tell you if a scale includes given notes' do
    expect(Scale.major('C').include?(NoteSet[*%w[A B C D E F G]])).to be_truthy
    expect(Scale.major('D#').include?(Note['E'])).to be_falsey
    expect(Scale.major('F#').include?(Note['G'])).to be_falsey
  end

  it 'can give you all possible triads for a major scale' do
    expect(scale.triads.map(&:name))
      .to include *%w[CM Dm Em FM GM Am Bdim]
  end

  it 'can give you all possible sevenths for a major scale' do
    expect(scale.sevenths.map(&:name))
      .to include *%w[CM7 Dm7 Em7 FM7 G7 Am7 Bm7b5]
  end

  it 'can give you all possible triads for pentatonic scale' do
    expect(Scale.pentatonic_minor.triads.map(&:name))
      .to include(*%w[])
  end

  it 'can give you all possible triads for pentatonic scale' do
    expect(Scale.pentatonic_major.sevenths.map(&:name))
      .to include(*%w[])
  end

  it 'can return scales that include a chord' do
    expect(Scale.having_chord('G7').scales.map(&:full_name)).to include('C Major')
  end

  it 'can return scales that include some notes' do
    scale_search = Scale.having_notes(NoteSet['C','F','B'])
    expect(scale_search.scales.map(&:full_name)).to include('C Major')
    expect(scale_search.scales.map(&:full_name)).to_not include('F# Major')
    expect(scale_search.scales.map(&:full_name)).to_not include('Gb Major')
    expect(scale_search.results['Major'][Note['C'].id].size).to eq(3)
    expect(scale_search.results['Major'][Note['D#'].id].size).to eq(2)
    expect(scale_search.results['Major'][Note['E'].id].size).to eq(1)
  end

  it 'can return a specific note from the scale' do
    expect(scale.degree(2).name).to eq('D')
  end

  it 'can return notes from the scale' do
    expect(scale.notes.names).to include(*%w[C D E F G A B])
    expect(scale.notes.names).to_not include(*%w[C# D# F# G# A#])
  end

  it 'can return the greek modes' do
    expect(Scale.ionian('C').notes.names).to      include(*%w[C D E F G A B])
    expect(Scale.locrian('F').notes.names).to     include(*%w[F F# G# A# B C# D#])
    expect(Scale.mixolydian('D#').notes.names).to include(*%w[D# F G G# A# C C#])
    expect(Scale.aeolian('A#').notes.names).to    include(*%w[A# C C# D# F F# G#])
    expect(Scale.ionian('B').notes.names).to      include(*%w[B C# D# E F# G# A#])
  end

end