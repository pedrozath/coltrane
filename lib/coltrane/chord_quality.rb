class ChordQuality
  attr_reader :name

  CHORD_QUALITIES = {
    [0, 4, 7]    => 'M',
    [0, 3, 7]    => 'm',
    [0, 4, 8]    => '+',
    [0, 4, 6]    => 'dim',
    [0, 3, 6, 11] => 'dim7',
    [0, 3, 6, 10] => 'm7b5',
    [0, 3, 7, 10] => 'min7',
    [0, 3, 7, 11] => 'mM7',
    [0, 4, 7, 10] => '7',
    [0, 3, 8, 10] => '+7',
    [0, 4, 8, 11] => '+M7'
  }.freeze

  def initialize(interval_sequence)
    if interval_sequence.class != IntervalSequence
      interval_sequence = IntervalSequence.new(interval_sequence)
    end

    @name = find_chord_name(interval_sequence)
  end

  def self.new_from_notes(notes)
    note_set = NoteSet.new(notes) unless notes.class == NoteSet
    new(note_set.interval_sequence)
  end

  def self.new_from_pitches(*pitches)
    notes = pitches.sort_by(&:number)
                   .collect(&:note)
                   .collect(&:name)
                   .uniq

    new_from_notes(notes)
  end

  def self.new_from_string(quality_string)
    new(CHORD_QUALITIES.key(quality_string))
  end

  protected

  def find_chord_name(note_intervals, inversion = 0)
    inversion >= note_intervals.all.size && return
    CHORD_QUALITIES[note_intervals.numbers] ||
      CHORD_QUALITIES[note_intervals.numbers.sort] ||
      find_chord_name(note_intervals.next_inversion, inversion + 1) ||
      "(#{note_intervals.numbers.sort.join(' ')})"
  end
end
