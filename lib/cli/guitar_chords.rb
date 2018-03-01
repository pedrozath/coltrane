# frozen_string_literal: true

module Coltrane
  module Cli
    # Renders notes in a common most popular ukulele scheme
    class GuitarChords < Representation
      include Color

      def initialize(notes, tuning: %w[E2 A2 D3 G3 B3 E4], frets: 23)
        @notes    = notes
        @tuning   = tuning.reverse
        @frets    = frets

        target_chord = Coltrane::Chord.new(notes: @notes)
        chords = ColtraneInstruments::Guitar::Base.find_chords(target_chord)
        @chords = chords.sort[-6..-1].reverse
        @chords.each { |c| ColtraneSynth::Base.play(c.voicing) } if false
      end

      def chord_height
        ColtraneInstruments::Guitar::Chord::MAX_FRET_SPAN
      end

      def render
        render_horizontally
        # render_vertically
      end

      def render_vertically
        @chords.map { |c| render_chord(c) }
      end

      def render_horizontally
        rchords = @chords.map { |c| render_chord(c).split("\n") }
        rchords.max_by(&:size).size.times.reduce('') do |memo1, l|
          memo1 +
          rchords.reduce('') do |memo2, c|
            memo2 +
            (c[l].nil? ? " " * (c.map(&:size).max) + '  ' : "#{c[l]}  ")
          end +
          "\n"
        end
      end

      def render_chord(chord)
        render_top(chord) +
        (chord.lowest_fret..chord.lowest_fret+chord_height)
          .each_with_index.reduce('') do |memo1, (f, y)|
            memo1 +
            '   ' +
            (chord.guitar.strings.size*2).times.map {|x| base_color border(x,y) }.join('') +
            "\n" +
            chord.guitar.strings.reduce(base_color f.to_s.ljust(2, ' ')) do |memo2, s|
              memo2 +
              ' ' +
              render_note(chord.guitar_notes.select do |n|
                n.string == s && n.fret == f
              end.any?)
            end +
            " \n"
          end + '   ' +
          (chord.guitar.strings.size*2).times.map do |x|
            base_color border(x, chord_height + 1)
          end.join('')
      end

      def border(x, y)
        edge = [@tuning.size * 2 - 2, chord_height + 1]
        x_on_start  = x == 0
        y_on_start  = y == 0
        x_on_edge   = x == edge[0]
        y_on_edge   = y == edge[1]
        x_on_middle = (0...edge[0]).include?(x)
        y_on_middle = (0...edge[1]).include?(y)

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
          if chord.guitar_notes.select {|n|
            n.string == s && n.fret == 0 }.any?
            highlight '⬤ '
          elsif chord.guitar_notes.select {|n| n.string == s && n.fret == nil }.any?
            alt 'x '
          else
            '  '
          end
        end + "\n"
      end

      def render_note(found)
        found ? highlight('⬤') : base_color('│')
      end
    end
  end
end
