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
      raise "invalid note: #{arg}" unless valid_note?(arg)
      @name = arg
    when Numeric then @name = name_from_number(arg)
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

  def pitches; end

  protected

  def name_from_number(number)
    NOTES.key(number % 12)
  end
end
