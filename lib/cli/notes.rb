module Coltrane
  module Cli
    class Notes
      def initialize(notes, on: :text, desc: 'The notes you supplied:', flavor: :notes)
        @desc   = desc
        @notes  = Coltrane::NoteSet.new(notes)
        @hint   = hint
        @flavor = flavor.downcase.to_sym
        send("on_#{on}")
      end

      def hint
        case @flavor
        when :marks     then ""
        when :notes     then "(\u266E means the note is natural, not flat nor sharp)"
        when :intervals then "(The letters represent the intervals relative to the root tone)"
        when :degrees   then "(The numbers represent the degree of the note in the scale)"
        end
      end

      def on_text
        puts <<~OUTPUT

          #{@desc}

          #{@notes.pretty_names.join(' ')}

          #{hint}

        OUTPUT
      end

      def on_piano
        puts <<~OUTPUT

          #{@desc}

          #{Coltrane::Cli::Piano.new(@notes, flavor: @flavor).render_intervals}

          #{hint}

        OUTPUT
      end

      def on_guitar
        puts <<~OUTPUT

          #{@desc}

          #{Coltrane::Cli::Guitar.new(@notes, flavor: @flavor).render}

          #{hint}

        OUTPUT
      end
    end
  end
end