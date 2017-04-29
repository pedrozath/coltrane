class GuitarNote
  attr_reader :position

  def initialize(fret:, guitar_string_index:)
    @position = { fret: fret, guitar_string_index: guitar_string_index }
  end

  def new_from_guitar_string_and_note(gsi, note); end

  def note
    pitch.note
  end

  def guitar_string_index
    position[:guitar_string_index]
  end

  def guitar_string
    Guitar.strings[guitar_string_index]
  end

  def fret
    position[:fret]
  end

  def pitch
    Pitch.new(guitar_string.pitch.number + fret)
  end

  def guitar_chord(_quality)
    GuitarChord.new (guitar_string_index..0).inject([]) do |memo, gsi|
      if f < Guitar.frets
        gn = new_from_guitar_string_and_note(gsi, note)
        memo << gn unless gn.nil?
      end
      memo
    end
  end
end
