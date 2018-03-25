module Coltrane
  module Renderers
    module TextRenderer
      class TheoryChordDrawer < BaseDrawer
        alias chord model

        def render
          "#{chord.name}: ".ljust(5) +
          TextRenderer.render(chord.notes, **options)
        end
      end
    end
  end
end