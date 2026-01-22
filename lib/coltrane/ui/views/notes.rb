module Coltrane
  module UI
    module Views
      class Notes < BaseView
        questions({
          notes: { statement: 'Which notes?' },
          representation: {
            statement: 'How to display?',
            options: Commands::AvailableRepresentations.run
          }
        })

        def self.respond(**params)
          representation = params[:representation]
          
          prompt_tuning_if_needed(params, :representation)
          clear_tuning_if_not_needed(params, :representation)
          
          remaining_questions = @questions.slice(*(@questions.keys - params.keys))
          return { questions: remaining_questions, **params } if remaining_questions.any?
          view = new(**params)
          { content: render(view), **params }
        end

        def render
          notes = Commands::GetNotesFromString.run(params[:notes])
          representation = params[:representation]
          tuning_key = params[:tuning]
          custom_tuning = params[:custom_tuning]

          if self.class::GUITAR_LIKE_INSTRUMENTS.include?(representation)
            instrument_instance = self.class.get_instrument_for_representation(representation, tuning_key, custom_tuning)
            Commands::GetRepresentationNotes.run(representation, notes, instrument_instance)
          else
            Commands::GetRepresentationNotes.run(representation, notes)
          end
        end
      end
    end
  end
end
