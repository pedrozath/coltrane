# frozen_string_literal: true

module Coltrane
  # It describes a set of notes
  class NoteSet
    extend Forwardable

    def_delegators :@notes, :first, :each, :size, :map, :reduce, :index,
                   :[], :index, :empty?, :permutation, :include?, :<<

    attr_reader :notes

    alias root first
    alias all notes

    def self.[](*notes)
      new(notes)
    end

    def initialize(arg)
      @notes =
        case arg
        when NoteSet then arg.notes
        when Array   then arg.map { |n| n.is_a?(Note) ? n : Note[n] }.uniq
        else raise InvalidNotesError, arg
        end
    end

    def &(other)
      NoteSet[*(notes & other.notes)]
    end

    def degree(note)
      index(note) + 1
    end

    def +(other)
      case other
      when Note then NoteSet[*(notes + [other])]
      when NoteSet then NoteSet[*notes, *other.notes]
      when Interval then NoteSet[*notes.map {|n| n + other}]
      end
    end

    def -(other)
      case other
      when NoteSet then NoteSet[*(notes - other.notes)]
      when Interval then NoteSet[*notes.map {|n| n - other}]
      end
    end

    def pretty_names
      map(&:pretty_name)
    end

    def names
      map(&:name)
    end

    def numbers
      map(&:number)
    end

    def interval_sequence
      IntervalSequence.new(notes: self)
    end
  end
end
