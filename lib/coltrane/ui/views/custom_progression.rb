module Coltrane
  module Cli
    module Views
      class CustomProgression < View
        questions({
          progression_notation: {
            statement: 'What is the progression? (Ex: I-vi-IV-V)'
          },

          representation: {
            statement: 'How do you wanna see the chords?',
            options: Commands::AvailableChordRepresentations.run
          },

          key: {
            statement: 'What is the key?'
          },
        })

        def render
          chords = Commands::GetChordsFromProgression.run(*params.values_at(:progression_notation, :key))
          Commands::GetRepresentationChords.run(params[:representation], chords)
        end
      end
    end
  end
end
