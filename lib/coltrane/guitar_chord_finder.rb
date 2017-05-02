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
      end

      def chords_for_regions(notes:, regions:)
        regions.reduce([]) do |chords, region|
          gnotes = gnotes_for_region(region, notes: notes,
                                             g_strings: Guitar.strings)
          essential_chords = combine_gnotes_into_chords(gnotes)

          chords + essential_chords.reduce([]) do |color_chords, essential_chord|
            color_chords + colorize_chord(essential_chord, region, gnotes)
          end
        end
      end

      def gnotes_for_region(region, notes:, g_strings:)
        gnotes = notes.reduce([]) do |memo_1, note|
          memo_1 + g_strings.reduce([]) do |memo_2, gs|
            memo_2 + gs.guitar_notes_for_note_in_region(note, region)
          end
        end
      end

      def combine_gnotes_into_chords(gnotes_left, chord_notes=[], repeat_notes: false)
        if gnotes_left.empty?
          return [GuitarChord.new_from_notes(chord_notes)]
        else
          note = gnotes_left.map(&:note).first

          gnotes_to_search = if repeat_notes
                               gns = gnotes_left.dup
                               gns.shift
                               gns
                             else
                               gnotes_left.dup.delete_if do |g|
                                 g.note.name != note.name
                               end
                             end

          chords = []

          gnotes_to_search.each do |gnote|
            new_gnl = gnotes_left.dup.delete_if do |g|
              (g.note.name == gnote.note.name && repeat_notes) ||
              g.guitar_string_index == gnote.guitar_string_index
            end

            chords += combine_gnotes_into_chords(new_gnl, chord_notes + [gnote], repeat_notes: repeat_notes)
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
            chords.delete_at(index)
            chords_strings.delete_at(index)
          end
        end
        chords
      end

      def colorize_chord(chord, region, gnotes)
        gnotes_left = gnotes.delete_if do |gnote|
          chord.guitar_notes.map(&:guitar_string_index).include?(gnote.guitar_string_index)
        end

        new_chords = combine_gnotes_into_chords gnotes_left, repeat_notes: true
        new_chords.map do |new_chord|
          x = GuitarChord.new_from_notes(chord.guitar_notes + new_chord.guitar_notes)
          puts x.to_s
          x
        end
      end
    end
  end
end