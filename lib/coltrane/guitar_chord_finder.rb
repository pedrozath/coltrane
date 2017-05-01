module Coltrane
  module GuitarChordFinder
    class << self
      def by_chord_name(chord_name)
        by_chord(Chord.new(chord_name))
      end

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

      def chords_for_region(region, notes:, g_strings:)
        gnotes = notes.reduce([]) do |memo_1, note|
          memo_1 + g_strings.reduce([]) do |memo_2, gs|
            memo_2 + gs.guitar_notes_for_note_in_region(note, region)
          end
        end
        combine_gnotes_into_chords(gnotes)
      end

      def combine_gnotes_into_chords(gnotes_left, chord_notes=[])
        if gnotes_left.empty?
          return [GuitarChord.new_from_notes(chord_notes)]
        else
          note = gnotes_left.map(&:note).first

          gnotes_to_search = gnotes_left.dup.delete_if do |g|
            g.note.name != note.name
          end

          chords = []

          gnotes_to_search.each do |gnote|
            new_gnl = gnotes_left.dup.delete_if do |g|
              g.note.name == gnote.note.name ||
              g.guitar_string_index == gnote.guitar_string_index
            end

            chords += combine_gnotes_into_chords(new_gnl, chord_notes + [gnote])
          end

          return chords.compact
        end
      end

      def possible_regions(chord)
        chord.notes.each_with_object([]) do |note, regions|
          note.guitar_notes.map(&:fret).each do |fret|
            regions << ((fret-2)..(fret+5))
          end
        end.uniq
      end

    end
  end
end