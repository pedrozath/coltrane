module Coltrane
  # It describes a set of notes
  class NoteSet
    extend Forwardable

    def_delegators :@notes, :first, :each, :size, :map, :reduce, :[]

    attr_reader :notes

    alias_method :root, :first
    alias_method :all, :notes

    def self.[](*notes)
      new(*notes)
    end

    def initialize(*notes)
      if notes[0].is_a?(NoteSet)
         @notes = notes[0].all
      elsif notes.detect {|a| a.class == String}
        @notes = NoteSet.new *notes.map {|n| Note.new(n) if n.is_a?(String) }
      else
        @notes = notes
      end
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

    def guitar_notes
      GuitarNoteSet.new(notes.map(&:guitar_notes).flatten)
    end

    def interval_sequence
      IntervalSequence.new(notes: self)
    end

    protected

    def notes_from_note_array(note_array)
      note_array.collect do |note|
        case note
        when String then Note.new(note)
        when Note   then note
        end
      end
    end
  end
end