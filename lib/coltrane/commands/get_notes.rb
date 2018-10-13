module Coltrane
  module Commands
    class GetNotes < Command
      def run(*notes)
        Theory::NoteSet[*notes]
      end
    end
  end
end
