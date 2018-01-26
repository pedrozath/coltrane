module Coltrane
  # It describes a musical note, independent of octave
  class Note
    attr_reader :name

    NOTES = {
      'C'  => 0,
      'C#' => 1,
      'Db' => 1,
      'D'  => 2,
      'D#' => 3,
      'Eb' => 3,
      'E'  => 4,
      'F'  => 5,
      'F#' => 6,
      'Gb' => 6,
      'G'  => 7,
      'G#' => 8,
      'Ab' => 8,
      'A'  => 9,
      'A#' => 10,
      'Bb' => 10,
      'B'  => 11
    }.freeze

    def initialize(arg)
      case arg
      when String
        raise "invalid note: #{arg}" unless (note=find_note(arg))
        @name = note
      when Numeric then @name = NOTES.key(arg % 12)
      end
    end

    def self.all
      NOTES.keys.map {|n| Note.new(n)}
    end

    def eq?(note)
      number == note.number
    end

    def accident?
      [1,3,6,8,10].include?(number)
    end

    def find_note(str)
      NOTES.each do |k, v|
        return k if str.casecmp?(k)
      end
      nil
    end

    def +(n)
      case n
        when Interval then Note.new(number + n.semitones)
        when Numeric  then Note.new(number + n)
        when Note     then Chord.new(number + n.number)
      end
    end

    def -(n)
      case n
        when Numeric then Note.new(n - number)
        when Note    then Interval.new(n.number - number)
      end
    end

    def valid_note?(note_name)
      find_note(note_name)
    end

    def number
      NOTES[name]
    end

    def interval_to(note_name)
      Note.new(note_name) - self
    end

    def transpose_by(semitones)
      self + semitones
    end

    def guitar_notes
      Guitar.strings.reduce([]) do |memo, guitar_string|
        memo + in_guitar_string(guitar_string)
      end
    end

    def on_guitar
      GuitarNoteSet.new(guitar_notes).render
    end

    def in_guitar_string(guitar_string)
      guitar_string.guitar_notes_for_note(self)
    end

    def in_guitar_string_region(guitar_string, region)
      guitar_string.guitar_notes_for_note_in_region(self, region)
    end
  end
end