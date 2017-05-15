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

    def self.all
      NOTES.keys.map {|n| Note.new(n)}
    end

    def accident?
      [1,3,6,8,10].include?(number)
    end

    def initialize(arg)
      case arg
      when String
        raise "invalid note: #{arg}" unless valid_note?(arg)
        @name = arg
      when Numeric then @name = name_from_number(arg)
      end
    end

    def +(n)
      case n
        when Numeric then Note.new(number + n)
        when Note then Chord.new(number + n.number)
      end
    end

    def -(n)
      case n
        when Numeric then Note.new(number + n)
        when Note then Interval.new((number - n.number) % 12)
      end
    end

    def valid_note?(note_name)
      NOTES.key?(note_name)
    end

    def number
      NOTES[name]
    end

    def interval_to(note_name)
      Interval.new(Note.new(note_name).number - number)
    end

    def transpose_by(interval_number)
      @name = name_from_number(number + interval_number)
      self
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

    protected

    def name_from_number(number)
      NOTES.key(number % 12)
    end
  end
end