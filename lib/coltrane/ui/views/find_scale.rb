module Coltrane
  module Cli
    module Views
      class FindScale < View
        questions({
          path: {
            statement: 'How do you wanna search',
            options: ['find scale by chords', 'find scale by notes']
          },
        })
      end
    end
  end
end
