module Coltrane
  module Commands
    class FindProgression < Command
      attr_reader :progression_set

      def initialize(progression_set, **options)
        @progression_set = progression_set
      end

      def representation
        progression_set
      end

      def self.mercenary_init(program)
        program.command(:'find-progression') do |c|
          c.syntax 'find-progression <list of chords>'
          c.description 'Find progressions in scales. Ex: coltrane find-progression AM-DM-F#m-EM'
          c.action do |(chord_notation)|
            chord_notation
            .split('-')
            .yield_self { |chords| Theory::Progression.find(*chords) }
            .yield_self { |progression_set| new(progression_set).render }
          end
        end
      end
    end
  end
end