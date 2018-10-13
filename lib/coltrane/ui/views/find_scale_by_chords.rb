module Coltrane
  module Cli
    module Views
      class FindScaleByChords < View
        questions({
          chords: { statement: 'Which Chords?' }
        })

        def render
          chords = Commands::GetChordsFromString.run(params[:chords])
          Commands::FindScaleByChords.run(*chords)
        end
      end
    end
  end
end
