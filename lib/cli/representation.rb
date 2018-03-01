# frozen_string_literal: true

module Coltrane
  module Cli
    # It manages notes representations, most of times instruments
    class Representation
      ACCEPTED_FLAVORS = %i[marks notes intervals degrees].freeze

      def self.inherited(subclass)
        @@types ||= {}
        @@types[subclass.to_s.split('::').last.underscore.to_sym] = subclass
      end

      def self.build(notes)
        type = Cli.config.on
        raise WrongFlavorError unless ACCEPTED_FLAVORS.include?(Cli.config.flavor)
        raise(WrongRepresentationTypeError, type) unless @@types.include?(type)
        @@types[type].new(notes)
      end

      def initialize(notes)
        @notes    = notes
        @ref_note = notes.first
      end

      def hint
        case Cli.config.flavor
        when :marks then ''
        # when :notes     then "(\u266E means the note is natural, not flat nor sharp)"
        when :intervals
          <<~DESC
            The letters represent the intervals relative to the root tone
            Ex: 1P = Perfect First / 3m = Minor Third / 4A = Augmented Fourth
          DESC

        when :degrees then '(The numbers represent the degree of the note in the scale)'
        end
      end
    end
  end
end
