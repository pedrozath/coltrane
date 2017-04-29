class ChordQuality
  attr_reader :name

  CHORD_QUALITIES = {
    [0,4,7]    => 'M',
    [0,3,7]    => 'm',
    [0,4,8]    => '+',
    [0,4,6]    => 'dim',
    [0,3,6,11] => 'dim7',
    [0,3,6,10] => 'm7b5',
    [0,3,7,10] => 'min7',
    [0,3,7,11] => 'mM7',
    [0,4,7,10] => '7',
    [0,3,8,10] => '+7',
    [0,4,8,11] => '+M7'
  }

  def initialize(note_intervals)
    @name = CHORD_QUALITIES[note_intervals] || "(#{note_intervals.join(' ')})"
  end

  def self.new_from_notes(notes)
    notes = NoteSet.new(notes) unless notes.class == NoteSet
    self.new(notes.intervals)
  end

  def self.new_from_pitches(*pitches)
    notes = pitches.sort_by(&:number)
                     .collect(&:note)
                     .collect(&:name)
                     .uniq

    self.new_from_notes(notes)
  end
end