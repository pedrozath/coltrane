# frozen_string_literal: true

RSpec.describe Scale do
  let(:scale) { Scale.new(2, 2, 1, 2, 2, 2, 1, tone: 'C') }

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

    scale = Scale.from_key('Bb')
    expect(scale.name).to eq('Major')
    expect(scale.tone.number).to eq(Note['A#'].number)

    scale = Scale.from_key('DM')
    expect(scale.name).to eq('Major')
    expect(scale.tone.name).to eq('D')

    scale = Scale.from_key('Dm')
    expect(scale.name).to eq('Natural Minor')
    expect(scale.tone.name).to eq('D')
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
      .to eq %w[CM Dm Em FM GM Am Bdim]
  end

  it 'can give you a major scale' do
    expect(Scale.major('C').notes.names).to include('C', 'D', 'E', 'F', 'G', 'A', 'B')
    expect(Scale.major('C').notes.names).to_not include('C#', 'D#', 'F#', 'G#', 'A#')
    expect(Scale.major('D#').notes.names).to_not include('E')
  end

  it 'can tell you if a scale includes given notes' do
    expect(Scale.major('C').include?(NoteSet['A', 'B', 'C', 'D', 'E', 'F', 'G'])).to be_truthy
    expect(Scale.major('D#').include?(Note['E'])).to be_falsey
    expect(Scale.major('F#').include?(Note['G'])).to be_falsey
  end

  it 'can give you all possible triads for a major scale' do
    expect(scale.triads.map(&:name))
      .to include 'CM', 'Dm', 'Em', 'FM', 'GM', 'Am', 'Bdim'
  end

  it 'can give you all possible sevenths for a major scale' do
    expect(scale.sevenths.map(&:name))
      .to include 'CM7', 'Dm7', 'Em7', 'FM7', 'G7', 'Am7', 'Bm7b5'
  end

  # it 'can give you all possible triads for pentatonic scale' do
  #   expect(Scale.pentatonic_minor.triads.map(&:name))
  #     .to include('')
  # end

  # it 'can give you all possible triads for pentatonic scale' do
  #   expect(Scale.pentatonic_major.sevenths.map(&:name))
  #     .to include('')
  # end

  it 'can return scales that include a chord' do
    expect(Scale.having_chord('G7').scales.map(&:full_name)).to include('C Major')
  end

  it 'can return scales that include some notes' do
    scale_search = Scale.having_notes(NoteSet['C', 'F', 'B'])
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

  it 'can return you all possible named chords for a scale' do
    Cache.disable
    expect(scale.all_chords.map(&:name))
      .to contain_exactly *%w[
        CMsus2 CM CMsus4 DMsus2 Dm DMsus4 Em#5 Em EMsus4 FMsus2 FM
        FMb5 GMsus4 GMsus2 GM G7ndim5 Am Am#5 AMsus4 AMsus2 Bdim Bm#5
        CMadd9 Csus24 CM6 CM7 CM7sus4 D4 Dm7 D7sus4 Dmadd9 Dsus24 Dmadd4
        Em7#5 E7#5sus4 Emb6b9 E4 Em7 E7sus4 Emadd4 FM6 FM7 FMadd9 FM7b5
        G7sus4 Gsus24 GM6 G7 GMadd9 G9ndim5 Amadd4 A4 Am7 Amadd9 Am7#5
        A7sus4 Asus24 A7#5sus4 Bmb6b9 B4 Bm7b5 Bm7#5 B7#5sus4 CM6/9 CM9
        CM9sus4 Dm9 D11 Dm7add11 Dm6/9 Dm6 E11b9 Em7add11 FM6/9 FM6#11
        FM9 FM7#11 FM9b5 G11 G7add6 GM6/9 G9 G13ndim5 Am7add11 Am9 Am9#5
        A11 CM13 Dm11 D13sus4 E7sus4b9b13 FM13 FM6/9#11 FM9#11 G13sus4 G13
        Am11 Am11#5 Dm13 FM13#11 A9sus4 CM7add13 Cmaj7 D9sus4 E7sus4b9
        F6/9#11 FM7add13 Fmaj7 G9sus4
      ]
  end

  it 'can return notes from the scale' do
    expect(scale.notes.names).to include('C', 'D', 'E', 'F', 'G', 'A', 'B')
    expect(scale.notes.names).to_not include('C#', 'D#', 'F#', 'G#', 'A#')
  end

  it 'can return the greek modes' do
    expect(Scale.ionian('C').notes.names).to      include('C', 'D', 'E', 'F', 'G', 'A', 'B')
    expect(Scale.locrian('F').notes.names).to     include('F', 'F#', 'G#', 'A#', 'B', 'C#', 'D#')
    expect(Scale.mixolydian('D#').notes.names).to include('D#', 'F', 'G', 'G#', 'A#', 'C', 'C#')
    expect(Scale.aeolian('A#').notes.names).to    include('A#', 'C', 'C#', 'D#', 'F', 'F#', 'G#')
    expect(Scale.ionian('B').notes.names).to      include('B', 'C#', 'D#', 'E', 'F#', 'G#', 'A#')
  end
end
