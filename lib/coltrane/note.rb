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
  }

  def initialize(arg)
    case arg
      when String  then @name = arg
      when Numeric then @name = name_from_number(arg)
    end
  end

  def number
    NOTES[name]
  end

  def interval_to(note)
    Interval.new(Note.new(note).number - number)
  end

  def transpose_by(interval_number)
    @name = name_from_number(number + interval_number)
    return self
  end

  protected

  def name_from_number(number)
    NOTES.key(number % 12)
  end
end