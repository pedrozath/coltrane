module Coltrane
  module Commands
    class CommonChords < Command
      def self.parse(scale_notation)
        scale_notation
        .split(' ', 2)
        .yield_self { |(tone, scale_name)|
          Theory::Scale.fetch(scale_name.gsub(' ', '_'), tone)
        }
      end

      def self.mercenary_init(program)
        program.command(:'common-chords') do |c|
          c.alias(:'common-chord')
          add_shared_option(:flavor, c)
          add_shared_option(:on, c)
          c.syntax 'common-chords [TONE_1 SCALE_NAME_1], [TONE_2 SCALE_NAME_2], [...]'
          c.description 'Finds chords that are shared between the given scales'
          c.action do |(*scale_strings), **options|
            scale_strings
            .join(' ')
            .split(',')
            .map { |scale_notation|
              Commands::Scale.parse(scale_notation).all_chords
            }
            .reduce(:&)
            .each   { |chord| Commands::Chords.new(chord, **options).render }
          end
        end
      end
    end
  end
end