module Coltrane
  module Commands
    class Command
      COMMON_OPTIONS = {
        on: [
          '--on guitar INSTRUMENT',
          'Shows the notes on the given instrument/representation type. ' \
          'Can be piano, guitar, ukulele, bass or text'
        ],

        flavor: [
          '--flavor FLAVOR',
          'Chooses which additional information to display: ' \
          'marks, notes, intervals or degrees'
        ]
      }

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