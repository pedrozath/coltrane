class Chord
  attr_reader :pitches

  def initialize(arg)
    @pitches = case arg
      when GuitarNoteSet then arg.guitar_notes.collect(&:pitch)
    end
  end

  def root_note
    pitches.first.class
  end

  def quality
    quality = ChordQuality.from_pitches(pitches)
  end

  def name
    "#{root_note}#{quality}"
  end
end