# frozen_string_literal: true

module Coltrane
  # It describe a chord

  class Chord
    attr_reader :root_note, :quality, :notes
    include ChordSubstitutions

    def initialize(notes: nil, root_note: nil, quality: nil, name: nil)
      if notes
        notes      = NoteSet[*notes] if notes.is_a?(Array)
        @notes     = notes
        @root_note = notes.first
        @quality   = ChordQuality.new(notes: notes)
      elsif root_note && quality
        @notes     = quality.notes_for(root_note)
        @root_note = root_note
        @quality   = quality
      elsif name
        @root_note, @quality, @notes = parse_from_name(name)
      else
        raise WrongKeywordsError,
              '[notes:] || [root_note:, quality:] || [name:]'
      end
    end

    def name
      "#{root_note}#{quality}"
    end

    alias to_s name

    def pretty_name
      "#{root_note.pretty_name}#{quality.name}"
    end

    def intervals
      IntervalSequence.new(NoteSet.new(notes))
    end

    def size
      notes.size
    end

    def scales
      Scale.having_chord(name)
    end

    def next_inversion
      Chord.new(notes.rotate(1))
    end

    def invert(n = 1)
      Chord.new(notes.rotate(n))
    end

    def previous_inversion
      Chord.new(notes.rotate(-1))
    end

    def +(other)
      case other
      when Note, NoteSet, Interval then Chord.new(notes: notes + other)
      when Chord then Chord.new(notes: notes + other.notes)
      end
    end

    def -(other)
      case other
      when Note, NoteSet, Interval, Numeric then Chord.new(notes: notes - other)
      when Chord then Chord.new(notes: notes - other.notes)
      end
    end

    protected

    def parse_from_name(name)
      chord_name, bass = name.match?(/\/9/) ? [name, nil] : name.split('/')
      chord_regex = /([A-Z](?:#|b)?)(.*)/
      _, root_name, quality_name = chord_name.match(chord_regex).to_a
      root    = Note[root_name]
      quality = ChordQuality.new(name: quality_name, bass: bass)
      notes   = quality.notes_for(root)
      notes << Note[bass] unless bass.nil?
      [root, quality, notes]
    end
  end
end
