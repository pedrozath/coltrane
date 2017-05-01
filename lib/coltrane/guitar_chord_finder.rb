module Coltrane
  module GuitarChordFinder
    class << self
      def by_chord_name(chord_name)
        by_chord(Chord.new(chord_name))
      end

      def by_chord(chord)
        chords = chords_for_regions notes: chord.notes,
                                    regions: possible_regions(chord)
        chords = remove_duplicate_chords(chords)
        chords = colorize_chords(chords)
        remove_duplicate_chords(chords)
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
        essential_chords = combine_gnotes_into_chords(gnotes)
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

      def remove_duplicate_chords(chords)
        chords_strings = chords.map(&:to_s)
        chords.each_with_index do |chord, index|
          if chords_strings[index].count(chord.to_s) > 1
            puts chords.delete_at(index)
            chords_strings.delete_at(index)
          end
        end
        chords
      end

      def colorize_chords(chords)
        chords.reduce([]) do |memo, chord|
          memo + colorize_chord(chord)
        end
      end

      def colorize_chord(chord)
        [chord]
      end
    end
  end
end