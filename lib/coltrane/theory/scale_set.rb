module Coltrane
  module Theory
    class ScaleSet
      extend Forwardable
      def_delegators :scales, :map

      attr_accessor :scales, :searched_notes

      def initialize(*scales, searched_notes: nil)
        @scales = scales.uniq
        @searched_notes = searched_notes
      end

      def strict_scales
        @strict_scales ||= scales.select do |scale|
          (scale.notes & searched_notes).size == searched_notes.size
        end
      end

      def results
        raise 'No searched notes were provided' unless searched_notes
        @table ||=
          scales.each_with_object({}) do |scale, the_table|
            the_table[scale.name] ||= {}
            the_table[scale.name][scale.tone.pitch_class.name] = (
              scale.notes & searched_notes
            )
          end
      end

      def names
        map(&:name)
      end

      def full_names
        map(&:full_name)
      end
    end
  end
end