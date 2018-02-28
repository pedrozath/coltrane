# frozen_string_literal: true

RSpec.describe Frequency do
  it 'can properly print' do
    expect(Frequency.new(200).to_s)
      .to eq '200.0hz'
  end

  it 'can do simple math' do
    expect(Frequency.new(200) + Frequency.new(120.3333)).to eq(320.3333)
    expect(Frequency.new(200) - Frequency.new(120.3333)).to eq(79.6667)
  end

  it 'can octave up/down' do
    expect(Frequency[440].octave(0))      .to eq(440)
    expect(Frequency[440].octave(1))      .to eq(880)
    expect(Frequency[440].octave_up)      .to eq(880.00)
    expect(Frequency[440].octave_up(2) )  .to eq(1760.00)
    expect(Frequency[440].octave_down)    .to eq(220)
    expect(Frequency[440].octave(-1))     .to eq(220)
    expect(Frequency[440].octave_down(2)) .to eq(110)
    expect(Frequency[440].octave(-2))     .to eq(110)
  end

  it 'is still a frequency after divided by integer' do
    expect(Frequency[200] / 2).to be_instance_of Frequency
  end

  it 'can return interval in cents' do
    expect((Frequency[440] / Frequency[880]).cents).to eq(-1200)
    expect((Frequency[880] / Frequency[440]).cents).to eq(1200)
  end
end
