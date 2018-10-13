module Coltrane
  module Renderers
    module TextRenderer
      class HashDrawer < BaseDrawer
        alias hash model

        def render
          options = hash.delete(:options) || {}
          hash.map { |k, v|
            "#{k}: \n\n" +
            TextRenderer.render(v, **options)
          }.join("\n")
        end
      end
    end
  end
end