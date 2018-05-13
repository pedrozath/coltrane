module Coltrane
  module Commands
    class Scale < Command
      def representation
        return on_model if on == :text
        { preface => on_model }
      end

      def self.parse(scale_notation)
        scale_notation
        .split(' ', 2)
        .yield_self { |(tone, scale_name)|
          Theory::Scale.fetch(scale_name.gsub(' ', '_'), tone)
        }
      end

      def self.mercenary_init(program)
        program.command(:scale) do |c|
          c.syntax 'scale <root_note> <scale name> [--on <instrument>]'
          c.description 'Gives you information about a scale. Ex: coltrane scale D Natural Minor --on guitar'
          c.option :tertians, '--tertians <SIZE>', 'Outputs all tertian chords from the given size from the scale'
          c.option :chords,   '--chords [SIZE]', 'Outputs all chords from given size from the scale. Leave size empty to retrieve all'
          add_shared_option(:flavor, c)
          add_shared_option(:on, c)
          add_shared_option(:voicings, c)

          c.action { |scale_notation, **options|
            parse(scale_notation.join(' '))
            .yield_self { |scale|
              if options[:tertians]
                scale
                .tertians(options[:tertians].to_i)
                .each { |chord| Commands::Chords.new(chord, **options).render }
              elsif options[:chords]
                scale.chords(options[:chords].to_i)
                .each { |chord| Commands::Chords.new(chord, **options).render }
              else
                Commands::Notes.new(scale.notes, **options.merge(preface: scale.full_name)).render
              end
            }
          }
        end
      end
    end
  end
end