module Coltrane
  module UI
    module Views
      class Progressions < View
        questions({
          path: {
            statement: 'What do you need?',
            options: [
              'show progression',
              'custom progression',
              'find progressions from chords'
            ]
          }
        })
      end
    end
  end
end
