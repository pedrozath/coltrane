module Coltrane
  module Cli
    class Notes
      def initialize(notes, on: :text, desc: 'The notes you supplied:')
        @desc  = desc
        @notes = Coltrane::NoteSet.new(notes)
        send("on_#{on}")
      end

      def on_text
        puts <<~OUTPUT

          #{@desc}
          #{@notes.names.join(' ')}

        OUTPUT
      end

      def on_piano
        puts <<~OUTPUT

          #{@desc}
          #{Coltrane::Cli::Piano.new(@notes).render_intervals}
          (The letters represent the intervals of the scale)

        OUTPUT
      end

      def on_guitar
        puts <<~OUTPUT

          #{@desc}
          #{Coltrane::Cli::Guitar.new(@notes).render}
          (The letters represent the intervals of the scale)

        OUTPUT
      end
    end
  end
end