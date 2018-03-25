module Coltrane
  module Renderers
    module TextRenderer
      class TheoryScaleSetDrawer < BaseDrawer
        alias scale_set model

        def render
          output = []
          scale_width = scale_set.results.keys.map(&:size).max
          scale_set.results.each do |name, scales_by_tone|
            output << name.ljust(scale_width + 1, ' ')
            scales_by_tone.each do |tone_number, notes|
              p     = (notes.size.to_f / scale_set.searched_notes.size) * 100
              l     = p == 100 ? p : (p + 20) * 0.4
              und   = p == 100 ? :underline : nil
              color = Color::HSL.new(30, p, l / 2).html
              output << Paint["#{Theory::Note[tone_number].name}(#{notes.size})", color, und]
              output << ' '
            end
            output << "\n"
          end
          output.join
        end
      end
    end
  end
end