# frozen_string_literal: true

RSpec.describe DiatonicScale do
  it 'has a relative minor' do
    expect(Scale.major('C').relative_minor.notes.first.name).to eq('A')
    expect(Scale.major('C').relative_minor.notes.names)
      .to contain_exactly *%w[A B C D E F G]

    expect(Scale.minor('A').relative_minor.notes.first.name).to eq('A')
    expect(Scale.minor('A').relative_minor.notes.names)
      .to contain_exactly *%w[A B C D E F G]
  end

  it 'has a relative major' do
    expect(Scale.minor('A').relative_major.notes.first.name).to eq('C')
    expect(Scale.minor('A').relative_major.notes.names)
      .to contain_exactly *%w[C D E F G A B]

    expect(Scale.major('C').relative_major.notes.first.name).to eq('C')
    expect(Scale.major('C').relative_major.notes.names)
      .to contain_exactly *%w[C D E F G A B]
  end

  it 'outputs sharps and flats that comply with music standards' do
    expect(Scale.major('C#').notes.names).to eq(%w[C# D# E# F# G# A# B#])
    expect(Scale.major('Cb').notes.names).to eq(%w[Cb Db Eb Fb Gb Ab Bb])
    expect(Scale.major('Db').notes.names).to eq(%w[Db Eb F Gb Ab Bb C])
    expect(Scale.major('F#').notes.names).to eq(%w[F# G# A# B C# D# E#])
    expect(Scale.major('Ab').notes.names).to eq(%w[Ab Bb C Db Eb F G])
    expect(Scale.minor('B').notes.names).to eq(%w[B C# D E F# G A])
    expect(Scale.minor('E').notes.names).to eq(%w[E F# G A B C D])
    expect(Scale.minor('A#').notes.names).to eq(%w[A# B# C# D# E# F# G#])
    expect(Scale.minor('G#').notes.names).to eq(%w[G# A# B C# D# E F#])
  end
end
