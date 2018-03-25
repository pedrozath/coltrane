module Coltrane
  module Renderers
    module TextRenderer
      class BaseDrawer
        include Paint
        include Color

        attr_reader :model, :options, :flavor, :layout, :per_row

        def initialize(model, **options)
          @model   = model
          @options = options
          @flavor  = options[:flavor]  || :notes
          @layout  = options[:layout]  || :vertical
          @per_row = options[:per_row] || 4
        end
      end
    end
  end
end