module Coltrane
  # It describes a pitch, like E4 or Bb5. It's like a note, but it has an octave
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
      _, note, octaves = pitch_string.match(/(.*)(\d)/).to_a
      Note[note].number + 12 * octaves.to_i
    end

    def name
      "#{note.name}#{octave}"
    end

    def octave
      number / 12
    end

    def note
      Note[number]
    end

    def +(arg)
      n = arg.is_a?(Pitch) ? arg.number : arg
      Pitch.new(number + n)
    end
  end
end