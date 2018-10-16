module Coltrane
  module UI
    module Views
      class ShowChord < View
        questions({
          chord: { statement: 'Which chord?' },
          chord_representation: {
            statement: 'How do you wanna see it?',
            options: Commands::AvailableChordRepresentations.run
          }
        })

        def render
          chord = Commands::GetChordsFromString.run(params[:chord]).first
          Commands::GetRepresentationChords.run(params[:chord_representation], [chord])
        end

      end
    end
  end
end
