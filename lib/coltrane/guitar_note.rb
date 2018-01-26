module Coltrane
  # It describes a guitar note
  class GuitarNote
    attr_reader :fret, :guitar_string_pitch

    def initialize(fret:, guitar_string_pitch:)
      @fret = fret
      @guitar_string_pitch = guitar_string_pitch
    end

    def note
      pitch.note
    end

    def pitch
      Pitch.new(guitar_string_pitch + fret)
    end

    def to_s
      "string: #{guitar_string_pitch} / fret: #{fret}"
    end
  end
end