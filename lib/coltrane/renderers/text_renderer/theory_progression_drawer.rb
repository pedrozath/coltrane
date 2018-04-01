module Coltrane
  module Renderers
    module TextRenderer
      class TheoryProgressionDrawer < BaseDrawer
        alias progression model

        def render
          TextRenderer.render(progression.chords, **options)
        end
      end
    end
  end
end