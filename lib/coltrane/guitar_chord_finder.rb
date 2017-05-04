require 'digest'

module Coltrane
  module GuitarChordFinder
    class << self
      def by_chord_name(chord_name)
        x = by_chord(Chord.new(chord_name))
      end

      def by_chord(chord)
        chords = chords_for_regions notes: chord.notes,
                                    regions: possible_regions(chord)
      end

      def chords_for_regions(notes:, regions:)
        regions.reduce([]) do |chords, region|
          gnotes = gnotes_for_region(region, notes: notes,
                                             g_strings: Guitar.strings)
          chords + combine_gnotes_into_chords(gnotes)
        end
      end

      def gnotes_for_region(region, notes:, g_strings:)
        gnotes = notes.reduce([]) do |memo_1, note|
          memo_1 + g_strings.reduce([]) do |memo_2, gs|
            memo_2 + gs.guitar_notes_for_note_in_region(note, region)
          end
        end
      end

      def combine_gnotes_into_chords(gnotes_left,
                                     chord_notes=[],
                                     repeat_notes: false,
                                     color_gnotes: [])

        if gnotes_left.empty?
          if !color_gnotes.empty? && chord_notes.size < 6
            combine_gnotes_into_chords color_gnotes.uniq,
                                       chord_notes,
                                       repeat_notes: true
          else
            [GuitarChord.new_from_notes(chord_notes)]
          end
        else
          note = gnotes_left.map(&:note).first
          if repeat_notes
            gnotes_to_search = gnotes_left.dup
          else
            gnotes_to_search = gnotes_left.dup.delete_if do |g|
                               g.note.name != note.name
                             end
          end

          chords = []
          gnotes_to_search.each do |gnote|
            new_gnl = gnotes_left.dup
            new_gnl.delete_if do |g|
              g.guitar_string_index == gnote.guitar_string_index
            end

            if repeat_notes
              new_gnl.delete(gnote)
            else
              new_gnl.delete_if do |g|
                if g.note.name == gnote.note.name
                  color_gnotes << gnote
                  true
                end
              end
            end

            chords += combine_gnotes_into_chords new_gnl,
                                                 chord_notes + [gnote],
                                                 repeat_notes: repeat_notes,
                                                 color_gnotes: color_gnotes.uniq
          end

          return chords.compact
        end
      end

      def possible_regions(chord)
        chord.notes.each_with_object([]) do |note, regions|
          note.guitar_notes.map(&:fret).each do |fret|
            regions << ((fret)..(fret+4)) if fret < 15
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
    end
  end
end