module Coltrane
  module Commands
    class GetRepresentationNotes < Command
      def run(representation, notes, guitar = nil)
        return notes if representation == 'Text'

        if ['Guitar', 'Ukulele', 'Bass'].include?(representation) && guitar
          guitar.find_notes(notes)
        else
          Object
            .const_get("Coltrane::Representation::#{representation}")
            .find_notes(notes)
        end
      end
    end
  end
end