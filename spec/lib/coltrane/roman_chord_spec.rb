# frozen_string_literal: true

RSpec.describe RomanChord do
  let(:key) { 'C' }

  it 'can detect the degree' do
    expect(RomanChord.new('vii', key: key).degree).to eq(7)
  end

  it 'can detect the root note' do
    expect(RomanChord.new('I', key: key).root_note).to    be_enharmonic('C')
    expect(RomanChord.new('II', key: key).root_note).to   be_enharmonic('D')
    expect(RomanChord.new('III', key: key).root_note).to  be_enharmonic('E')
    expect(RomanChord.new('bIII', key: key).root_note).to be_enharmonic('Eb')
    expect(RomanChord.new('IV', key: key).root_note).to   be_enharmonic('F')
    expect(RomanChord.new('V', key: key).root_note).to    be_enharmonic('G')
    expect(RomanChord.new('VI', key: key).root_note).to   be_enharmonic('A')
    expect(RomanChord.new('vii', key: key).root_note).to  be_enharmonic('B')
  end

  it 'detects the quality name' do
    expect(RomanChord.new('III', key: key).quality.name).to     eq ('M')
    expect(RomanChord.new('ii', key: key).quality.name).to      eq ('m')
    expect(RomanChord.new('v7', key: key).quality.name).to      eq ('m7')
    expect(RomanChord.new('IV7', key: key).quality.name).to     eq ('7')
    expect(RomanChord.new('iiio', key: key).quality.name).to    eq ('dim')
    expect(RomanChord.new('iiio7', key: key).quality.name).to   eq ('dim7')
    expect(RomanChord.new('ivø', key: key).quality.name).to     eq ('m7b5')
    expect(RomanChord.new('VIIm7b5', key: key).quality.name).to eq ('m7b5')
  end

  it 'detects the chord' do
    expect(RomanChord.new('I', key: key).chord.name).to eq Chord.new(name: 'CM').name
    expect(RomanChord.new('ii', key: key).chord.name).to eq Chord.new(name: 'Dm').name
    expect(RomanChord.new('ivdim', key: key).chord.name).to eq Chord.new(name: 'Fdim').name
    expect(RomanChord.new('VIIm7b5', key: key).chord.name).to eq Chord.new(name: 'Bm7b5').name
    expect(RomanChord.new('I7', key: key).chord.name).to eq Chord.new(name: 'C7').name
    expect(RomanChord.new('Im7', key: key).chord.name).to eq Chord.new(name: 'Cm7').name
  end

end
