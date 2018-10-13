module Coltrane
  module Cli
    module Views
      class Index < View
        questions({
          path: {
            statement: "Welcome to Coltrane #{Coltrane::VERSION}",
            options: %w[notes chords scales progressions exit]
          }
        })
      end
    end
  end
end
