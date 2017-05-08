require 'digest'

module Coltrane
  module GuitarChordFinder
    class << self
      # TODO Refactor this piece of shit
      def by_chord_name(chord_name)
        by_chord(Chord.new(chord_name))
      end

      def by_chord(chord)
        gnotes = gnotes_for_chord(chord.notes)
        frets = gnotes.map(&:fret).uniq.sort
        frets.delete(0)
        threads = []
        frets.each do |fret|
          threads << Thread.new do
            gnotes_for_fret = gnotes.dup.delete_if do |gnote|
              !(gnote.fret-fret).between?(0,4) && !gnote.fret.zero?
            end

            gnotes_to_start_with = gnotes_for_fret.dup.delete_if do |gnote|
              gnote.fret != fret
            end

            gnotes_to_start_with.reduce([]) do |memo2, gnote|
              gnotes_for_fret.delete(gnote)
              memo2 + combine_gnotes_into_chords( gnotes_for_fret, [gnote])
            end
          end
        end
        chords = threads.map(&:value).flatten
        remove_duplicate_chords(chords)
      end

      def gnotes_for_chord(notes)
        gnotes = notes.reduce([]) do |memo_1, note|
          memo_1 + Guitar.strings.reduce([]) do |memo_2, gs|
            memo_2 + gs.guitar_notes_for_note_in_region(note, 0..12)
          end
        end
      end

      def combine_gnotes_into_chords(gnotes_left,
                                     chord_notes=[],
                                     repeat_notes: false,
                                     color_gnotes: [])

        if chord_notes.size == 6
          return [GuitarChord.new_from_notes(chord_notes)]
        elsif gnotes_left.empty?
          if color_gnotes.empty?
            return [GuitarChord.new_from_notes(chord_notes)]
          else
            return combine_gnotes_into_chords color_gnotes.uniq,
                                       chord_notes,
                                       repeat_notes: true
          end
        else

          chords = []

          gnotes_left.each do |gnote|
            new_chord_notes = chord_notes + [gnote]
            new_gnl = gnotes_left.dup
            new_gnl.delete(gnote)
            new_gnl.delete_if do |g|
              next(true) if g.guitar_string_index == gnote.guitar_string_index
              if g.note.name == gnote.note.name && !repeat_notes
                color_gnotes << g
                next(true)
              end
            end

            chords += combine_gnotes_into_chords new_gnl,
                                                 new_chord_notes,
                                                 repeat_notes: repeat_notes,
                                                 color_gnotes: color_gnotes.uniq
          end

          return chords.compact
        end
      end

      def remove_duplicate_chords(chords)
        chords_to_include = chords.map(&:to_s).uniq
        chords.each_with_object [] do |chord, new_chords|
          chord_str = chord.to_s
          if chords_to_include.include?(chord_str)
            chords_to_include.delete(chord_str)
            new_chords << chord
          end
        end
      end

    end
  end
end
