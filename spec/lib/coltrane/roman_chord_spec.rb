# frozen_string_literal: true

RSpec.describe RomanChord do
  let(:key) { Scale.major('C') }

  it 'can detect the degree' do
    expect(RomanChord.new(key, 'vii').degree).to eq(7)
  end

  it 'can detect the root note' do
    pending
    expect(RomanChord.new(key, 'I').root_note.name).to   eq ('C')
    expect(RomanChord.new(key, 'II').root_note.name).to  eq ('D')
    expect(RomanChord.new(key, 'III').root_note.name).to eq ('E')
    expect(RomanChord.new(key, 'IV').root_note.name).to  eq ('F')
    expect(RomanChord.new(key, 'V').root_note.name).to   eq ('G')
    expect(RomanChord.new(key, 'VI').root_note.name).to  eq ('A')
    expect(RomanChord.new(key, 'vii').root_note.name).to eq ('B')
  end

  it 'detects the quality name' do
    pending
    expect(RomanChord.new(key, 'III').quality.name).to     eq ('M')
    expect(RomanChord.new(key, 'ii').quality.name).to      eq ('m')
    expect(RomanChord.new(key, 'v7').quality.name).to      eq ('m7')
    expect(RomanChord.new(key, 'IV7').quality.name).to     eq ('7')
    expect(RomanChord.new(key, 'iiio').quality.name).to    eq ('dim')
    expect(RomanChord.new(key, 'iiio7').quality.name).to   eq ('dim7')
    expect(RomanChord.new(key, 'ivø').quality.name).to     eq ('m7b5')
    expect(RomanChord.new(key, 'VIIm7b5').quality.name).to eq ('m7b5')
  end

  it 'detects the chord' do
    pending
    expect(RomanChord.new(key, 'I').chord.name).to eq Chord.new(name: 'CM').name
    expect(RomanChord.new(key, 'ii').chord.name).to eq Chord.new(name: 'Dm').name
    expect(RomanChord.new(key, 'ivdim').chord.name).to eq Chord.new(name: 'CM').name
    expect(RomanChord.new(key, 'VIIm7b5').chord.name).to eq Chord.new(name: 'CM').name
    expect(RomanChord.new(key, 'I7').chord.name).to eq Chord.new(name: 'CM').name
    expect(RomanChord.new(key, 'Im7').chord.name).to eq Chord.new(name: 'CM').name
  end

end
