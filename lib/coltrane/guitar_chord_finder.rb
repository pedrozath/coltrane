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
        gnotes = gnotes_for_chord(chord.notes)
        gnotes_to_start = gnotes.dup.delete_if { |g| g.fret.zero? }
        frets  = gnotes.map(&:fret)
        gnotes_count = gnotes.count
        chords = gnotes_to_start.reduce([]) do |memo, gnote_to_start|
          puts "#{gnotes_count - i} left"
          gnotes_to_work_with = gnotes.dup
          gnotes_to_work_with.delete_if do |gnote|
            distance = gnote.fret - gnote_to_start.fret
            !distance.between?(0,4) && !gnote.fret.zero?
          end
          memo # + combine_gnotes_into_chords(gnotes_to_work_with)
        end
        chords = remove_duplicate_chords(chords)
        chords.sort_by do |c|
          frets = c.frets_in_sequence
          frets.count(0)*10 -c.guitar_notes.count + c.frets.last
        end
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
          # if repeat_notes
          #   gnotes_to_search = gnotes_left.dup
          # else
          #   note = gnotes_left.map(&:note).first
          #   gnotes_to_search = gnotes_left.dup.delete_if do |g|
          #                        g.note.name != note.name
          #                      end
          # end

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
