module Coltrane
  module GuitarChordFinder
    class << self
      def by_chord(chord)
        chords_for_regions notes: chord.notes,
                           regions: possible_regions(chord)
      end

      def chords_for_regions(notes:, regions:)
        regions.reduce([]) do |chords, region|
          chords + chords_for_region(region, notes: notes,
                                             g_strings: Guitar.strings)
        end
      end

      def chords_for_region(region, notes:, g_notes:[], g_strings:, chords:[])
        return (chords + [GuitarChord.new_from_notes(g_notes)]) if notes.empty?
        s = g_strings.first
        n = notes.shift
        g_strings.reduce([]) do |memo_1, gs|
          found = gs.guitar_notes_for_note_in_region(n, region)
          memo_1 + found.reduce([]) do |memo_2, gn|
            memo_2 + chords_for_region(region, g_notes:   (g_notes   + [gn]),
                                                g_strings: (g_strings - [gs]),
                                                notes:     notes,
                                                chords:    chords)
          end
        end
      end

      def possible_regions(chord)
        chord.notes.each_with_object([]) do |note, regions|
          note.guitar_notes.map(&:fret).each do |fret|
            regions << ((fret-2)..(fret+5))
          end
        end
      end

    end
  end
end