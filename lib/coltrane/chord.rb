class Chord
  attr_reader :pitches

  def initialize(arg)
    @pitches = case arg
      when GuitarNoteSet then arg.guitar_notes.collect(&:pitch)
    end
  end

  def root_note
    pitches.sort_by(&:number).first.note
  end

  def quality
    quality = ChordQuality.new_from_pitches(*pitches).name
  end

  def name
    "#{root_note.name}#{quality}"
  end
end