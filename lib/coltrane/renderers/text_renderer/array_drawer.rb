module Coltrane
  module Renderers
    module TextRenderer
      class ArrayDrawer < BaseDrawer
        alias array model

        def render
          public_send("render_#{layout}")
        end

        def renders
          @renders ||= array.map {|it| TextRenderer.render(it, **options) }
        end

        def render_vertical
          renders.join("\n")
        end

        def render_horizontal
          array
          .each_slice(per_row)
          .map { |row|
            row
            .map { |element|
              TextRenderer.render(element, **options)
              .split("\n")
              .yield_self { |lines|
                lines
                .map { |l| l.gsub(/\e\[(\d+)(;\d+)*m/, '').size }
                .max
                .yield_self { |column_w|
                  lines
                  .map { |l| l.ljust(column_w) }
                  .+([' ' * column_w])
                }
              }
            }
            .transpose
            .map(&:join)
          }.join("\n")
        end
      end
    end
  end
end