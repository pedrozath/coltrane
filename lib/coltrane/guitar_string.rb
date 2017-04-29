class GuitarString
  attr_reader :pitch

  def initialize(pitch)
    @pitch = Pitch.new(pitch)
  end

  def fret_by_pitch(pitch)
    fret = Pitch.new(pitch).number - @pitch.number
    fret if fret > 0
  end
end