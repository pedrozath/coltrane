module Coltrane
  module GuitarChordFinder
    class << self
      def by_chord(chord)
        chords_for_regions notes: chord.notes,
                           regions: possible_regions(chord)
      end

      def chords_for_regions(notes:, regions:, chords:[])
        return chords if regions.empty?

        chords_for_region regions.pop, notes: notes,
                                       g_strings: Guitar.strings

        chords_for_regions notes: notes,
                           regions: regions,
                           chords: chords
      end

      def chords_for_region(region, notes:, g_notes:[], g_strings:, chords:[])
        return (chords + [g_notes]) if notes.empty?
        return chords if g_strings.empty?

        s = g_strings.first
        n = notes.shift
        g_strings.each_with_object([]) do |g_string, memo|
          g_string.guitar_notes_for_note_in_region(n, region).each do |g|
            memo + chords_for_region(region, g_notes:   (g_notes   + [g]),
                                              g_strings: (g_strings - [s]),
                                              notes:     notes,
                                              chords:    chords)
          end
        end
      end

      # def chords_in_region(region, notes:, strings:, guitar_notes:[], chords:[])
      #   return GuitarChord.new_from_notes(notes) if (notes.empty? || strings.empty?)
      #   found_notes = notes.first.in_guitar_string_region(strings.first, region)
      #   if found_notes.size > 0
      #     found_notes.map do |found_note|
      #       chords_in_region region, notes: (notes - [found_note]),
      #                                strings: (strings - [strings.first]),
      #                                chords: chords,
      #                                guitar_notes: guitar_notes + [found_note]
      #     end
      #   else
      #     chords_in_region region, notes: notes,
      #                              strings: (strings - [strings.first]),
      #                              chords: chords,
      #                              guitar_notes: guitar_notes
      #   end
      # end

      def possible_regions(chord)
        chord.notes.each_with_object([]) do |note, regions|
          note.guitar_notes.map(&:fret).each do |fret|
            regions << ((fret-2)..(fret+5))
          end
        end
      end

      # def chords_in_region(notes:, region:, guitar_strings: Guitar.strings, chords:[])
      #   if notes.empty?
      #     guitar_notes
      #   else
      #     chords_in_region notes: notes,
      #                      region: region,
      #                      guitar_notes: guitar_notes,
      #                      guitar_strings: guitar_strings
      #   end
      # end

      #   Guitar.strings.each do |string|
      #     essential_notes.each do |note|
      #       string.guitar_notes_for_note(note).each do |guitar_notes|
      #         chord = [found_note]

      #       end
      #     end
      #   end
      # end
    end
  end
end