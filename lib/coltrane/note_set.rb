module Coltrane
  # It describes a set of notes
  class NoteSet
    extend Forwardable

    def_delegators :@notes, :first, :each, :size, :map, :reduce, :index,
                   :[], :index, :empty?, :permutation, :include?

    attr_reader :notes

    alias_method :root, :first
    alias_method :all, :notes

    def self.[](*notes)
      new(notes)
    end

    def initialize(arg)
      @notes =
        case arg
        when NoteSet then arg.notes
        when Array   then arg.map {|n| n.is_a?(Note) ? n : Note[n] }
        else raise InvalidNotes.new(arg)
        end
    end

    def &(another)
      NoteSet[*(notes & another.notes)]
    end

    def degree(note)
      index(note)+1
    end

    def +(other_noteset)
      NoteSet[*(notes + other_noteset.notes)]
    end

    def pretty_names
      map(&:pretty_name)
    end

    def names
      map(&:name)
    end

    def transpose_to(note_name)
      transpose_by(root_note.interval_to(note_name).number)
    end

    def transpose_by(interval)
      notes.map do |note|
        note.transpose_by(interval)
      end
    end

    def interval_sequence
      IntervalSequence.new(notes: self)
    end
  end
end