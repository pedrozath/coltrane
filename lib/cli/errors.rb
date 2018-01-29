# frozen_string_literal: true

module Coltrane
  module Cli
    class ColtraneCliError < StandardError
      def initialize(msg)
        super msg
      end
    end

    class WrongFlavorError < ColtraneCliError
      def initialize(msg = nil)
        super msg || 'Wrong flavor. Check possible flavors with `coltrane list flavors`.'
      end
    end

    class BadFindScales < ColtraneCliError
      def initialize(msg = nil)
        super msg || 'Provide --notes or --chords. Ex: `coltrane find-scale --notes C E G`.'
      end
    end

    class WrongRepresentationTypeError < ColtraneCliError
      def initialize(type)
        super "The provided representation type (#{type}) "\
              'is not available at the moment.'
      end
    end
  end
end

# rubocop:enable Style/Documentation
