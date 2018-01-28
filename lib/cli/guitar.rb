module Coltrane
  module Cli
    SPECIAL_FRETS = [3, 5, 7, 9, 12, 15, 17, 19]

    class Guitar < Representation
      def initialize(notes, flavor, tuning: %w[E A D G B E], frets: 22)
        @notes    = notes
        @tuning   = tuning.reverse
        @frets    = frets
        @flavor   = flavor
        @ref_note = @notes.first
      end

      def render
        [render_notes, render_special_frets, hint].join("\n"*2)
      end

      def render_notes
        @tuning.map do |string|
          string_note = Note[string]
          (@frets+2).times.map do |i|
            if i.zero?
              string
            else
              fret = i - 1
              note = string_note + fret
              m = (@notes.include?(note) ? place_mark(note) : "--")
              fret.zero? ? (m + " |") : m
            end
          end.join(' ')
        end.join("\n")
      end

      def render_special_frets
        (@frets+1).times.map do |fret|
          m = SPECIAL_FRETS.include?(fret) ? fret.to_s.rjust(2, 0.to_s) : '  '
          "#{m}#{'  ' if fret.zero?}"
        end.join(' ')
      end

      def render_dotted_frets
      end

      def place_mark(note)
        case @flavor
        when :notes     then note.pretty_name.ljust(2, "\u266E")
        when :intervals then (@ref_note - note).name.ljust(2, '-')
        when :degrees   then @notes.degree(note).to_s.rjust(2, '0')
        when :marks     then '◼◼'
        else raise WrongFlavorError.new
        end
      end
    end
  end
end