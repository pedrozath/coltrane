module Coltrane
  module UI
    module Views
      class ShowScale < BaseView
        questions({
          scale: {
            statement: 'Which Scale?',
            options: Commands::AvailableClassicScales.run
          },

          tone: { statement: 'What is the root of the scale?' },

          representation: {
            statement: 'How to display?',
            options: Commands::AvailableRepresentations.run
          }
        })

        def render
          scale = Commands::GetClassicScale.run(*params.values_at(:scale, :tone))
          Commands::GetRepresentationNotes.run(params[:representation], scale.notes)
        end
      end
    end
  end
end
