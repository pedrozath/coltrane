# frozen_string_literal: true

RSpec.describe Guitar::String do
  let(:string) { Guitar.new.strings.first }

  it 'can return possible frets for note' do
    pclass = PitchClass.new('E')
    expect(string.find(pclass).map(&:fret)).to eq([0, 12])
  end
end
