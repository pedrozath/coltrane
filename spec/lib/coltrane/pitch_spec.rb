RSpec.describe Pitch do
  let(:pitch) { Pitch.new('E2') }

  describe '#initialize' do
    it 'can be initialized by a pitch string' do
      expect(Pitch.new('C#0').number).to eq(1)
      expect(Pitch.new('C1').number).to eq(12)
      expect(Pitch.new('E4').number).to eq(52)
    end

    it 'returns a equivalent pitch if you provide a pitch object' do
      expect(Pitch.new(pitch).number).to eq(pitch.number)
    end
  end

  it 'can return its name' do
    expect(pitch.name).to eq('E2')
  end

  it 'can return its note' do
    expect(pitch.note.name).to eq('E')
  end
end
