class Pitch
  attr_reader :number

  def initialize(pitch)
    case pitch
    when String  then @number = number_from_name(pitch)
    when Numeric then @number = pitch
    when Pitch   then @number = pitch.number
    end
  end

  def number_from_name(pitch_string)
    pitch, note, octaves = pitch_string.match(/(.*)(\d)/).to_a
    Note.new(note).number + 12 * octaves.to_i
  end

  def name
    "#{note.name}#{number / 12}"
  end

  def note
    Note.new(number)
  end
end
