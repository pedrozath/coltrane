module Coltrane
  module Cli
    module Views
      class FindChordByNotes < View
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
