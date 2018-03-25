module Coltrane
  module Renderers
    module TextRenderer
      class TheoryScaleDrawer < BaseDrawer
        alias scale model

        def render
          TextRenderer.render(scale.notes, **options)
        end
      end
    end
  end
end