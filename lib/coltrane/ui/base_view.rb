module Coltrane
  module UI
    class BaseView < Gambiarra::View
      GUITAR_LIKE_INSTRUMENTS = ['Guitar', 'Ukulele', 'Bass'].freeze
      CHORD_REPRESENTATIONS = ['GuitarChordChart', 'Guitar', 'Ukulele', 'Bass'].freeze

      def self.render(view)
        Commands::Render.run(view.render)
      end

      # Handle tuning selection for guitar-like instruments
      # representation_param: the parameter name to check (e.g., :chord_representation, :representation)
      # instrument_param: the parameter name for storing the instrument (defaults to :tuning)
      def self.prompt_tuning_if_needed(params, representation_param, instrument_param = :tuning)
        representation = params[representation_param]
        
        return if params[instrument_param].present?
        
        instrument_type = needs_tuning?(representation)
        return unless instrument_type
        
        tuning_options = Commands::AvailableInstrumentTunings.run(instrument_type)
        tuning = CLI::UI::Prompt.ask('Which tuning?', options: tuning_options)
        
        params[instrument_param] = tuning
        params[:custom_tuning] = prompt_custom_tuning if tuning == 'Custom'
      end

      def self.needs_tuning?(representation)
        return representation if GUITAR_LIKE_INSTRUMENTS.include?(representation)
        return 'Guitar' if representation == 'GuitarChordChart'
        nil
      end

      def self.prompt_custom_tuning
        puts "\nEnter custom tuning (comma-separated notes, e.g., E2,A2,D3,G3,B3,E4):"
        input = gets.strip
        input.split(',').map(&:strip) unless input.empty?
      end

      def self.clear_tuning_if_not_needed(params, representation_param)
        return if needs_tuning?(params[representation_param])
        
        params.delete(:tuning)
        params.delete(:custom_tuning)
      end

      def self.normalize_instrument(representation)
        representation == 'GuitarChordChart' ? 'Guitar' : representation
      end

      def self.get_instrument_for_representation(representation, tuning_key, custom_tuning)
        instrument_name = normalize_instrument(representation)
        Commands::GetInstrumentWithTuning.run(instrument_name, tuning_key, custom_tuning)
      end

      def self.needs_instrument?(representation)
        CHORD_REPRESENTATIONS.include?(representation)
      end
    end
  end
end
