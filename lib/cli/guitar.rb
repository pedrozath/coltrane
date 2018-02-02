# frozen_string_literal: true

module Coltrane
  module Cli
    # Renders notes in a common most popular ukulele scheme
    class Guitar < Representation
      SPECIAL_FRETS = [3, 5, 7, 9, 12, 15, 17, 19].freeze

      include Color
      def initialize(notes, flavor, tuning: %w[E A D G B E], frets: 22)
        @notes    = notes
        @tuning   = tuning.reverse
        @frets    = frets
        @flavor   = flavor
        @ref_note = @notes.first
      end

      def render
        [render_notes, render_special_frets, hint].join("\n" * 2)
      end

      def render_notes
        @tuning.each_with_index.map do |string, str_i|
          string_note = Note[string]
          Array.new(@frets + 2) do |i|
            if i.zero?
              Paint[string, HSL.new(140 + str_i * 20,50,50).html]
            else
              fret = i - 1
              note = string_note + fret
              m = (@notes.include?(note) ? place_mark(note) : place_empty(str_i))
              fret.zero? ? (m + ' |') : m
            end
          end.join(' ')
        end.join("\n")
      end

      def render_special_frets
        '  ' +
        Array.new(@frets + 2) do |fret|
          m = SPECIAL_FRETS.include?(fret) ? fret.to_s.rjust(2, 0.to_s) : '  '
          "#{m}#{'  ' if fret.zero?}"
        end.join(' ')
      end

      def place_empty(str_i)
        Paint['--', HSL.new(180 + str_i * 3,50,30).html]
      end

      def place_mark(note)
        mark =
          case @flavor
          when :notes     then note.pretty_name.ljust(2, ' ')
          when :intervals then (@ref_note - note).name.ljust(2, '-')
          when :degrees   then @notes.degree(note).to_s.rjust(2, '0')
          when :marks     then '  ' # '◼◼'
          else raise WrongFlavorError
          end

        base_hue = (180 + note.number * 10) % 360 # + 260
        Paint[
          mark,
          HSL.new(0, 0, 100).html,
          HSL.new(base_hue, 100, 30).html
        ]
      end
    end
  end
end
