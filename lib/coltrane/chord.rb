# frozen_string_literal: true

module Coltrane
  # It describe a chord
  class Chord < NoteSet
    attr_reader :root_note, :quality, :notes

    def initialize(notes: nil, root_note: nil, quality: nil, name: nil)
      if !notes.nil?
        notes      = NoteSet[*notes] if notes.is_a?(Array)
        @notes     = notes
        @root_note = notes.first
        @quality   = ChordQuality.new(notes: notes)
      elsif !root_note.nil? && !quality.nil?
        @notes     = quality.notes_for(root_note)
        @root_note = root_note
        @quality   = quality
      elsif !name.nil?
        @root_note, @quality, @notes = parse_from_name(name)
      else
        raise WrongKeywordsError, '[notes:] || [root_note:, quality:] || [name:]'
      end
    end

    def name
      return @notes.names.join('/') unless named?
      "#{root_note.name}#{quality.name}"
    end

    def pretty_name
      return @notes.names.join('/') unless named?
      "#{root_note.pretty_name}#{quality.name}"
    end

    def named?
      notes.size >= 3 &&
        !root_note.nil? &&
        !quality&.name.nil?
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

    protected

    def parse_from_name(name)
      _, name, quality_name = name.match(/([A-Z](?:#|b)?)(.*)/).to_a
      root    = Note[name]
      quality = ChordQuality.new(name: quality_name)
      notes   = quality.notes_for(root)
      [root, quality, notes]
    end
  end
end
