# frozen_string_literal: true

module Coltrane
  module Representation
    class Guitar
      # This class represents a group of guitar notes, strummed at the same time
      class Chord
        include Comparable
        attr_reader :guitar_notes, :guitar, :free_fingers, :target_chord, :barre

        MAX_FRET_SPAN = 3

        def self.find(chord, guitar:)
          new(chord, guitar: guitar)
          .fetch_descendant_chords
          .sort
          .reverse
        end

        def self.find_by_notation(guitar, chord_notation)
          chord_notation
          .split('-')
          .map
          .with_index do |n, i|
            next if n == 'x'
            n = Guitar::Note.new(guitar.strings[i], n.to_i).pitch.pitch_class
          end
          .yield_self do |notes|
            notes
            .map
            .with_index do |note, index|
              begin
                Theory::Chord.new(notes: notes.rotate(index))
              rescue Theory::ChordNotFoundError
                next
              end
            end
            .compact
            .yield_self do |chords|
              raise(Theory::ChordNotFoundError) if chords.empty?
              chords.compact.uniq &:name
            end
          end
        end

        def initialize(target_chord,
                       guitar_notes: [],
                       free_fingers: 4,
                       barre: nil,
                       guitar:)

          @target_chord = target_chord
          @guitar_notes = guitar_notes
          @free_fingers = free_fingers
          @guitar       = guitar
          @barre        = barre
        end

        def max_fret_span
          MAX_FRET_SPAN
        end

        def <=>(other)
          rank <=> other.rank
        end

        def rank
          +completeness  * 10_000 +
          +fullness      * 1_000 +
          -spreadness    * 10 +
          -discontinuity * 1 +
          +easyness      * 1
        end

        def analysis
          %i[completeness discontinuity fullness spreadness easyness]
          .reduce({}) do |output, criteria|
            output.merge(criteria => send(criteria).round(2))
          end
          .merge(rank: rank.round(4))
        end

        def spreadness
          fret_range.size.to_f / MAX_FRET_SPAN
        end

        def completeness
          (target_chord.notes.size.to_f - notes_left.size) / target_chord.notes.size
        end

        def easyness
          frets.count(0).to_f / guitar_notes.size
        end

        def fullness
          (guitar.strings.size.to_f - frets.count(nil)) / guitar.strings.size
        end

        def discontinuity
          voicing.discontinuity
        end

        def barre?
          !@barre.nil?
        end

        def fetch_descendant_chords
          return [self] if guitar_notes.size >= guitar.strings.size
          possible_new_notes(notes_available.positive?).reduce([]) do |memo, n|
            barre = n.fret if guitar_notes.last == n.fret
            fingers_change = n.fret == barre || n.fret.zero? ? 0 : 1
            next memo if (free_fingers - fingers_change).negative?
            self.class.new(target_chord,
              guitar_notes: guitar_notes + [n],
              free_fingers: free_fingers - fingers_change,
              guitar: guitar,
              barre: barre
            ).fetch_descendant_chords + memo
          end
        end

        def notes_available
          strings_available - notes_left.size
        end

        def strings_available
          guitar.strings.size - guitar_notes.size
        end

        def notes_left
          @notes_left ||= begin
                            target_chord.notes - Theory::NoteSet[
                            *guitar_notes.map do |n|
                              next if n.pitch.nil?
                              n.pitch.pitch_class
                            end
                          ]
                          end
        end

        def target_notes
          notes_left.any? ? notes_left : target_chord.notes
        end

        def notes
          guitar_notes.map(&:pitch)
        end

        def frets
          @frets ||= guitar_notes.map(&:fret)
        end

        def non_zero_frets
          frets.reject { |f| f.nil? || f.zero? }
        end

        def lowest_fret
          non_zero_frets.any? ? non_zero_frets.min : 0
        end

        def highest_fret
          non_zero_frets.max || 0
        end

        def fret_range
          (lowest_fret..highest_fret)
        end

        def lowest_possible_fret
          lowest_fret.zero? ? 0 : [(lowest_fret - possible_span), 0].max
        end

        def highest_possible_fret
          [(possible_span + (highest_fret == 0 ? guitar.frets : highest_fret)), guitar.frets].min
        end

        def possible_span
          MAX_FRET_SPAN - fret_range.size
        end

        def fret_expansion_range
          (lowest_possible_fret..highest_possible_fret).to_a +
            [(0 unless barre?)].compact
        end

        def to_s(debug = false)
          guitar_notes.map {
            |n| n.fret.nil? ? 'x' : n.fret
          }.join('-') + (debug ? ' ' + analysis.to_s : '')
        end

        def voicing
          Theory::Voicing.new(pitches: guitar_notes.map(&:pitch).compact)
        end

        private

        attr_writer :barre

        def next_string
          guitar.strings[guitar_notes.size]
        end

        def possible_new_notes(include_mute_note = false)
          target_notes.notes.map do |note|
            next_string.find(note, possible_frets: fret_expansion_range)
          end.flatten + [(Guitar::Note.new(next_string, nil) if include_mute_note)].compact
        end
      end
    end
  end
end
