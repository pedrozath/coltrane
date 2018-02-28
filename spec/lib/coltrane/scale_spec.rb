# frozen_string_literal: true

RSpec.describe Scale do
  let(:scale) { Scale.major('C') }

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
    expect(scale.tone.integer).to eq(Note['A#'].integer)

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
    expect(scale_search.results['Major'][Note['C'].integer].size).to eq(3)
    expect(scale_search.results['Major'][Note['D#'].integer].size).to eq(2)
    expect(scale_search.results['Major'][Note['E'].integer].size).to eq(1)
  end

  it 'can return a specific note from the scale' do
    expect(scale.degree(2).name).to eq('D')
  end

  it 'can return you all possible named chords for a scale' do
    expect(scale.all_chords.map(&:name))
      .to include *%w[Bdim Bm7b5 Bm7b5b9 Bm7b5b11 Dm Em Am Dm6 Dm7 Em7 Am7 Em9
                      Em11 CM FM GM CM6 FM6 GM6 C6/9 F6/9 G6/9 C6/9(add11) G6/9(add11) G7 G9
                      G11 G13 CM7 FM7 CM9 FM9 CM11 CM13 CMsus2 DMsus2 FMsus2 GMsus2 AMsus2
                      CM6sus2 DM6sus2 FM6sus2 GM6sus2 D7sus2 G7sus2 A7sus2 CM7sus2 FM7sus2
                      A+sus2 A+7sus2 CMsus4 DMsus4 EMsus4 GMsus4 AMsus4 CM6sus4 DM6sus4
                      GM6sus4 C6/9sus4 D6/9sus4 G6/9sus4 D7sus4 E7sus4 G7sus4 A7sus4 D9sus4
                      G9sus4 A9sus4 CM7sus4 CM9sus4 E+sus4 A+sus4 B+sus4 E+7sus4 A+7sus4
                      B+7sus4 A+9sus4]
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
