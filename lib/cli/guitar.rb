module Coltrane
  module Cli
    SPECIAL_FRETS = [3, 5, 7, 9, 12, 15, 17, 19]

    class Guitar
      def initialize(notes, tuning: %w[E A D G B E], frets: 22, flavor:)
        @notes    = notes
        @tuning   = tuning
        @frets    = frets
        @flavor   = flavor
        @ref_note = @notes.first
      end

      def render
        @tuning.map do |string|
          string_note = Note.new(string)
          @frets.times.map do |fret|
            note = string_note + fret
            m = (@notes.include? ? place_mark(note) : "--")
            fret.zero? ? (m + " |") : m
          end.join(' ')
        end.join("\n") + "\n" +
        @frets.times.map do |fret|
          m = SPECIAL_FRETS.include?(fret) ? fret.to_s.rjust(2, 0.to_s) : '  '
          "#{m}#{'  ' if fret.zero?}"
        end.join(' ')
      end

      def place_mark(note)
        case @flavor
        when :mark      then "◼◼"
        when :note      then note.ljust(2, ' ')
        when :intervals then (@ref_note - note).name.ljust(2, ' ')
        when :degrees   then notes.degree(note)+1
        end
      end
    end
  end
end

  #     def render(guitar_notes, ref_note=nil)
  #       end.join("\n")

  #       special_frets = [3,5,7,9,12,15,17,19,21]
  #       visual_aids = Guitar.frets.times.map do |fret|
  #         x = if special_frets.include?(fret)
  #           Paint[fret.to_s.rjust(2, 0.to_s), :yellow]
  #         else
  #           '  '
  #         end
  #         x + ' '
  #       end.join('')

  #       [tabs, "#{visual_aids}"].join("\n")
  #     end

  #     def render_degrees(guitar_notes, ref_scale)
  #       gns = guitar_notes.guitar_notes.map(&:position)
  #       tabs = Guitar.strings.map do |string|
  #         Guitar.frets.times.map.each do |fret|
  #           position = { guitar_string_index: string.index, fret: fret }
  #           present = gns.include?(position)
  #           x = if present
  #             gn = GuitarNote.new(position)
  #             mark = ref_scale.degree_of_note(gn.note).to_s.rjust(2, 0.to_s)
  #             Paint[mark, :red]
  #           else
  #             '--'
  #           end
  #           x + (fret.zero? ? '|' : ' ')
  #         end.join('')
  #       end.join("\n")

  #       special_frets = [3,5,7,9,12,15,17,19,21]
  #       visual_aids = Guitar.frets.times.map do |fret|
  #         x = if special_frets.include?(fret)
  #           Paint[fret.to_s.rjust(2, 0.to_s), :yellow]
  #         else
  #           '  '
  #         end
  #         x + ' '
  #       end.join('')

  #       [tabs, "#{visual_aids}"].join("\n")
  #     end

  #     def render_notes(guitar_notes, ref_scale)
  #       gns = guitar_notes.guitar_notes.map(&:position)
  #       tabs = Guitar.strings.map do |string|
  #         Guitar.frets.times.map.each do |fret|
  #           position = { guitar_string_index: string.index, fret: fret }
  #           present = gns.include?(position)
  #           x = if present
  #             gn = GuitarNote.new(position)
  #             mark = gn.note.name.to_s.ljust(2, ' ')
  #             Paint[mark, :red]
  #           else
  #             '--'
  #           end
  #           x + (fret.zero? ? '|' : ' ')
  #         end.join('')
  #       end.join("\n")

  #       special_frets = [3,5,7,9,12,15,17,19,21]
  #       visual_aids = Guitar.frets.times.map do |fret|
  #         x = if special_frets.include?(fret)
  #           Paint[fret.to_s.rjust(2, 0.to_s), :yellow]
  #         else
  #           '  '
  #         end
  #         x + ' '
  #       end.join('')

  #       [tabs, "#{visual_aids}"].join("\n")
  #     end