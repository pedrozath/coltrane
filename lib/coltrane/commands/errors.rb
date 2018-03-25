# frozen_string_literal: true

# rubocop:disable Style/Documentation

module Coltrane
  class CommandError < StandardError
    def initialize(msg)
      super msg
    end
  end

  class WrongFlavorError < CommandError
    def initialize(msg = nil)
      super msg || 'Wrong flavor. Check possible flavors with `coltrane list flavors`.'
    end
  end

  class BadFindScales < CommandError
    def initialize(msg = nil)
      super msg || 'Provide --notes or --chords. Ex: `coltrane find-scale --notes C-E-G`.'
    end
  end

  class WrongRepresentationTypeError < CommandError
    def initialize(type)
      super "The provided representation type (#{type}) "\
            'is not available at the moment.'
    end
  end

  class BadScaleError < CommandError
    def initialize(msg = nil)
      super msg || 'Incorrect scale, please specify scale and root separated by `-`. Ex: `coltrane scale major-C'
    end
  end

  class BadChordError < CommandError
    def initialize(msg = nil)
      super msg || 'Incorrect chord, please specify a set of chords separated by `-`. Ex: coltrane chord CM7'
    end
  end
end

# rubocop:enable Style/Documentation
