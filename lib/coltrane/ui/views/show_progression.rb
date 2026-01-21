module Coltrane
  module UI
    module Views
      class ShowProgression < BaseView
        questions({
          progression: {
            statement: 'What is the progression?',
            options: Commands::AvailableNotableProgressions.run
          },

          representation: {
            statement: 'How do you wanna see the chords?',
            options: Commands::AvailableChordRepresentations.run
          },

          root: { statement: 'Start at which note? (Ex: C; D#; Fb)' }
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
          chords = Commands::GetChordsFromNotableProgression.run(*params.values_at(:progression, :root))
          representation = params[:representation]
          tuning_key = params[:tuning]
          custom_tuning = params[:custom_tuning]

          if self.class.needs_instrument?(representation)
            instrument_instance = self.class.get_instrument_for_representation(representation, tuning_key, custom_tuning)
            Commands::GetRepresentationChords.run(representation, chords, instrument_instance)
          else
            Commands::GetRepresentationChords.run(representation, chords)
          end
        end
      end
    end
  end
end
