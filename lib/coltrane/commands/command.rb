module Coltrane
  module Commands
    class Command
      attr_reader :error

      def self.run(*args)
        new.run(*args)
      end
    end
  end
end