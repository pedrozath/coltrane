module Coltrane
  module UI
    module Views
      class Chords < View
        questions({
          path: {
            statement: 'What do you need',
            options: [
              'show chord',
              'find chord by notes',
              'find chords in scale',
              'find common chords in scales'
            ]
          }
        })
      end
    end
  end
end
