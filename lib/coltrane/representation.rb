# frozen_string_literal: true

require 'coltrane'

module Coltrane
  module Representation
    autoload :Guitar,  'coltrane/representation/guitar'
    autoload :Ukulele, 'coltrane/representation/guitar_like_instruments'
    autoload :Bass,    'coltrane/representation/guitar_like_instruments'
    autoload :Piano,   'coltrane/representation/piano'
  end
end
