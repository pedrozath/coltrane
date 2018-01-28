module Coltrane
  module Cli
    class Representation
      ACCEPTED_FLAVORS = %i[marks notes intervals degrees]

      def self.inherited(subclass)
        @@types ||= {}
        @@types[subclass.to_s.split('::').last.underscore.to_sym] = subclass
      end

      def self.build(type, notes, flavor)
        raise WrongFlavorError.new unless ACCEPTED_FLAVORS.include?(flavor)
        type = case type
          when :ukelele then :ukulele
          when :bass then :bass_guitar
          else type
        end

        if (the_class = @@types[type])
          the_class.new(notes, flavor)
        else
          raise WrongRepresentationTypeError.new(type)
        end
      end

      def initialize(notes, flavor)
        @notes    = notes
        @flavor   = flavor
        @ref_note = notes.first
      end

      def hint
        case @flavor
        when :marks     then ""
        when :notes     then "(\u266E means the note is natural, not flat nor sharp)"
        when :intervals
          <<~DESC
            The letters represent the intervals relative to the root tone
            Ex: 1P = Perfect First / 3m = Minor Third / 4A = Augmented Fourth
          DESC

        when :degrees then "(The numbers represent the degree of the note in the scale)"
        end
      end
    end
  end
end