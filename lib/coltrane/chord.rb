class Chord
  attr_reader :root_note, :quality

  def initialize(arg)
    @root_note, @quality = case arg
                           when String then note_and_quality_from_name(arg)
                           when GuitarChord then [arg.root_note, arg.chord_quality]
    end
  end

  def guitar_chords
    root_note.guitar_notes.collect(&:guitar_notes).map do |guitar_note|
      guitar_note.guitar_chord(quality)
    end
  end

  def name
    "#{root_note.name}#{quality.name}"
  end

  protected

  def note_and_quality_from_name(chord_name)
    possible_notes = Note::NOTES.keys.join('|')
    chord, name, quality = chord_name.match(/(#{possible_notes})(.*)/).to_a
    [Note.new(name), ChordQuality.new_from_string(quality)]
  end
end
