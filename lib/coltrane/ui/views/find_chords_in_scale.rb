require 'coltrane/ui/views/show_scale'

module Coltrane
  module UI
    module Views
      class FindChordsInScale < ShowScale
        questions({
          chord_type: {
            statement: 'Which kind of chords?',
            options: ['tertian', 'all']
          },

          chord_size: {
            statement: 'What is the size of the chords',
            options: (3..7).to_a.map(&:to_s)
          },

          chord_representation: {
            statement: 'How do you wanna see this',
            options: Commands::AvailableChordRepresentations.run
          }
        })
        def render
          scale = Commands::GetClassicScale.run(*params.values_at(:scale, :tone))
          chords = Commands::GetChordsFromScale.run(
            scale,
            *params.values_at(:chord_type, :chord_size)
          )
          Commands::GetRepresentationChords.run(params[:chord_representation], chords)
        end
      end
    end
  end
end
