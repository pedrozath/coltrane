# frozen_string_literal: true

RSpec.describe Interval do
  it 'can detect if ascending or descending' do
    expect(Frequency[440] / Frequency[480]).to be_ascending
    expect(Frequency[480] / Frequency[410]).to_not be_ascending
    expect(Frequency[999] / Frequency[480]).to be_descending
    expect(Frequency[100] / Frequency[410]).to_not be_descending
    expect(Frequency[440] / Frequency[440]).to_not be_ascending
    expect(Frequency[440] / Frequency[440]).to_not be_descending
  end
end
