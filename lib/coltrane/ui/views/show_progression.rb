module Coltrane
  module Cli
    module Views
      class ShowProgression < View
        questions({
          progression: {
            statement: 'What is the progression?',
            options: Commands::AvailableNotableProgressions.run
          },

          representation: {
            statement: 'How do you wanna see the chords?',
            options: Commands::AvailableChordRepresentations.run
          },

          key: {
            statement: 'What key? (Ex: C; or Am)'
          }
        })

        def render
          chords = Commands::GetChordsFromNotableProgression.run(*params.values_at(:progression, :key))
          Commands::GetRepresentationChords.run(params[:representation], chords)
        end
      end
    end
  end
end
