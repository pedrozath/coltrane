# frozen_string_literal: true

RSpec.describe Note do
  it 'returns an interval to other note' do
    expect(Note['C'].interval_to('D').semitones).to eq(2)
  end

  # it 'when summed to intervals it returns the corresponding note' do
  #   expect((Note['C'] + Interval.major_third).name).to eq('E')
  # end

  # it 'can return intervals by subtraction' do
  #   expect((Note['D'] - Note['C']).name).to eq('m7')
  #   expect((Note['B'] - Note['C']).name).to eq('m2')
  #   expect((Note['C'] - Note['C']).name).to eq('P1')
  # end

  it 'can be created by name' do
    expect{Note['L'].name}  .to raise_error ColtraneError
    expect(Note['C'].name)  .to eq('C')
    expect(Note['C#'].name) .to eq('C#')
    expect(Note['Cb'].name) .to eq('Cb')
    expect(Note['Cbb'].name).to eq('Cbb')
  end

  it 'has an alteration level' do
    expect(Note['C'].alteration)  .to eq(0)
    expect(Note['C#'].alteration) .to eq(1)
    expect(Note['Cb'].alteration) .to eq(-1)
    expect(Note['Cbb'].alteration).to eq(-2)
  end

  it 'understands enharmony' do
    expect(Note['C'])  .to eq(Note['C'])
    expect(Note['C#']) .to eq(Note['Db'])
    expect(Note['Cb']) .to eq(Note['B'])
    expect(Note['Cbb']).to eq(Note['Bb'])
    expect(Note['Cbb']).to eq(Note['A#'])
    expect(Note['E#']) .to eq(Note['F'])
    expect(Note['C'])  .to_not eq(Note['C#'])
    expect(Note['C#']) .to_not eq(Note['D'])
    expect(Note['Cb']) .to_not eq(Note['A'])
  end

  it 'can twist a note in many ways' do
    expect(Note['D#'].alter(-1).name).to    eq('Eb')
    expect(Note['D#'].alter(-2).name).to    eq('Fbb')
    expect(Note['C'].alter(-1).name).to     eq('C')
    expect(Note['C'].alter(-2).name).to_not eq('Cbb')
    expect(Note['F'].alter(+1).name).to     eq('E#')
    expect(Note['D'].alter(+2).name).to     eq('C##')
    expect(Note['D'].alter(+1).name).to     eq('D')
    expect(Note['C#'].alter(+1).name).to    eq('C#')
    expect(Note['C#'].alter(-1).name).to    eq('Db')
    expect(Note['D#'].alter(+1).name).to    eq('D#')
    expect(Note['D#'].alter(-1).name).to    eq('Eb')
    expect(Note['F#'].alter(+1).name).to    eq('F#')
    expect(Note['F#'].alter(-1).name).to    eq('Gb')
  end
end
