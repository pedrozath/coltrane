module Coltrane
  # It describes a guitar note
  class GuitarNote
    attr_reader :position

    def initialize(fret:, guitar_string_index:)
      if fret.nil? || guitar_string_index.nil?
        raise "invalid guitar note for f:#{fret} and s:#{guitar_string_index}"
      end
      @position = { fret: fret, guitar_string_index: guitar_string_index }
    end

    def new_from_guitar_string_and_note(gsi, note); end

    def note
      pitch.note
    end

    def guitar_string_index
      position[:guitar_string_index]
    end

    def fret
      position[:fret]
    end

    def guitar_string
      Guitar.strings[guitar_string_index]
    end

    def pitch
      Pitch.new(guitar_string.pitch.number + fret)
    end

    def guitar_chord(_quality)
      guitar_strings    = (guitar_string_index..0).to_a
      guitar_note_array = guitar_strings.each_with_object([]) do |gsi, memo|
        if f < Guitar.frets
          gn = new_from_guitar_string_and_note(gsi, note)
          memo << gn unless gn.nil?
        end
      end
      GuitarChord.new(guitar_note_array)
    end
  end
end