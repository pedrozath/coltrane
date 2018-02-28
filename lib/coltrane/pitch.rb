# frozen_string_literal: true

module Coltrane
  # It describes a pitch, like E4 or Bb5. It's like a note, but it has an octave
  class Pitch
    attr_reader :integer

    def initialize(notation_arg = nil,
                   note: nil,
                   octave: nil,
                   notation: nil,
                   frequency: nil)

      @integer = begin
        if (n = notation_arg || notation)
          n.is_a?(Integer) ? n : integer_from_notation(n)
        elsif note && octave
          integer_from_note_and_octave(Note[note], octave)
        elsif frequency
          integer_from_frequency(frequency)
        else
          raise(InvalidArgumentsError)
        end
      end
    end

    def self.[](*args)
      new *args
    end

    def scientific_notation
      "#{pitch_class}#{octave}"
    end

    def pitch_class
      PitchClass[integer]
    end

    def octave
      (integer / 12) - 1
    end

    alias notation scientific_notation
    alias name     scientific_notation
    alias to_s     scientific_notation

    alias hash integer
    alias midi integer

    def ==(other)
      integer == other.integer
    end

    def frequency
      pitch_class.frequency.octave(octave)
    end

    alias eql? ==
    alias eq ==

    def +(other)
      case other
      when Integer then Pitch[integer + other]
      end
    end

    def -(other)
      case other
      when Integer then Pitch[integer - other]
      end
    end

    private

    def integer_from_notation(the_notation)
      _, n, o = *the_notation.match(/(\D+)(\d+)/)
      integer_from_note_and_octave(Note[n], o)
    end

    def integer_from_note_and_octave(p, o)
      12 * (o.to_i + 1) + p.integer
    end

    def integer_from_frequency(f)
      octave_from_frequency(f) * 12 + PitchClass[f].integer
    end

    def octave_from_frequency(f)
      Math.log(f.to_f / PitchClass['C'].frequency.to_f, 2).ceil
    end
  end
end
