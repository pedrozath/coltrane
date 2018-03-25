# frozen_string_literal: true

RSpec.describe Pitch do
  it 'can be created by frequency' do
    expect(Pitch.new(frequency: 8.176).integer).to  eq(0)
    expect(Pitch.new(frequency: 8.662).integer).to  eq(1)
    expect(Pitch.new(frequency: 15.434).integer).to eq(11)
    expect(Pitch.new(frequency: 440.0).integer).to  eq(69)
    expect(Pitch.new(frequency: 7040.0).integer).to eq(117)
  end

  it 'can be created by notation' do
    expect(Pitch.new('C0').integer).to eq(12)
    expect(Pitch.new('C#0').integer).to eq(13)
    expect(Pitch.new('A4').integer).to eq(69)
    expect(Pitch.new('D12').integer).to eq(158)
    expect(Pitch.new('F3').integer).to eq(53)
  end

  it 'can be created by notation' do
    expect(Pitch.new(note: 'C',  octave: 0).integer).to eq(12)
    expect(Pitch.new(note: 'C#', octave: 0).integer).to eq(13)
    expect(Pitch.new(note: 'A',  octave: 4).integer).to eq(69)
    expect(Pitch.new(note: 'D',  octave: 12).integer).to eq(158)
    expect(Pitch.new(note: 'F',  octave: 3).integer).to eq(53)
  end

  it 'can be created by number' do
    expect(Pitch[12].name).to eq('C0')
    expect(Pitch[13].name).to eq('C#0')
    expect(Pitch[69].name).to eq('A4')
    expect(Pitch[53].name).to eq('F3')
    expect(Pitch[56].name).to eq('G#3')
  end

  it 'can return frequencies' do
    expect(Pitch['C3'].frequency).to  eq(130.8127826502993)
    expect(Pitch['C4'].frequency).to  eq(261.6255653005986)
    expect(Pitch['C5'].frequency).to  eq(523.2511306011972)
    expect(Pitch['A4'].frequency).to  eq(440.0)
    expect(Pitch['C1'].frequency).to  eq(32.70319566257483)
    expect(Pitch['D2'].frequency).to  eq(73.4161919793519)
    expect(Pitch['G#3'].frequency).to eq(207.65234878997256)
  end

  it 'can perform math operations' do
    expect(Pitch['C3'] + 2).to  eq(Pitch['D3'])
    expect(Pitch['C3'] + 12).to eq(Pitch['C4'])
    expect(Pitch['C3'] + 24).to eq(Pitch['C5'])
    expect(Pitch['C3'] + 0).to  eq(Pitch['C3'])
    expect(Pitch['C3'] - 0).to  eq(Pitch['C3'])
    expect(Pitch['C3'] - 1).to  eq(Pitch['B2'])
    expect(Pitch['C3'] - 12).to eq(Pitch['C2'])
  end

  it 'can return the pitch class' do
    expect(Pitch['G#3'].pitch_class).to eq(PitchClass['G#'])
  end

  it 'can return the octave' do
    expect(Pitch['G#3'].octave).to eq(3)
  end
end
