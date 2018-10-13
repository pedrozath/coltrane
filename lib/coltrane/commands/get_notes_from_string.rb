module Coltrane
  module Commands
    class GetNotesFromString < Command
      def run(string)
        GetNotes.run(*string.split(' '))
      end
    end
  end
end
