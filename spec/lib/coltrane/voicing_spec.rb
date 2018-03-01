RSpec.describe Voicing do
  it 'has notes' do
    expect(Voicing['C3', 'A8', 'G4'].notes.names)
      .to contain_exactly('C', 'A', 'G')
  end

  it 'may have a chord' do
    expect(Voicing['C3', 'E8', 'G4'].chord.name).to eq('CM')
  end

  it 'may not have a chord' do
    expect(Voicing['C3', 'A8', 'G4'].chord).to be_falsey
  end
end
