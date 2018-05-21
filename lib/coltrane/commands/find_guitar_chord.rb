module Coltrane
  module Commands
    class FindGuitarChord < Command
      attr_reader :notation

      def initialize(notation)
        @notation = notation
      end

      def representation
        Representation::Guitar.find_chord_by_notation(notation)
      end

      def self.mercenary_init(program)
        program.command(:'find-guitar-chord') do |c|
          c.syntax 'find-guitar-chord x-2-2-4-5-x'
          c.description 'find the chord name assuming the standard tuning (EADGBE)'
          c.action do |(notation)|
            new(notation).render
          end
        end
      end
    end
  end
end