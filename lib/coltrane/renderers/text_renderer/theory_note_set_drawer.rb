module Coltrane
  module Renderers
    module TextRenderer
      class TheoryNoteSetDrawer < BaseDrawer
        def render
          case flavor
          when :marks, :notes, :degrees
            model.pretty_names.join(' ')
          when :intervals
            model.map { |n| (model.first - n).name }.join(' ')
          else raise WrongFlavorError
          end
        end
      end
    end
  end
end