RSpec.describe ChordQuality do
  let :notes do
    [
      Note.new('A'),
      Note.new('E'),
      Note.new('G'),
      Note.new('C#')
    ]
  end

  it 'can return quality from notes' do
    expect(ChordQuality.new(notes: %w[C E G]).name).to eq('M')
    expect(ChordQuality.new(notes: notes).name).to eq('7')
  end
end
