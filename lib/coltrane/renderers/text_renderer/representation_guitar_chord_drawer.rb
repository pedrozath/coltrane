# frozen_string_literal: true

module Coltrane
  module Renderers
    module TextRenderer
      class RepresentationGuitarChordDrawer < BaseDrawer
        alias chord model

        def chord_height
          chord.max_fret_span
        end

        def guitar
          chord.guitar
        end

        def render
          render_top(chord) +
            (chord.lowest_fret..chord.lowest_fret + chord_height)
            .each_with_index.reduce('') do |memo1, (f, y)|
                memo1 +
                  '   ' +
                  (chord.guitar.strings.size * 2).times.map { |x| base_color border(x, y) }.join('') +
                  "\n" +
                  chord.guitar.strings.reduce(base_color(f.to_s.ljust(2, ' '))) do |memo2, s|
                    memo2 +
                      ' ' +
                    render_note(chord.guitar_notes.select do |n|
                      n.string == s && n.fret == f
                    end.any?)
                  end +
                  " \n"
            end + '   ' +
            (chord.guitar.strings.size * 2).times.map do |x|
              base_color border(x, chord_height + 1)
            end.join('')
        end

        def border(x, y)
          edge = [guitar.tuning.size * 2 - 2, chord_height + 1]
          x_on_start  = x == 0
          y_on_start  = y == 0
          x_on_edge   = x == edge[0]
          y_on_edge   = y == edge[1]
          x_on_middle = (0...edge[0]).cover?(x)
          y_on_middle = (0...edge[1]).cover?(y)

          if    x_on_start  && y_on_start  then '┍'
          elsif x_on_middle && y_on_start  then x.odd? ? '━' : '┯'
          elsif x_on_edge   && y_on_start  then '┑'
          elsif x_on_start  && y_on_middle then '┝'
          elsif x_on_middle && y_on_middle then x.odd? ? '━' : '┿'
          elsif x_on_edge   && y_on_middle then '┥'
          elsif x_on_start  && y_on_edge   then '┕'
          elsif x_on_middle && y_on_edge   then x.odd? ? '━' : '┷'
          elsif x_on_edge   && y_on_edge   then '┙'
          else ' '
          end
          # puts edge.inspect
          # "#{x},#{y} "
        end

        def base_color(str)
          Paint[str, '#6A4AC2']
        end

        def highlight(str)
          Paint[str, '#E67831']
        end

        def alt(str)
          Paint[str, '#2DD380']
        end

        def render_top(chord)
          chord.guitar.strings.reduce('   ') do |memo, s|
            memo +
              if chord.guitar_notes.select do |n|
                n.string == s && n.fret == 0 end.any?
                highlight '• '
              elsif chord.guitar_notes.select { |n| n.string == s && n.fret.nil? }.any?
                alt 'x '
              else
                '  '
              end
          end + "\n"
        end

        def render_note(found)
          found ? highlight('•') : base_color('│')
        end
      end
    end
  end
end
