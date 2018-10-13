module Coltrane
  module Commands
    class GetRepresentationNotes < Command
      def run(representation, notes)
        return notes if representation == 'Text'
        Object
          .const_get("Coltrane::Representation::#{representation}")
          .find_notes(notes)
      end
    end
  end
end