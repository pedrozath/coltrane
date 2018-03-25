# frozen_string_literal: true

RSpec.describe Key do
  it 'can parse and return Keys' do
    expect(Key['A#m'].name).to eq('Natural Minor')
    expect(Key['A#m'].tone.name).to eq('A#')

    expect(Key['Bb'].name).to eq('Major')
    expect(Key['Bb'].tone).to eq(Note['A#'])

    expect(Key['DM'].name).to eq('Major')
    expect(Key['DM'].tone.name).to eq('D')

    expect(Key['Dm'].name).to eq('Natural Minor')
    expect(Key['Dm'].tone.name).to eq('D')
  end
end
