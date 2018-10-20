module Coltrane
  module UI
    module Views
      class FindProgressionsFromChords < BaseView
        questions chords: { statement: 'Type the chords? (Ex: CM EM GM)' }

        def render
          chords = Commands::GetChordsFromString.run(params[:chords])
          Commands::FindProgressionsFromChords.run(*chords)
        end
      end
    end
  end
end
