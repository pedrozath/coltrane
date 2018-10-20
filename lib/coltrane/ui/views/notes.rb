module Coltrane
  module UI
    module Views
      class Notes < BaseView
        questions({
          notes: { statement: 'Which notes?' } ,
          representation: {
            statement: 'How to display?',
            options: Commands::AvailableRepresentations.run
          }
        })

        def render
          notes = Commands::GetNotesFromString.run(params[:notes])
          Commands::GetRepresentationNotes.run(params[:representation], notes)
        end
      end
    end
  end
end
