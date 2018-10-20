module Coltrane
  module UI
    module Views
      class FindScale < BaseView
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
