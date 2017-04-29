class ChordQuality
  attr_reader :name

  CHORD_QUALITIES = {
    'C E G'      => 'M',
    'C Eb G'     => 'm',
    'C E G#'     => '+',
    'C E Gb'     => 'dim',
    'C Eb Gb B'  => 'dim7',
    'C Eb Gb Bb' => 'm7b5',
    'C Eb G Bb'  => 'min7',
    'C Eb G B'   => 'mM7',
    'C E G Bb'   => '7',
    'C Eb G# Bb' => '+7',
    'C E G# B'   => '+M7'
  }

  def initialize(notes_transposed_to_c)
    @name = CHORD_QUALITIES[notes_transposed_to_c.join(' ')]
  end

  def self.new_from_notes(note_array)
    notes                 = NoteSet.new(note_array) unless notes.class == NoteSet
    notes_transposed_to_c = notes.transpose_to('C').collect(&:name)
    self.new notes_transposed_to_c
  end

  def self.new_from_pitches(*pitches)
    self.new_from_notes pitches.sort_by(&:number).collect(&:note).collect(&:name).uniq
  end
end