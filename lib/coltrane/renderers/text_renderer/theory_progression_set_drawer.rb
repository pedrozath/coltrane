module Coltrane
  module Renderers
    module TextRenderer
      class TheoryProgressionSetDrawer < BaseDrawer
        alias progression_set model

        def render
          progression_set.map do |progression|
            "#{progression.notation.ljust(notation_width + 1, ' ')} in " \
            "#{progression.scale} (#{progression.notes_out.size} notes out)"
          end
          .join("\n")
        end

        def notation_width
          @notation_width ||=
            progression_set.map(&:notation).map(&:size).max
        end
      end
    end
  end
end