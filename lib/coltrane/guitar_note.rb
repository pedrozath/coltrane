class GuitarNote
  attr_reader :position

  def initialize(fret:, guitar_string_index:)
    @position = { fret: fret, guitar_string_index: guitar_string_index}
  end

  def note
    Pitch.note.name
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
end