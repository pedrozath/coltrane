require 'spec_helper'

describe 'Coltrane' do
  context 'notes' do
    command 'coltrane notes C'
    its(:stdout) { is_expected.to include('C') }
  end

  context 'scale' do
    command 'coltrane scale major C'
    its(:stdout) { is_expected.to match(/C.*D.*E.*F.*G.*A.*B/) }
  end
end