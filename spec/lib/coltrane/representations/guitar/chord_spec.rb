# frozen_string_literal: true

RSpec.describe Guitar::Chord do
  let!(:c_chords) { Guitar.find_chords('CM').map(&:to_s) }

  it 'can be used to find chords' do
    expect(c_chords).to include('x-3-2-0-1-0')
  end

  it 'returns the best chords at the top' do
    # puts Guitar.find_chords('CM').map {|chord| chord.to_s(debug: true)}
    expect(c_chords.index('3-3-2-0-1-0')).to be < 3
  end
end
