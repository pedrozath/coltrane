module Coltrane
  module Cli
    class Scale
      def initialize(scale_name, root_note, on: "text", command: :notes)
        @scale = Coltrane::Scale.public_send(scale_name, root_note)
        case command
        when :notes
          desc = if on == "text"
                   "The notes of the given scale are:"
                 else
                   "This is the #{@scale.tone.name} #{@scale.name} scale on #{on}"
                 end

          Coltrane::Cli::Notes.new(@scale.notes, on: on, desc: desc)
        end
      end
    end
  end
end