class NoteSet
  attr_reader :notes

  def initialize(arg)
    @notes = case arg
      when String then notes_from_note_string(arg)
      when Array  then notes_from_note_array(arg)
    end
  end

  def notes_from_note_string(note_string)
    notes_from_note_array(note_string.split(' '))
  end

  def notes_from_note_array(note_array)
    note_array.map {|n| Note.new(n)}
  end

  def transpose_to(note)
    transpose_by(root_note.interval_to(note).number)
  end

  def root_note
    notes.first
  end

  def transpose_by(interval)
    notes.map do |note|
      note.transpose_by(interval)
    end
  end
end