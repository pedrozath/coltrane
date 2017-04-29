class NoteSet
  attr_reader :notes

  def initialize(arg)
    @notes = case arg
             when String then notes_from_note_string(arg)
             when Array  then notes_from_note_array(arg)
    end
  end

  def root_note
    notes.sort_by(&:number).first
  end

  def transpose_to(note_name)
    transpose_by(root_note.interval_to(note_name).number)
  end

  def transpose_by(interval)
    notes.map do |note|
      note.transpose_by(interval)
    end
  end

  def interval_sequence
    IntervalSequence.new(self)
  end

  protected

  def notes_from_note_string(note_string)
    notes_from_note_array(note_string.split(' '))
  end

  def notes_from_note_array(note_array)
    note_array.collect do |note|
      case note
      when String then Note.new(note)
      when Note   then note
      end
    end
  end
end
