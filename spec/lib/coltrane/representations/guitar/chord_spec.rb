# frozen_string_literal: true

RSpec.describe Guitar::Chord do
  it 'can be used to find chords' do
    expect(Guitar.find_chords('CM').map(&:to_s))
      .to include('x-3-2-0-1-0')
  end
end
