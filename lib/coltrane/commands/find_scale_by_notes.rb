module Coltrane
  module Commands
    class FindScaleByNotes < Command
      def run(notes)
        Theory::Scale.having_notes(*notes)
      end
    end
  end
end
