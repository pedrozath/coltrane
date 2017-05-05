require 'digest'

module Coltrane
  module GuitarChordFinder
    class << self
      # TODO Refactor this piece of shit
      def by_chord_name(chord_name)
        # @distance = nil
        x = by_chord(Chord.new(chord_name))
        puts x
        x
      end

      def by_chord(chord)
        chords = combine_gnotes_into_chords(gnotes_for_chord(chord.notes))
        chords = remove_duplicate_chords(chords)
        chords.sort_by{ |c| -c.guitar_notes.count + c.frets_in_sequence.last }
      end

      def gnotes_for_chord(notes)
        gnotes = notes.reduce([]) do |memo_1, note|
          memo_1 + Guitar.strings.reduce([]) do |memo_2, gs|
            memo_2 + gs.guitar_notes_for_note(note)
          end
        end
      end

      def combine_gnotes_into_chords(gnotes_left,
                                     chord_notes=[],
                                     repeat_notes: false,
                                     color_gnotes: [])

        if chord_notes.size == 6
          [GuitarChord.new_from_notes(chord_notes)]
        elsif gnotes_left.empty?
          if color_gnotes.empty?
            [GuitarChord.new_from_notes(chord_notes)]
          else
            combine_gnotes_into_chords color_gnotes.uniq,
                                       chord_notes,
                                       repeat_notes: true
          end
        else
          if repeat_notes
            gnotes_to_search = gnotes_left.dup
          else
            note = gnotes_left.map(&:note).first
            gnotes_to_search = gnotes_left.dup.delete_if do |g|
                                 g.note.name != note.name
                               end
          end

          unless chord_notes.empty?
            gnotes_to_search.delete_if do |g|
              first_fret = chord_notes.first.fret
              @distance = (g.fret - first_fret)
              @distance = 0 if g.fret == 0 || first_fret == 0
              next(true) unless @distance.between?(0,4)
            end
          end

          chords = []
          gnotes_to_search.each do |gnote|
            new_chord_notes = chord_notes + [gnote]
            new_gnl = gnotes_left.dup
            new_gnl.delete_if do |g|
              next(true) if g.guitar_string_index == gnote.guitar_string_index
              if repeat_notes
                next(true) if g == gnote
              elsif g.note.name == gnote.note.name
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

      def possible_regions(chord)
        chord.notes.each_with_object([]) do |note, regions|
          note.guitar_notes.map(&:fret).each do |fret|
            regions << ((fret)..(fret+3)) if fret < 11
          end
        end.uniq
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
