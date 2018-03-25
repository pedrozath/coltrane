module Coltrane
  module Renderers
    module TextRenderer
      class RepresentationGuitarNoteSetDrawer < BaseDrawer
        alias guitar_notes model

        def guitar
          @guitar ||= guitar_notes.guitar
        end

        def frets
          guitar.frets
        end

        def render
          [render_notes, render_special_frets].join("\n" * 2)
        end

        def render_notes
          guitar_notes.strings.map.with_index.map do |string, str_i|
            Array.new(frets + 2) do |i|
              if i.zero?
                Paint[
                  string[:pitch].pitch_class.name,
                  HSL.new(140 + str_i * 20, 50, 50).html
                ]
              else
                (i - 1)
                .yield_self { |fret|
                  (string[:pitch] + fret)
                  .yield_self { |pitch|
                    if guitar_notes.notes.include?(pitch.pitch_class)
                      place_mark(pitch.pitch_class)
                    else
                      place_empty(str_i)
                    end
                  }
                  .yield_self { |mark| mark + (fret.zero? ? (' |') : '') }
                }
              end
            end.join(' ')
          end.join("\n")
        end

        def render_special_frets
          '  ' +
            Array.new(frets + 2) do |fret|
              m = guitar.special_frets.include?(fret) ? fret.to_s.rjust(2, 0.to_s) : '  '
              "#{m}#{'  ' if fret.zero?}"
            end.join(' ')
        end

        def place_empty(str_i)
          Paint['--', HSL.new(180 + str_i * 3, 50, 30).html]
        end

        def place_mark(note)
          mark = case flavor
                 when :notes     then note.pretty_name.ljust(2, ' ')
                 when :intervals then (guitar_notes.root - note).name.ljust(2, '-')
                 when :degrees   then guitar_notes.notes.degree(note).to_s.rjust(2, '0')
                 when :marks     then '  ' # '◼◼'
                 else raise WrongFlavorError
                 end

          base_hue = (180 + note.integer * 10) % 360 # + 260
          Paint[
            mark,
            HSL.new(0, 0, 100).html,
            HSL.new(base_hue, 100, 30).html
          ]
        end
      end
    end
  end
end