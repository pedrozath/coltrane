module Coltrane
  module Cli
    module Views
      class FindCommonChordsInScales < View
        questions({
          first_scale: {
            statement: 'Choose the first scale',
            options: Commands::AvailableClassicScales.run
          },

          first_scale_root: {
            statement: 'Type the tone (note)'
          },

          second_scale: {
            statement: 'Choose the second scale',
            options: Commands::AvailableClassicScales.run
          },

          second_scale_root: {
            statement: 'Type the tone (note)'
          },

          representation: {
            statement: 'How do you wanna see the results?',
            options: Commands::AvailableChordRepresentations.run
          }
        })

        def render
          scale_a    = Commands::GetClassicScale.run(*params.values_at(:first_scale, :first_scale_root))
          scale_b    = Commands::GetClassicScale.run(*params.values_at(:second_scale, :second_scale_root))
          chords     = Commands::FindCommonChords.run(scale_a, scale_b)
          rep_chords = Commands::GetRepresentationChords.run(params[:representation], chords)
          { "Chords that exist in #{scale_a.full_name} and #{scale_b.full_name}" => rep_chords }
        end
      end
    end
  end
end
