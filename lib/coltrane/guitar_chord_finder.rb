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
        guitar_notes = notes.reduce([]) do |memo_1, note|
          memo_1 + g_strings.reduce([]) do |memo_2, gs|
            memo_2 + gs.guitar_notes_for_note_in_region(note, region)
          end
        end
        combine_gnotes_into_chords(hashify_gnotes(guitar_notes))
      end

      def combine_gnotes_into_chords(hash, chord_notes=[], chords=[])
        hash.each do |note, strings|
          strings.each do |string, guitar_notes|
            guitar_notes.each do |guitar_note|
              hash = delete_note_in_hash(hash, note)
              hash = delete_string_in_hash(hash, string)
              chord_notes << guitar_note
              if hash.empty?
                chords << GuitarChord.new_from_notes(chord_notes)
              else
                chords = combine_gnotes_into_chords(hash, chord_notes, chords)
              end
            end
          end
        end
        chords
      end

      def delete_note_in_hash(hash, note)
        hash.delete(note)
        return hash
      end

      def delete_string_in_hash(hash, string)
        hash.each do |note, strings|
          hash[note].delete(string)
        end
        return hash
      end

      def hashify_gnotes(guitar_notes)
        guitar_notes.each_with_object({}) do |g, memo|
          memo[g.note.name] ||= {}
          memo[g.note.name][g.guitar_string_index] ||= []
          memo[g.note.name][g.guitar_string_index] << g
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