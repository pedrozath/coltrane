module Coltrane
  module UI
    module Views
      class Index < BaseView
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
