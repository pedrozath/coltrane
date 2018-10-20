module Coltrane
  module UI
    module Views
      class FindChordByNotes < BaseView
        questions({
          notes: { statement: 'Which Notes?' }
        })

        def render
          notes = Commands::GetNotesFromString.run(params[:notes])
          Commands::FindChordByNotes.run(*notes)
        end
      end
    end
  end
end
