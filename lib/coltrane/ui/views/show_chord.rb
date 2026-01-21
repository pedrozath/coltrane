module Coltrane
  module UI
    module Views
      class ShowChord < BaseView
        questions({
          chord: { statement: 'Which chord?' },
          chord_representation: {
            statement: 'How do you wanna see it?',
            options: Commands::AvailableChordRepresentations.run
          }
        })

        def self.respond(**params)
          chord_representation = params[:chord_representation]
          
          prompt_tuning_if_needed(params, :chord_representation)
          clear_tuning_if_not_needed(params, :chord_representation)
          
          remaining_questions = @questions.slice(*(@questions.keys - params.keys))
          return { questions: remaining_questions, **params } if remaining_questions.any?
          view = new(**params)
          { content: render(view), **params }
        end

        def render
          chord = Commands::GetChordsFromString.run(params[:chord]).first
          chord_representation = params[:chord_representation]
          tuning_key = params[:tuning]
          custom_tuning = params[:custom_tuning]

          if self.class.needs_instrument?(chord_representation)
            instrument_instance = self.class.get_instrument_for_representation(chord_representation, tuning_key, custom_tuning)
            Commands::GetRepresentationChords.run(chord_representation, [chord], instrument_instance)
          else
            Commands::GetRepresentationChords.run(chord_representation, [chord])
          end
        end

      end
    end
  end
end
