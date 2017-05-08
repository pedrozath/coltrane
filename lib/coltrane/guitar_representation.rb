require 'paint'

module GuitarRepresentation
  class << self
    def render(guitar_notes, ref_note=nil)
      gns = guitar_notes.guitar_notes.map(&:position)
      tabs = Guitar.strings.map do |string|
        Guitar.frets.times.map.each do |fret|
          position = { guitar_string_index: string.index, fret: fret }
          present = gns.include?(position)
          x = if present
            gn = GuitarNote.new(position)
            mark = ref_note ? (gn.note - ref_note).name : '◼︎◼︎'
            Paint[mark, :red]
          else
            '--'
          end
          x + (fret.zero? ? '|' : ' ')
        end.join('')
      end.join("\n")

      special_frets = [3,5,7,9,12,15,17,19,21]
      visual_aids = Guitar.frets.times.map do |fret|
        x = if special_frets.include?(fret)
          Paint[fret.to_s.rjust(2, 0.to_s), :yellow]
        else
          '  '
        end
        x + ' '
      end.join('')

      [tabs, "#{visual_aids}"].join("\n")
    end

    def render_degrees(guitar_notes, ref_scale)
      gns = guitar_notes.guitar_notes.map(&:position)
      tabs = Guitar.strings.map do |string|
        Guitar.frets.times.map.each do |fret|
          position = { guitar_string_index: string.index, fret: fret }
          present = gns.include?(position)
          x = if present
            gn = GuitarNote.new(position)
            mark = ref_scale.degree_of_note(gn.note).to_s.rjust(2, 0.to_s)
            Paint[mark, :red]
          else
            '--'
          end
          x + (fret.zero? ? '|' : ' ')
        end.join('')
      end.join("\n")

      special_frets = [3,5,7,9,12,15,17,19,21]
      visual_aids = Guitar.frets.times.map do |fret|
        x = if special_frets.include?(fret)
          Paint[fret.to_s.rjust(2, 0.to_s), :yellow]
        else
          '  '
        end
        x + ' '
      end.join('')

      [tabs, "#{visual_aids}"].join("\n")
    end
  end
end