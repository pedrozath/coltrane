module Coltrane
  # It describes a guitar string
  class GuitarString
    attr_reader :pitch

    def initialize(pitch)
      @pitch = Pitch.new(pitch)
    end

    def fret_by_pitch(pitch)
      pitch = Pitch.new(pitch) if pitch.class != Pitch
      fret = pitch.number - @pitch.number
      fret if fret >= 0
    end

    def pitch_by_fret(fret)
      Pitch.new(pitch.number + fret)
    end

    def guitar_notes_for_note(note)
      pitches_for_note(note).map do |pitch|
        GuitarNote.new(fret: fret_by_pitch(pitch),
                       guitar_string_index: index)
      end
    end

    def guitar_notes_for_note_in_region(note, region)
      pitches_for_note(note).each_with_object([]) do |pitch, memo|
        fret = fret_by_pitch(pitch)
        if region.include?(fret) || fret == 0
          memo << GuitarNote.new(fret: fret, guitar_string_index: index)
        end
      end
    end

    def index
      Guitar.strings.index { |string| string.pitch.number == self.pitch.number }
    end

    def pitches_for_note(note)
      pitches.each_with_object([]) do |pitch, memo|
        memo << pitch if pitch.note.name == note.name
      end
    end

    def pitches
      Guitar.frets.times.map do |fret|
        pitch_by_fret(fret)
      end
    end
  end
end