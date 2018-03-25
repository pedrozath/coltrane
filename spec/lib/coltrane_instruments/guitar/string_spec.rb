# frozen_string_literal: true

RSpec.describe ColtraneInstruments::Guitar::String do
  let(:string) { ColtraneInstruments::Guitar::Base.new.strings.first }

  it 'can return possible frets for note' do
    pclass = PitchClass.new('E')
    expect(string.find(pclass).map(&:fret)).to eq([0, 12])
  end
end
