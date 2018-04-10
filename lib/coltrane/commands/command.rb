module Coltrane
  module Commands
    class Command
      COMMON_OPTIONS = {
        on: [
          '--on <INSTRUMENT>',
          'Shows the notes on the given instrument/representation type. ' \
          'Can be text, piano, guitar, ukulele, bass.' \
          'You can also provide a custom guitar using the following format:' \
          '--on custom_guitar=D2-A3-D3-B3-C3'
        ],

        flavor: [
          '--flavor <FLAVOR>',
          'Chooses which additional information to display: ' \
          'marks, notes, intervals or degrees'
        ],

        voicings: [
          '--voicings <NUMBER>',
          'Number of voicings for guitar like instruments. Default is 6' \
          'provided they are separated by dashes'
        ]
      }

      def custom_guitar
        on
        .to_s
        .split('=')
        .fetch(1)
        .split('-')
        .yield_self { |tuning| Representation::Guitar.new(tuning: tuning) }
      end

      def render
        puts "\n" + Renderers::TextRenderer.render(
          representation, **renderer_options
        )
      end

      def renderer_options
        {}
      end

      class << self

        def subclasses
          @subclasses ||= []
        end

        def inherited(base)
          subclasses << base
          super(base)
        end

        def add_shared_option(option_name, mercenary_command)
          mercenary_command.option(option_name, *COMMON_OPTIONS[option_name])
        end
      end
    end
  end
end