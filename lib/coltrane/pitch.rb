# frozen_string_literal: true

module Coltrane
  # It describes a pitch, like E4 or Bb5. It's like a note, but it has an octave
  class Pitch
    attr_reader :pitch_class, :octave

    def initialize(notation_arg = nil,
                   pitch_class: nil,
                   octave: nil,
                   notation: nil,
                   frequency: nil)

      @pitch_class, @octave =
        if notation_arg || notation
          pitch_class_and_octave_from_notation(notation_arg || notation)
        elsif pitch_class && octave
          [pitch_class, octave]
        elsif frequency
          pitch_class_and_octave_from_frequency(frequency)
        else
          raise InvalidArgumentsError
        end
    end

    private

    def pitch_class_and_octave_from_notation(name)
      pitch_class_notation, octaves = *name.match(/(.*)(\d)/)
      [PitchClass.new(pitch_class_notation), octaves.to_f]
    end

    def pitch_class_and_octave_from_frequency(frequency)
      [PitchClass[frequency], Math.log(f.to_f/TUNING, 2)/12]
    end

  #   def number_from_name(pitch_string)
  #     Note[note].number + 12 * octaves.to_i
  #   end

  #   def name
  #     "#{note.name}#{octave}"
  #   end

  #   def octave
  #     number / 12
  #   end

  #   def note
  #     Note[number]
  #   end

  #   def +(other)
  #     Pitch.new(number + (other.is_a?(Pitch) ? other.number : other))
  #   end
  # end
  end
end
