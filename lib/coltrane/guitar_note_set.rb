class GuitarNoteSet
  attr_reader :guitar_notes

  def initialize(arg)
    arg = [arg] unless arg.class == Array
    @guitar_notes = arg.reduce([]) do |memo, arg_item|
      case arg_item
        when Hash       then memo + [GuitarNote.new(arg_item)]
        when GuitarNote then memo + [guitar_note]
        when Pitch      then memo + guitar_notes_for_pitch(arg_item)
        when String     then memo + guitar_notes_for_pitch(Pitch.new(arg_item))
      end
    end
  end

  def guitar_notes_for_pitch(pitch)
    Guitar.strings.each_with_index.reduce([]) do |memo, object|
      guitar_string, index = object
      fret = guitar_string.fret_by_pitch(pitch)
      memo << GuitarNote.new(guitar_string_index: index, fret: fret) unless fret.nil?
      memo
    end
  end

  def notes
    guitar_notes.collect(&:note)
  end

  def note_string
    notes.join(' ')
  end

  def chord_quality
    ChordQuality.from_notes(note_string)
  end
end
