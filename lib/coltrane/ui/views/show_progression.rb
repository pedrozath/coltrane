module Coltrane
  module UI
    module Views
      class ShowProgression < BaseView
        questions({
          progression: {
            statement: 'What is the progression?',
            options: Commands::AvailableNotableProgressions.run
          },

          representation: {
            statement: 'How do you wanna see the chords?',
            options: Commands::AvailableChordRepresentations.run
          },

          root: { statement: 'Start at which note? (Ex: C; D#; Fb)' }
        })

        def render
          chords = Commands::GetChordsFromNotableProgression.run(*params.values_at(:progression, :root))
          Commands::GetRepresentationChords.run(params[:representation], chords)
        end
      end
    end
  end
end
